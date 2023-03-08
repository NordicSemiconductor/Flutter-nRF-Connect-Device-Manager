import 'package:mcumgr_flutter/mcumgr_flutter.dart';
import 'package:mcumgr_flutter/models/image_upload_alignment.dart';
import '../flutter_mcu.pb.dart';
import 'package:fixnum/fixnum.dart';

extension ProtoProgressToModel on ProtoProgressUpdate {
  ProgressUpdate convert() {
    final int bytesSent = (this.bytesSent).toInt();
    final int imageSize = (this.imageSize).toInt();
    final int milliseconds = (this.timestamp * 1000).toInt();
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
      case (ProtoUpdateStateChanges_FirmwareUpgradeState
          .REQUEST_MCU_MGR_PARAMETERS):
        return FirmwareUpgradeState.requestMcuMgrParameters;
      case (ProtoUpdateStateChanges_FirmwareUpgradeState.ERASE_APP_SETTINGS):
        return FirmwareUpgradeState.eraseAppSettings;
      default:
        throw "Unsupported state";
    }
  }
}

extension ProtoLogMessageToModel on ProtoLogMessage {
  McuLogMessage convent() {
    return McuLogMessage(
        message,
        conventCategory(this.logCategory),
        conventLevel(this.logLevel),
        DateTime.fromMillisecondsSinceEpoch(this.logDateTime.toInt()));
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

extension ProtoFirmwareUpgradeConfiguration_ImageUploadAlignmentToModel
    on ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment {
  ImageUploadAlignment convent() {
    switch (this) {
      case ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment.DISABLED:
        return ImageUploadAlignment.disabled;
      case ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment.TWO_BYTE:
        return ImageUploadAlignment.twoByte;
      case ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment.FOUR_BYTE:
        return ImageUploadAlignment.fourByte;
      case ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment.EIGHT_BYTE:
        return ImageUploadAlignment.eightByte;
      case ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment.SIXTEEN_BYTE:
        return ImageUploadAlignment.sixteenByte;
      default:
        throw 'Unsupported ImageUploadAlignment';
    }
  }
}

extension ImageUploadAlignmentModel on ImageUploadAlignment {
  ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment convent() {
    switch (this) {
      case ImageUploadAlignment.disabled:
        return ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment.DISABLED;
      case ImageUploadAlignment.twoByte:
        return ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment.TWO_BYTE;
      case ImageUploadAlignment.fourByte:
        return ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment.FOUR_BYTE;
      case ImageUploadAlignment.eightByte:
        return ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment.EIGHT_BYTE;
      case ImageUploadAlignment.sixteenByte:
        return ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment.SIXTEEN_BYTE;
      default:
        throw 'Unsupported ImageUploadAlignment';
    }
  }
}

extension FirmwareUpgradeConfigurationToModel on FirmwareUpgradeConfiguration {
  ProtoFirmwareUpgradeConfiguration proto() => ProtoFirmwareUpgradeConfiguration(
        estimatedSwapTimeMs: Int64(this.estimatedSwapTime.inMilliseconds),
        eraseAppSettings: this.eraseAppSettings,
        pipelineDepth: Int64(this.pipelineDepth),
        byteAlignment: this.byteAlignment.convent(),
        reassemblyBufferSize: Int64(this.reassemblyBufferSize),
      );
}

extension ProtoFirmwareUpgradeConfigurationToModel
    on ProtoFirmwareUpgradeConfiguration {
  FirmwareUpgradeConfiguration convert() => FirmwareUpgradeConfiguration(
    estimatedSwapTime: Duration(milliseconds: this.estimatedSwapTimeMs as int),
    eraseAppSettings: this.eraseAppSettings,
    pipelineDepth: this.pipelineDepth as int,
    byteAlignment: this.byteAlignment.convent(),
    reassemblyBufferSize: this.reassemblyBufferSize as int,
  );
}