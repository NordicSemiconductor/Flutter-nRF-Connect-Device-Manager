import 'package:flutter/material.dart';
import 'package:mcumgr_flutter_example/src/bloc/bloc/update_bloc.dart' as b;
import 'package:mcumgr_flutter_example/src/handlers/firmware_update_handler.dart';

import '../model/firmware_update_request.dart';

class _StateConverter {
  static b.UpdateEvent convert(FirmwareUpdateState state) {
    return switch (state) {
      FirmwareDownloadStarted() => b.DownloadStarted(),
      FirmwareDownloadFinished() => b.DownloadFinished(),
      FirmwareUnpackStarted() => b.UnpackStarted(),
      FirmwareUnpackFinished() => b.UnpackFinished(),
      FirmwareUploadStarted() => b.UploadStarted(),
      FirmwareUploadProgress(progress: var progress) =>
        b.UploadProgress(progress),
      FirmwareUploadFinished() => b.UploadFinished(),
    };
  }
}

class FirmwareUpdateRequestProvider extends ChangeNotifier {
  FirmwareUpdateRequest _updateParameters = FirmwareUpdateRequest();
  b.UpdateBloc _updateBloc = b.UpdateBloc();

  FirmwareUpdateRequest get updateParameters => _updateParameters;
  b.UpdateBloc get updateBloc => _updateBloc;

  void setFirmware(SelectedFirmware? firmware) {
    _updateParameters.firmware = firmware;
    notifyListeners();
  }

  void setPeripheral(SelectedPeripheral peripheral) {
    _updateParameters.peripheral = peripheral;
    notifyListeners();
  }

  FirmwareUpdateHandler createFirmwareUpdateHandler() {
    FirmwareUpdateHandler handler = FirmwareDownloader();
    handler.setNextHandler(FirmwareUnpacker());
    handler.setNextHandler(FirmwareUpdater());

    handler.callback = (FirmwareUpdateState state) {
      b.UpdateEvent event = _StateConverter.convert(state);
      _updateBloc.add(event);
    };

    return handler;
  }
}
