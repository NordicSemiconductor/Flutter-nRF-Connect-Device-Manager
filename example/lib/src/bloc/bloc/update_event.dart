part of 'update_bloc.dart';

@immutable
sealed class UpdateEvent {}

class BeginUpdateProcess extends UpdateEvent {}

class DownloadStarted extends UpdateEvent {}

class UnpackStarted extends UpdateEvent {}

class UploadStarted extends UpdateEvent {
  final int progress;

  UploadStarted({this.progress = 0});
}

class UploadProgress extends UpdateEvent {
  final String stage;
  final int progress;

  UploadProgress({required this.stage, this.progress = 0});
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
