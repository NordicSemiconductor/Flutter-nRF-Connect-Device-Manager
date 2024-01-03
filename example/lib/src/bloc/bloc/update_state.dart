part of 'update_bloc.dart';

@immutable
sealed class UpdateState {}

final class UpdateInitial extends UpdateState {}

class UpdateFirmware extends UpdateState {
  final String state;

  UpdateFirmware(this.state);
}

final class UpdateProgressFirmware extends UpdateFirmware {
  final int progress;

  UpdateProgressFirmware(String state, this.progress) : super(state);
}

class UpdateFirmwareStateHistory extends UpdateState {
  final UpdateFirmware currentState;
  final List<UpdateFirmware> history;

  UpdateFirmwareStateHistory(this.currentState, this.history);
}
