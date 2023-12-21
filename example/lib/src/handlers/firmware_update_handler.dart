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
    await Future.delayed(Duration(seconds: 1));
    request.zipFile = Uint8List(0);

    if (_nextHandler != null) {
      _nextHandler!.callback = callback;
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
    await Future.delayed(Duration(seconds: 1));
    callback?.call(FirmwareUnpackStarted());
    // TODO: Unzip firmware
    await Future.delayed(Duration(seconds: 1));
    request.firmwareImages = {};

    if (_nextHandler != null) {
      _nextHandler!.callback = callback;
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

    await Future.delayed(Duration(seconds: 1));

    callback?.call(FirmwareUploadStarted());
    await Future.delayed(Duration(seconds: 1));
    // TODO: Upload firmware
    callback?.call(FirmwareUploadFinished());
  }
}
