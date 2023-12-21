import 'package:bloc/bloc.dart';
import 'package:mcumgr_flutter_example/src/handlers/firmware_update_handler.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_update_request.dart';
import 'package:meta/meta.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final FirmwareUpdateRequest firmwareUpdateRequest;

  UpdateBloc({required this.firmwareUpdateRequest}) : super(UpdateInitial()) {
    on<BeginUpdateProcess>((event, emit) async {
      emit(UpdateFirmware('Begin update process'));
      final handler = createFirmwareUpdateHandler();

      await handler.handleFirmwareUpdate(
        firmwareUpdateRequest,
        (FirmwareUpdateState state) => add(_StateConverter.convert(state)),
      );
    });
    on<DownloadStarted>((event, emit) {
      emit(UpdateFirmware('Downloading firmware'));
    });
    on<UnpackStarted>((event, emit) {
      emit(UpdateFirmware('Unpacking firmware'));
    });
    on<UploadStarted>((event, emit) {
      emit(UpdateFirmware('Uploading firmware'));
    });
    on<UploadProgress>((event, emit) {
      emit(UpdateFirmware('Uploading firmware', event.progress));
    });
    on<UploadFinished>((event, emit) {
      emit(UpdateFirmware('Upload finished'));
    });
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
        UploadProgress(progress),
      FirmwareUploadFinished() => UploadFinished(),
    };
  }
}
