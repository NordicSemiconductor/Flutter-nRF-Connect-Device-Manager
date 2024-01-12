import 'package:flutter/material.dart';

import '../model/firmware_update_request.dart';

class FirmwareUpdateRequestProvider extends ChangeNotifier {
  FirmwareUpdateRequest _updateParameters = FirmwareUpdateRequest();
  FirmwareUpdateRequest get updateParameters => _updateParameters;
  int currentStep = 0;

  void setFirmware(SelectedFirmware? firmware) {
    if (firmware == null) {
      _updateParameters =
          FirmwareUpdateRequest(peripheral: _updateParameters.peripheral);
      return;
    }

    if (firmware is RemoteFirmware) {
      _updateParameters = MultiImageFirmwareUpdateRequest(
        peripheral: _updateParameters.peripheral,
        firmware: firmware,
      );
    } else if (firmware is LocalFirmware) {
      if (firmware.type == FirmwareType.singleImage) {
        _updateParameters = SingleImageFirmwareUpdateRequest(
          peripheral: _updateParameters.peripheral,
          firmware: firmware,
        );
      } else {
        _updateParameters = MultiImageFirmwareUpdateRequest(
          peripheral: _updateParameters.peripheral,
          firmware: firmware,
        );
      }
    }

    notifyListeners();
  }

  void setPeripheral(SelectedPeripheral peripheral) {
    _updateParameters.peripheral = peripheral;
    notifyListeners();
  }

  void reset() {
    _updateParameters = FirmwareUpdateRequest();
    currentStep = 0;
    notifyListeners();
  }

  void nextStep() {
    if (currentStep == 2) {
      return;
    }
    currentStep++;
    notifyListeners();
  }

  void previousStep() {
    if (currentStep == 0) {
      return;
    }
    currentStep--;
    notifyListeners();
  }
}
