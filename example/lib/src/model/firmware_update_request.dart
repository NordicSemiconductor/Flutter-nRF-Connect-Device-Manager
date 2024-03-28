import 'dart:typed_data';

import 'package:mcumgr_flutter/mcumgr_flutter.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_image.dart';

class FirmwareUpdateRequest {
  SelectedFirmware? firmware;
  SelectedPeripheral? peripheral;

  FirmwareUpdateRequest({
    this.firmware,
    this.peripheral,
  });
}

class SingleImageFirmwareUpdateRequest extends FirmwareUpdateRequest {
  Uint8List? get firmwareImage =>
      firmware is LocalFirmware ? (firmware as LocalFirmware).data : null;

  SingleImageFirmwareUpdateRequest({
    super.peripheral,
    super.firmware,
  });
}

class MultiImageFirmwareUpdateRequest extends FirmwareUpdateRequest {
  Uint8List? zipFile;
  List<Image>? firmwareImages;

  RemoteFirmware? get remoteFirmware => firmware as RemoteFirmware?;

  MultiImageFirmwareUpdateRequest(
      {this.zipFile, this.firmwareImages, super.peripheral, super.firmware});
}

class SelectedFirmware {
  String get name => toString();
}

class RemoteFirmware extends SelectedFirmware {
  final Application application;
  final Version version;
  final Board board;
  final BuildConfig firmware;

  @override
  String get name => '${application.appName} ${version.version}';

  RemoteFirmware({
    required this.application,
    required this.version,
    required this.board,
    required this.firmware,
  });

  @override
  String toString() {
    return 'SelectedFirmware{application: $application, version: $version, board: $board, firmware: $firmware}';
  }
}

enum FirmwareType {
  singleImage,
  multiImage,
}

class LocalFirmware extends SelectedFirmware {
  final String name;
  final Uint8List data;
  final FirmwareType type;

  LocalFirmware({
    required this.name,
    required this.data,
    required this.type,
  });
}

class SelectedPeripheral {
  final String name;
  final String identifier;

  SelectedPeripheral({
    required this.name,
    required this.identifier,
  });
}
