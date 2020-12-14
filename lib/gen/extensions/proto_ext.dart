import 'package:mcumgr_flutter/gen/flutter_mcu.pb.dart';
import 'package:mcumgr_flutter/src/progress_update.dart';

extension ProtoProgressToModel on ProtoProgressUpdate {
  ProgressUpdate convert() {
    final int bytesSent = this.bytesSent as int;
    final int imageSize = this.imageSize as int;
    final int milliseconds = (this.timestamp * 1000) as int;
    final date = DateTime.fromMillisecondsSinceEpoch(milliseconds);

    return ProgressUpdate(bytesSent, imageSize, date);
  }
}

extension ProtoUpdateStateToModel
    on ProtoUpdateStateChanges_FirmwareUpgradeState {
  FirmwareUpgradeState convert() {
    switch (this) {
      case (ProtoUpdateStateChanges_FirmwareUpgradeState.NONE):
        return FirmwareUpgradeState.none;
      case (ProtoUpdateStateChanges_FirmwareUpgradeState.VALIDATE):
        return FirmwareUpgradeState.validate;
      case (ProtoUpdateStateChanges_FirmwareUpgradeState.UPLOAD):
        return FirmwareUpgradeState.upload;
      case (ProtoUpdateStateChanges_FirmwareUpgradeState.TEST):
        return FirmwareUpgradeState.test;
      case (ProtoUpdateStateChanges_FirmwareUpgradeState.RESET):
        return FirmwareUpgradeState.reset;
      case (ProtoUpdateStateChanges_FirmwareUpgradeState.CONFIRM):
        return FirmwareUpgradeState.confirm;
      case (ProtoUpdateStateChanges_FirmwareUpgradeState.SUCCESS):
        return FirmwareUpgradeState.success;
      default:
        throw "Unsupported state";
    }
  }
}
