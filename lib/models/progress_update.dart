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

  @override
  String toString() {
    return _rawValue;
  }
}
