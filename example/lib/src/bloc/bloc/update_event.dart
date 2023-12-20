part of 'update_bloc.dart';

@immutable
sealed class UpdateEvent {}

class DownloadStarted extends UpdateEvent {}
class DownloadFinished extends UpdateEvent {}
class UnpackStarted extends UpdateEvent {}
class UnpackFinished extends UpdateEvent {}
class UploadStarted extends UpdateEvent {}
class UploadProgress extends UpdateEvent {
  final int progress;

  UploadProgress(this.progress);
}
class UploadFinished extends UpdateEvent {}