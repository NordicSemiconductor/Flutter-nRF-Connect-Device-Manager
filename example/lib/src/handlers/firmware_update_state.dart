part of 'firmware_update_handler.dart';

sealed class FirmwareUpdateState {}

class FirmwareDownloadStarted extends FirmwareUpdateState {}
// class FirmwareDownloadFinished extends FirmwareUpdateState {}

class FirmwareUnpackStarted extends FirmwareUpdateState {}
// class FirmwareUnpackFinished extends FirmwareUpdateState {}

class FirmwareUploadStarted extends FirmwareUpdateState {}

class FirmwareUploadProgress extends FirmwareUpdateState {
  final int progress;

  FirmwareUploadProgress(this.progress);
}

class FirmwareUploadFinished extends FirmwareUpdateState {}
