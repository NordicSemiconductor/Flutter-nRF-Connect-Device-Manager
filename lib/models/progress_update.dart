class ProgressUpdate {
  final int bytesSent;
  final int imageSize;
  final DateTime date;

  const ProgressUpdate(this.bytesSent, this.imageSize, this.date);
}

class FirmwareUpgradeState {
  const FirmwareUpgradeState();

  static const none = FirmwareUpgradeState();
  static const validate = FirmwareUpgradeState();
  static const upload = FirmwareUpgradeState();
  static const test = FirmwareUpgradeState();
  static const reset = FirmwareUpgradeState();
  static const confirm = FirmwareUpgradeState();
  static const success = FirmwareUpgradeState();
}
