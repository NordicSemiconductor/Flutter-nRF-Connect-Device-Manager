part of mcumgr_flutter;

class ProgressUpdate {
  final int bytesSent;
  final int imageSize;
  final DateTime date;

  const ProgressUpdate(this.bytesSent, this.imageSize, this.date);
}

class FirmwareUpgradeState {
  final String _rawValue;

  const FirmwareUpgradeState(this._rawValue);

  static const none = FirmwareUpgradeState("None");
  static const validate = FirmwareUpgradeState("Validate");
  static const upload = FirmwareUpgradeState("Upload");
  static const test = FirmwareUpgradeState("Test");
  static const reset = FirmwareUpgradeState("Reset");
  static const confirm = FirmwareUpgradeState("Confirm");
  static const success = FirmwareUpgradeState("Success");
  static const requestMcuMgrParameters = FirmwareUpgradeState("Request McuMgr parameters");
  static const eraseAppSettings = FirmwareUpgradeState("Erase app settings");

  static const values = [
    FirmwareUpgradeState.validate,
    FirmwareUpgradeState.upload,
    FirmwareUpgradeState.test,
    FirmwareUpgradeState.reset,
    FirmwareUpgradeState.confirm,
    FirmwareUpgradeState.success,
    FirmwareUpgradeState.requestMcuMgrParameters,
    FirmwareUpgradeState.eraseAppSettings
  ];

  @override
  String toString() {
    return _rawValue;
  }
}
