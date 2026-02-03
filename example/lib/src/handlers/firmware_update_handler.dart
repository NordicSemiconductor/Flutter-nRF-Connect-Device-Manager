import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;
import 'package:mcumgr_flutter/mcumgr_flutter.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_update_request.dart';
import 'package:mcumgr_flutter_example/src/model/manifest.dart';
import 'package:mcumgr_flutter_example/src/repository/firmware_image_repository.dart';

part 'firmware_update_state.dart';

typedef FirmwareUpdateCallback = void Function(FirmwareUpdateState state);

abstract class FirmwareUpdateHandler {
  FirmwareUpdateHandler? _nextHandler;
  Future<FirmwareUpdateManager> handleFirmwareUpdate(
    FirmwareUpdateRequest request,
    FirmwareUpdateCallback? callback,
  );

  Future<void> setNextHandler(FirmwareUpdateHandler handler) async {
    _nextHandler = handler;
  }
}

class FirmwareDownloader extends FirmwareUpdateHandler {
  @override
  Future<FirmwareUpdateManager> handleFirmwareUpdate(
    FirmwareUpdateRequest request,
    FirmwareUpdateCallback? callback,
  ) async {
    if (request.firmware is LocalFirmware) {
      if (request is MultiImageFirmwareUpdateRequest) {
        request.zipFile = (request.firmware as LocalFirmware).data;
      }
      return await _nextHandler!.handleFirmwareUpdate(request, callback);
    }

    final multiImageRequest = request as MultiImageFirmwareUpdateRequest;

    callback?.call(FirmwareDownloadStarted());

    if (request.firmware == null) {
      throw Exception('Firmware is not selected');
    }

    final remoteFirmware = multiImageRequest.remoteFirmware!;

    final response = await http.get(
      Uri.parse(
        '${FirmwareImageRepository.baseUrl}${remoteFirmware.firmware.file}',
      ),
    );
    if (response.statusCode == 200) {
      multiImageRequest.zipFile = response.bodyBytes;
    } else {
      throw Exception('Failed to download firmware');
    }

    return await _nextHandler!.handleFirmwareUpdate(
      multiImageRequest,
      callback,
    );
  }
}

class FirmwareUnpacker extends FirmwareUpdateHandler {
  @override
  Future<FirmwareUpdateManager> handleFirmwareUpdate(
    FirmwareUpdateRequest request,
    FirmwareUpdateCallback? callback,
  ) async {
    callback?.call(FirmwareUnpackStarted());

    if (request.firmware == null) {
      throw Exception('Firmware is not selected');
    }

    if (request is SingleImageFirmwareUpdateRequest) {
      return await _nextHandler!.handleFirmwareUpdate(request, callback);
    }

    final firmware = request as MultiImageFirmwareUpdateRequest;
    final firmwareFileData = firmware.zipFile!;
    final archive = ZipDecoder().decodeBytes(firmwareFileData);

    // read manifest.json
    final manifestFileEntry = archive.findFile('manifest.json');
    if (manifestFileEntry == null) {
      throw Exception('manifest.json not found in zip');
    }

    final manifestString = utf8.decode(manifestFileEntry.content as List<int>);
    Map<String, dynamic> manifestJson = json.decode(manifestString);
    Manifest manifest;

    try {
      manifest = Manifest.fromJson(manifestJson);
    } catch (e) {
      throw Exception('Failed to parse manifest.json');
    }

    firmware.firmwareImages = [];
    for (final file in manifest.files) {
      final firmwareFileEntry = archive.findFile(file.file);
      if (firmwareFileEntry == null) {
        throw Exception('File ${file.file} not found in zip');
      }
      final firmwareFileData = firmwareFileEntry.content as List<int>;
      final image = Image(
        image: file.image,
        data: Uint8List.fromList(firmwareFileData),
      );
      firmware.firmwareImages!.add(image);
    }

    return await _nextHandler!.handleFirmwareUpdate(request, callback);
  }
}

class FirmwareUpdater extends FirmwareUpdateHandler {
  final UpdateManagerFactory _updateManagerFactory =
      FirmwareUpdateManagerFactory();

  @override
  Future<FirmwareUpdateManager> handleFirmwareUpdate(
    FirmwareUpdateRequest request,
    FirmwareUpdateCallback? callback,
  ) async {
    callback?.call(FirmwareUploadStarted());

    if (request.peripheral == null) {
      throw Exception('Peripheral is not selected');
    }

    final updateManager = await _updateManagerFactory.getUpdateManager(
      request.peripheral!.identifier,
    );

    updateManager.setup();

    if (request is SingleImageFirmwareUpdateRequest) {
      final fwImage = request.firmwareImage;
      await updateManager.updateWithImageData(imageData: fwImage!);
      return updateManager;
    } else {
      final multiImageRequest = request as MultiImageFirmwareUpdateRequest;
      updateManager.update(multiImageRequest.firmwareImages!);
    }

    return updateManager;
  }
}
