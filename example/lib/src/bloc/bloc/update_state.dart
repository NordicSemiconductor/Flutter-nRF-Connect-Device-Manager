part of 'update_bloc.dart';

@immutable
sealed class UpdateState {}

final class UpdateInitial extends UpdateState {}

final class FirmwareUpdateState extends UpdateState {
  final String state;
  final int? progress;

  FirmwareUpdateState(this.state, [this.progress]);
}
