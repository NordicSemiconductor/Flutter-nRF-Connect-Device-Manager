import 'package:flutter/material.dart';
import 'package:mcumgr_flutter/gen/flutter_mcu.pb.dart';
import 'package:mcumgr_flutter/models/mcu_log_message.dart';
import 'package:mcumgr_flutter/models/progress_update.dart';

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

extension ProtoLogMessageToModel on ProtoLogMessage {
  McuLogMessage convent() {
    return McuLogMessage(message, conventCategory(this.logCategory),
        conventLevel(this.logLevel));
  }

  McuMgrLogLevel conventLevel(ProtoLogMessage_LogLevel level) {
    switch (level) {
      case ProtoLogMessage_LogLevel.DEBUG:
        return McuMgrLogLevel.debug;
      case ProtoLogMessage_LogLevel.VERBOSE:
        return McuMgrLogLevel.verbose;
      case ProtoLogMessage_LogLevel.INFO:
        return McuMgrLogLevel.info;
      case ProtoLogMessage_LogLevel.APPLICATION:
        return McuMgrLogLevel.application;
      case ProtoLogMessage_LogLevel.WARNING:
        return McuMgrLogLevel.warning;
      case ProtoLogMessage_LogLevel.ERROR:
        return McuMgrLogLevel.error;
      default:
        throw 'Unsupported log level';
    }
  }

  McuMgrLogCategory conventCategory(ProtoLogMessage_LogCategory category) {
    switch (category) {
      case ProtoLogMessage_LogCategory.TRANSPORT:
        return McuMgrLogCategory.transport;
      case ProtoLogMessage_LogCategory.CONFIG:
        return McuMgrLogCategory.config;
      case ProtoLogMessage_LogCategory.CRASH:
        return McuMgrLogCategory.crash;
      case ProtoLogMessage_LogCategory.DEFAULT:
        return McuMgrLogCategory.defaultLevel;
      case ProtoLogMessage_LogCategory.FS:
        return McuMgrLogCategory.fs;
      case ProtoLogMessage_LogCategory.IMAGE:
        return McuMgrLogCategory.image;
      case ProtoLogMessage_LogCategory.LOG:
        return McuMgrLogCategory.log;
      case ProtoLogMessage_LogCategory.RUN_TEST:
        return McuMgrLogCategory.runTest;
      case ProtoLogMessage_LogCategory.STATS:
        return McuMgrLogCategory.stats;
      case ProtoLogMessage_LogCategory.DFU:
        return McuMgrLogCategory.dfu;
      default:
        throw 'Unsupported Category';
    }
  }
}
