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
  final StreamController<FirmwareUpgradeState> _updateStateStreamController =
      StreamController();
  final StreamController<McuLogMessage> _logMessageStreamController =
      StreamController();

  // STREAM LISTENERS
  StreamSubscription<ProtoProgressUpdate> _progressListener;
  StreamSubscription<ProtoUpdateStateChanges> _updateStateListener;
  StreamSubscription<ProtoLogMessage> _logMessageListener;

  // STREAMS
  Stream<ProgressUpdate> get progressStream {
    return _progressStreamController.stream;
  }

  Stream<FirmwareUpgradeState> get updateStateStream {
    return _updateStateStreamController.stream;
  }

  Stream<McuLogMessage> get logMessageStream {
    return _logMessageStreamController.stream;
  }

  // Stream<ProgressUpdate> get

  static Future<UpdateManager> newManager(String deviceId) async {
    await _McumgrFlutter._channel
        .invokeMethod("initializeUpdateManager", deviceId);

    final um = UpdateManager._deviceIdentifier(deviceId);
    um._setupProgressUpdateStream();
    um._setupUpdateStateStream();
    um._setupLogStream();
    return um;
  }

  Future<void> update(Uint8List data) async {
    final arg = ProtoUpdateCallArgument();
    arg.deviceUuid = _deviceId;
    arg.firmwareData = data.toList();

    await _McumgrFlutter._channel.invokeMethod("update", arg.writeToBuffer());
  }

  void _setupProgressUpdateStream() {
    _progressListener = _McumgrFlutter._progressStream
        .receiveBroadcastStream()
        .map((event) => ProtoProgressUpdateStreamArg.fromBuffer(event))
        .where((event) => event.uuid == _deviceId)
        .map((event) => event.progressUpdate)
        .listen((event) {
      log("_progressStream" + event.toString());
    });

    _progressListener
        .onData((data) => _progressStreamController.add(data.convert()));
    _progressListener.onError(_progressStreamController.addError);
  }

  void _setupUpdateStateStream() {
    _updateStateListener = _McumgrFlutter._updateStateStream
        .receiveBroadcastStream()
        .map((event) => ProtoUpdateStateChangesStreamArg.fromBuffer(event))
        .where((event) => event.uuid == _deviceId)
        .map((event) => event.updateStateChanges)
        .listen((event) {
      log('_updateStateStream' + event.toString());
    });

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

    _updateStateListener.onError(_updateStateStreamController.addError);
  }

  void _setupLogStream() {
    _logMessageListener = _McumgrFlutter._logEventChannel
        .receiveBroadcastStream()
        .map((event) => ProtoLogMessageStreamArg.fromBuffer(event))
        .where((event) => event.uuid == _deviceId)
        .map((event) => event.protoLogMessage)
        .listen((event) {
      log('_logEventChannel' + event.toString());
    });

    _logMessageListener.onData((data) {
      _logMessageStreamController.add(data.convent());
    });

    _logMessageListener.onError(_logMessageStreamController.addError);
  }
}
