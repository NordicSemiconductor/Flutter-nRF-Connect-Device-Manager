import 'package:bloc/bloc.dart';
import 'package:mcumgr_flutter/mcumgr_flutter.dart';
import 'package:mcumgr_flutter_example/src/handlers/firmware_update_handler.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_update_request.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:tuple/tuple.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final FirmwareUpdateRequest firmwareUpdateRequest;
  UpdateFirmwareStateHistory? _state;
  FirmwareUpdateManager? _firmwareUpdateManager;

  UpdateBloc({required this.firmwareUpdateRequest}) : super(UpdateInitial()) {
    on<BeginUpdateProcess>((event, emit) async {
      emit(UpdateFirmware('Begin update process'));
      final handler = createFirmwareUpdateHandler();

      _state = null;

      _firmwareUpdateManager = await handler.handleFirmwareUpdate(
        firmwareUpdateRequest,
        (FirmwareUpdateState state) => add(_StateConverter.convert(state)),
      );

      rx.CombineLatestStream.combine2(_firmwareUpdateManager!.progressStream,
          _firmwareUpdateManager!.updateStateStream!, (a, b) => Tuple2(a, b))
          .map((event) {
            
          })

      stream.map((event) => null);
    });
    on<DownloadStarted>((event, emit) {
      _state = _updatedState(UpdateFirmware('Download firmware'));
      emit(_state!);
    });
    on<UnpackStarted>((event, emit) {
      _state = _updatedState(UpdateFirmware('Unpack firmware'));
      emit(_state!);
    });
    on<UploadStarted>((event, emit) {
      _state = _updatedState(UpdateFirmware('Upload firmware'));
      emit(_state!);
    });
    on<UploadProgress>((event, emit) {
      _state = _updatedState(UpdateFirmware('Upload firmware', event.progress));
      emit(_state!);
    });
    on<UploadFinished>((event, emit) {
      _state = _updatedState(UpdateFirmware('Upload finished'));
      emit(_state!);
    });
  }

  UpdateFirmwareStateHistory _updatedState(UpdateFirmware currentState) {
    if (_state == null) {
      return UpdateFirmwareStateHistory(currentState, []);
    } else {
      return UpdateFirmwareStateHistory(
          currentState, _state!.history + [_state!.currentState]);
    }
  }

  FirmwareUpdateHandler createFirmwareUpdateHandler() {
    FirmwareUpdateHandler handler = FirmwareDownloader()
      ..setNextHandler(
        FirmwareUnpacker()
          ..setNextHandler(
            FirmwareUpdater(),
          ),
      );

    return handler;
  }
}

class _StateConverter {
  static UpdateEvent convert(FirmwareUpdateState state) {
    return switch (state) {
      FirmwareDownloadStarted() => DownloadStarted(),
      FirmwareUnpackStarted() => UnpackStarted(),
      FirmwareUploadStarted() => UploadStarted(),
      FirmwareUploadProgress(progress: var progress) =>
        UploadProgress(stage: "Upload firmware", progress: progress),
      FirmwareUploadFinished() => UploadFinished(),
    };
  }
}

class _FirmwareUpdateManagerStateConverter {
  static UpdateEvent convert(FirmwareUpgradeState event) {
    return UploadProgress(stage: event.toString());
  }
}
