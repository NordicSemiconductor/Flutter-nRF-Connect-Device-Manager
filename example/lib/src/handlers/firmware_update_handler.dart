import 'dart:typed_data';

import 'package:mcumgr_flutter_example/src/bloc/bloc/update_bloc.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_update_request.dart';

part 'firmware_update_state.dart';

typedef FirmwareUpdateCallback = void Function(FirmwareUpdateState state);

abstract class FirmwareUpdateHandler {
  FirmwareUpdateHandler? _nextHandler;
  Future<void> handleFirmwareUpdate(FirmwareUpdateRequest request);
  FirmwareUpdateCallback? callback;
  Future<void> setNextHandler(FirmwareUpdateHandler handler) async {
    _nextHandler = handler;
  }
}

class FirmwareDownloader extends FirmwareUpdateHandler {
  @override
  Future<void> handleFirmwareUpdate(FirmwareUpdateRequest request) async {
    if (request.firmware == null) {
      throw Exception('Firmware is not selected');
    }

    callback?.call(FirmwareDownloadStarted());
    // TODO: Download firmware
    request.zipFile = Uint8List(0);
    callback?.call(FirmwareDownloadFinished());

    if (_nextHandler != null) {
      await _nextHandler!.handleFirmwareUpdate(request);
    }
  }
}

class FirmwareUnpacker extends FirmwareUpdateHandler {
  @override
  Future<void> handleFirmwareUpdate(FirmwareUpdateRequest request) async {
    if (request.firmware == null) {
      throw Exception('Firmware is not selected');
    }

    callback?.call(FirmwareUnpackStarted());
    // TODO: Unzip firmware
    request.firmwareImages = {};
    callback?.call(FirmwareUnpackFinished());

    if (_nextHandler != null) {
      await _nextHandler!.handleFirmwareUpdate(request);
    }
  }
}

class FirmwareUpdater extends FirmwareUpdateHandler {
  @override
  Future<void> handleFirmwareUpdate(FirmwareUpdateRequest request) async {
    if (request.firmware == null) {
      throw Exception('Firmware is not selected');
    }

    callback?.call(FirmwareUploadStarted());
    // TODO: Upload firmware
    callback?.call(FirmwareUploadFinished());
  }
}
