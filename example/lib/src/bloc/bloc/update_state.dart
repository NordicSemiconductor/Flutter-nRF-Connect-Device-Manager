part of 'update_bloc.dart';

@immutable
sealed class UpdateState extends Equatable {}

final class UpdateInitial extends UpdateState {
  @override
  List<Object?> get props => [true];
}

class UpdateFirmware extends UpdateState {
  final String stage;

  UpdateFirmware(this.stage);

  @override
  List<Object?> get props => [stage];
}

final class UpdateProgressFirmware extends UpdateFirmware {
  final int progress;

  UpdateProgressFirmware(String state, this.progress) : super(state);

  @override
  List<Object?> get props => [stage, progress];
}

final class UpdateCompleteSuccess extends UpdateFirmware {
  UpdateCompleteSuccess() : super("Update complete");
}

final class UpdateCompleteFailure extends UpdateFirmware {
  final String error;

  UpdateCompleteFailure(this.error) : super("Update failed");

  @override
  List<Object?> get props => [stage, error];
}

class UpdateFirmwareStateHistory extends UpdateState {
  final UpdateFirmware? currentState;
  final List<UpdateFirmware> history;
  final bool isComplete;
  final FirmwareUpdateManager? updateManager;

  UpdateFirmwareStateHistory(this.currentState, this.history,
      {this.isComplete = false, this.updateManager});

  @override
  List<Object?> get props => [currentState, history];
}
