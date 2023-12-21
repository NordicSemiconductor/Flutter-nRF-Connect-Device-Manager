part of 'update_bloc.dart';

@immutable
sealed class UpdateEvent {}

class BeginUpdateProcess extends UpdateEvent {}

class DownloadStarted extends UpdateEvent {}

class UnpackStarted extends UpdateEvent {}

class UploadStarted extends UpdateEvent {}

class UploadProgress extends UpdateEvent {
  final int progress;

  UploadProgress(this.progress);
}

class UploadFinished extends UpdateEvent {}

class FirmwareSelected extends UpdateEvent {
  final SelectedFirmware firmware;

  FirmwareSelected(this.firmware);
}

class PeripheralSelected extends UpdateEvent {
  final SelectedPeripheral peripheral;

  PeripheralSelected(this.peripheral);
}
