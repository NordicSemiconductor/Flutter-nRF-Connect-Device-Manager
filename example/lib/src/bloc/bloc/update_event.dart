part of 'update_bloc.dart';

@immutable
sealed class UpdateEvent {}

class BeginUpdateProcess extends UpdateEvent {}

class DownloadStarted extends UpdateEvent {}

class UnpackStarted extends UpdateEvent {}

class UploadState extends UpdateEvent {
  final String state;

  UploadState(this.state);
}

class UploadProgress extends UploadState {
  final int progress;

  UploadProgress({required String stage, required this.progress}) : super(stage);
}

class UploadFinished extends UpdateEvent {}

class UploadFailed extends UpdateEvent {
  final String error;

  UploadFailed(this.error);
}

class FirmwareSelected extends UpdateEvent {
  final SelectedFirmware firmware;

  FirmwareSelected(this.firmware);
}

class PeripheralSelected extends UpdateEvent {
  final SelectedPeripheral peripheral;

  PeripheralSelected(this.peripheral);
}

class ResetUpdate extends UpdateEvent {}