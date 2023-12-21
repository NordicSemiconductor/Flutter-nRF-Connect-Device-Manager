import 'package:flutter/material.dart';

import '../model/firmware_update_request.dart';

class FirmwareUpdateRequestProvider extends ChangeNotifier {
  FirmwareUpdateRequest _updateParameters = FirmwareUpdateRequest();
  FirmwareUpdateRequest get updateParameters => _updateParameters;

  void setFirmware(SelectedFirmware? firmware) {
    _updateParameters.firmware = firmware;
    notifyListeners();
  }

  void setPeripheral(SelectedPeripheral peripheral) {
    _updateParameters.peripheral = peripheral;
    notifyListeners();
  }
}
