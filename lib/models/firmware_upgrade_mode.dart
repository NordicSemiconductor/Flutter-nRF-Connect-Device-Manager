class FirmwareUpgradeMode {
  final int rawValue;

  const FirmwareUpgradeMode._(this.rawValue);

  /// When this mode is set, the manager will send the test and reset commands
  /// to the device after the upload is complete. The device will reboot and
  /// will run the new image on its next boot. If the new image supports
  /// auto-confirm feature, it will try to confirm itself and change state to
  /// permanent. If not, test image will run just once and will be swapped
  /// again with the original image on the next boot.
  ///
  /// Use this mode if you just want to test the image, when it can confirm
  /// itself.
  static const FirmwareUpgradeMode testOnly = const FirmwareUpgradeMode._(0);

  /// When this flag is set, the manager will send confirm and reset commands
  /// immediately after upload.
  ///
  /// Use this mode if when the new image does not support both auto-confirm
  /// feature and SMP service and could not be confirmed otherwise.
  static const FirmwareUpgradeMode confirmOnly = const FirmwareUpgradeMode._(1);

  /// When this flag is set, the manager will first send test followed by
  /// reset commands, then it will reconnect to the new application and will
  /// send confirm command.
  ///
  /// Use this mode when the new image supports SMP service and you want to
  /// test it before confirming.
  static const FirmwareUpgradeMode testAndConfirm =
      const FirmwareUpgradeMode._(2);

  /// Upload Only is a very particular mode. It ignores Bootloader Info, does not
  /// test nor confirm any uploded images. It does list/verify, proceed to upload
  /// the images, and reset. It is not recommended for use, except perhaps for
  /// DirectXIP use cases where the Bootloader is unreliable.
  static const FirmwareUpgradeMode uploadOnly = const FirmwareUpgradeMode._(3);
}
