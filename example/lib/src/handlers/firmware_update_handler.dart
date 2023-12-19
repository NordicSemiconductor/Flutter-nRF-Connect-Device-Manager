import 'package:mcumgr_flutter_example/src/bloc/bloc/update_bloc.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_update_request.dart';

abstract class FirmwareUpdateHandler {
  Future<void> handleFirmwareUpdate(FirmwareUpdateRequest request);
  Future<void> setNextHandler(FirmwareUpdateHandler handler);
  UpdateBloc? get updateBloc;
}

class FirmwareDownloader extends FirmwareUpdateHandler {
  FirmwareUpdateHandler? _nextHandler;
  UpdateBloc? updateBloc;

  @override
  Future<void> handleFirmwareUpdate(FirmwareUpdateRequest request) async {
    if (request.firmware == null) {
      throw Exception('Firmware is not selected');
    }

    updateBloc?.add(StatusUpdateEvent('Downloading firmware', null));

    if (_nextHandler != null) {
      await _nextHandler!.handleFirmwareUpdate(request);
    }
  }

  @override
  Future<void> setNextHandler(FirmwareUpdateHandler handler) async {
    _nextHandler = handler;
  }
}
