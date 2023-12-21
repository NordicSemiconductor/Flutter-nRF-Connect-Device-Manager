part of 'update_bloc.dart';

@immutable
sealed class UpdateState {}

final class UpdateInitial extends UpdateState {}

final class UpdateFirmware extends UpdateState {
  final String state;
  final int? progress;

  UpdateFirmware(this.state, [this.progress]);
}
