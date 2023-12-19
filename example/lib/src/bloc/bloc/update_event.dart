part of 'update_bloc.dart';

@immutable
sealed class UpdateEvent {}

class StatusUpdateEvent extends UpdateEvent {
  final String status;
  final int? progress;

  StatusUpdateEvent(this.status, this.progress);
}