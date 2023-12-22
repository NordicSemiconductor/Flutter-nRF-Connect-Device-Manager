import 'dart:convert';
import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_update_request.dart';
import 'package:mcumgr_flutter_example/src/model/manifest.dart';
import 'package:mcumgr_flutter_example/src/repository/firmware_image_repository.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:uuid/uuid.dart';

part 'firmware_update_state.dart';

typedef FirmwareUpdateCallback = void Function(FirmwareUpdateState state);

abstract class FirmwareUpdateHandler {
  FirmwareUpdateHandler? _nextHandler;
  Future<void> handleFirmwareUpdate(
      FirmwareUpdateRequest request, FirmwareUpdateCallback? callback);

  Future<void> setNextHandler(FirmwareUpdateHandler handler) async {
    _nextHandler = handler;
  }
}

class FirmwareDownloader extends FirmwareUpdateHandler {
  @override
  Future<void> handleFirmwareUpdate(
      FirmwareUpdateRequest request, FirmwareUpdateCallback? callback) async {
    callback?.call(FirmwareDownloadStarted());

    if (request.firmware == null) {
      throw Exception('Firmware is not selected');
    }

    final response = await http.get(Uri.parse(
        '${FirmwareImageRepository.baseUrl}${request.firmware!.firmware.file}'));
    if (response.statusCode == 200) {
      request.zipFile = response.bodyBytes;
    } else {
      throw Exception('Failed to download firmware');
    }

    if (_nextHandler != null) {
      await _nextHandler!.handleFirmwareUpdate(request, callback);
    }
  }
}

class FirmwareUnpacker extends FirmwareUpdateHandler {
  @override
  Future<void> handleFirmwareUpdate(
      FirmwareUpdateRequest request, FirmwareUpdateCallback? callback) async {
    callback?.call(FirmwareUnpackStarted());

    if (request.firmware == null) {
      throw Exception('Firmware is not selected');
    }

    final prefix = 'firmware_${Uuid().v4()}';
    final systemTempDir = await path_provider.getTemporaryDirectory();

    final tempDir = Directory('${systemTempDir.path}/$prefix');
    await tempDir.create();

    final firmwareFileData = request.zipFile!;
    final firmwareFile = File('${tempDir.path}/firmware.zip');
    await firmwareFile.writeAsBytes(firmwareFileData);

    final destinationDir = Directory('${tempDir.path}/firmware');
    await destinationDir.create();
    try {
      await ZipFile.extractToDirectory(
          zipFile: firmwareFile, destinationDir: destinationDir);
    } catch (e) {
      throw Exception('Failed to unzip firmware');
    }

    // read manifest.json
    final manifestFile = File('${destinationDir.path}/manifest.json');
    final manifestString = await manifestFile.readAsString();
    Map<String, dynamic> manifestJson = json.decode(manifestString);
    Manifest manifest;

    try {
      manifest = Manifest.fromJson(manifestJson);
    } catch (e) {
      throw Exception('Failed to parse manifest.json');
    }

    request.firmwareImages = {};
    for (final file in manifest.files) {
      final firmwareFile = File('${destinationDir.path}/${file.file}');
      final firmwareFileData = await firmwareFile.readAsBytes();
      request.firmwareImages![file.image] = firmwareFileData;
    }

    // delete tempDir
    await tempDir.delete(recursive: true);

    if (_nextHandler != null) {
      await _nextHandler!.handleFirmwareUpdate(request, callback);
    }
  }
}

class FirmwareUpdater extends FirmwareUpdateHandler {
  @override
  Future<void> handleFirmwareUpdate(
      FirmwareUpdateRequest request, FirmwareUpdateCallback? callback) async {
    if (request.firmware == null) {
      throw Exception('Firmware is not selected');
    }

    callback?.call(FirmwareUploadStarted());
    await Future.delayed(Duration(seconds: 1));

    await Future.delayed(Duration(seconds: 1));
    // TODO: Upload firmware
    callback?.call(FirmwareUploadFinished());
  }
}
