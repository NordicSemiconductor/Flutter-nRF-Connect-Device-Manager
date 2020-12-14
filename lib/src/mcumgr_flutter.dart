part of mcumgr_flutter;

class _McumgrFlutter {
  static const _namespace = "mcumgr_flutter";
  static const MethodChannel _channel =
      const MethodChannel(_namespace + '/method_chonnel');
  static const EventChannel _progressStream =
      const EventChannel(_namespace + '/update_progress_event_channel');
  static const EventChannel _updateStateStream =
      const EventChannel(_namespace + '/update_state_event_channel');
  static const EventChannel _logEventChannel =
      const EventChannel(_namespace + '/log_event_channel');
}

class UpdateManager {
  final String _deviceId;

  UpdateManager._deviceIdentifier(this._deviceId);

  // STREAM CONTROLLERS
  final StreamController<ProgressUpdate> _progressStreamController =
      StreamController();
  final StreamController<FirmwareUpgradeState>
      _updateStateStreamController = StreamController();

  // STREAM LISTENERS
  StreamSubscription<ProtoProgressUpdate> _progressListener;
  StreamSubscription<ProtoUpdateStateChanges> _updateStateListener;

  // STREAMS
  Stream<ProgressUpdate> get progressStream {
    return _progressStreamController.stream;
  }

  Stream<FirmwareUpgradeState> get updateStateStream {
    return _updateStateStreamController.stream;
  }

  // Stream<ProgressUpdate> get

  static Future<UpdateManager> newManager(String deviceId) async {
    await _McumgrFlutter._channel
        .invokeMethod("initializeUpdateManager", deviceId);

    final um = UpdateManager._deviceIdentifier(deviceId);
    um._setupStreams();
    return um;
  }

  Future<void> update(Uint8List data) async {
    final arg = ProtoUpdateCallArgument();
    arg.deviceUuid = _deviceId;
    arg.firmwareData = data.toList();

    await _McumgrFlutter._channel.invokeMethod("update", arg.writeToBuffer());
  }

  void _setupStreams() {
    _progressListener = _McumgrFlutter._progressStream
        .receiveBroadcastStream()
        .map((event) => ProtoProgressUpdateStreamArg.fromBuffer(event))
        .where((event) => event.uuid == _deviceId)
        .map((event) => event.progressUpdate)
        .listen((event) {});

    _progressListener.onData((data) => _progressStreamController.add(data.convert()));
    _progressListener.onError(_progressStreamController.addError);

    _updateStateListener = _McumgrFlutter._updateStateStream
        .receiveBroadcastStream()
        .map((event) => ProtoUpdateStateChangesStreamArg.fromBuffer(event))
        .where((event) => event.uuid == _deviceId)
        .map((event) => event.updateStateChanges)
        .listen((event) {});

    _updateStateListener.onData((data) async {
      if (data.hasError) {
        _updateStateStreamController.addError(data.protoError);
        return;
      }

      if (data.canceled) {
        await _updateStateStreamController.close();
        return;
      }

      if (data.completed) {
        // TODO: Check Correctness
        _updateStateStreamController.close();
        return;
      }

      _updateStateStreamController.add(data.newState.convert());
    });
  }
}
