import 'package:flutter/material.dart';

import '../model/update_parameters.dart';

class UpdateParametersProvider extends ChangeNotifier {
  UpdateParameters _updateParameters = UpdateParameters();

  UpdateParameters get updateParameters => _updateParameters;

  UpdateParameters get value => _updateParameters;

  void setFirmware(SelectedFirmware firmware) {
    _updateParameters.firmware = firmware;
    notifyListeners();
  }
}
