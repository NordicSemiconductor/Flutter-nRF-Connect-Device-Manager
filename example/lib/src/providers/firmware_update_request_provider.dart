import 'package:flutter/material.dart';

import '../model/firmware_update_request.dart';

class FirmwareUpdateRequestProvider extends ChangeNotifier {
  FirmwareUpdateRequest _updateParameters = FirmwareUpdateRequest();
  FirmwareUpdateRequest get updateParameters => _updateParameters;
  int currentStep = 0;

  void setFirmware(SelectedFirmware? firmware) {
    _updateParameters.firmware = firmware;
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
