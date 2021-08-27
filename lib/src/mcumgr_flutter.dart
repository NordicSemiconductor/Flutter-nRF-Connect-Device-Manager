part of mcumgr_flutter;

class _McumgrFlutter {
  static const _namespace = "mcumgr_flutter";
  static const MethodChannel _channel =
      const MethodChannel(_namespace + '/method_channel');
  static const EventChannel _progressStream =
      const EventChannel(_namespace + '/update_progress_event_channel');
  static const EventChannel _updateStateStream =
      const EventChannel(_namespace + '/update_state_event_channel');
  static const EventChannel _logEventChannel =
      const EventChannel(_namespace + '/log_event_channel');
  static const EventChannel _updateInProgressChannel =
      const EventChannel(_namespace + '/updateInProgressChannel');
}

class UpdateManager {
  final String _deviceId;

  UpdateManager._deviceIdentifier(this._deviceId);

  // STREAM CONTROLLERS
  final BehaviorSubject<ProgressUpdate> _progressStreamController =
      BehaviorSubject();
  final BehaviorSubject<FirmwareUpgradeState> _updateStateStreamController =
      BehaviorSubject();
  final BehaviorSubject<McuLogMessage> _logMessageStreamController =
      BehaviorSubject();
  final BehaviorSubject<bool> _updateInProgressStreamController =
      BehaviorSubject();

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

  Stream<bool> get updateInProgressStream {
    return _updateInProgressStreamController.stream;
  }

  void dispose() {
    close();
  }

  void close() {
    _logMessageStreamController.close();
    _progressStreamController.close();
    _updateStateStreamController.close();
    _logMessageStreamController.close();
    _updateInProgressStreamController.close();
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
    final arg = ProtoUpdateCallArgument()
      ..deviceUuid = _deviceId
      ..firmwareData = data;

    await _McumgrFlutter._channel.invokeMethod("update", arg.writeToBuffer());
  }

  Future<void> pause() async {
    await _McumgrFlutter._channel.invokeMethod('pause', _deviceId);
    _updateInProgressStreamController.add(false);
  }

  Future<void> resume() async {
    await _McumgrFlutter._channel.invokeMethod('resume', _deviceId);
    _updateInProgressStreamController.add(true);
  }

  Future<void> cancel() async {
    await _McumgrFlutter._channel.invokeMethod('cancel', _deviceId);
  }

  Future<bool> inProgress() async {
    final bool inProgress =
        await _McumgrFlutter._channel.invokeMethod('isInProgress', _deviceId);
    return inProgress;
  }

  Future<bool> isPaused() async {
    final bool isPaused =
        await _McumgrFlutter._channel.invokeMethod('isPaused', _deviceId);
    return isPaused;
  }

  void _setupProgressUpdateStream() {
    _McumgrFlutter._progressStream.receiveBroadcastStream().listen((event) {
      print(event.toString());
    });

    _McumgrFlutter._progressStream
        .receiveBroadcastStream()
        .map((event) => ProtoProgressUpdateStreamArg.fromBuffer(event))
        .where((event) => event.uuid == _deviceId)
        .listen((event) {
      if (event.hasError()) {
        _progressStreamController.addError(event.error);
      }

      if (event.done) {
        _progressStreamController.close();
      }

      if (event.hasProgressUpdate()) {
        final progress = event.progressUpdate.convert();
        _progressStreamController.add(progress);
      }
    });
  }

  void _setupUpdateStateStream() {
    _McumgrFlutter._updateStateStream
        .receiveBroadcastStream()
        .map((event) => ProtoUpdateStateChangesStreamArg.fromBuffer(event))
        .where((event) => event.uuid == _deviceId)
        .listen((data) async {
      if (data.hasError()) {
        _updateStateStreamController.addError(data.error);
        return;
      }

      if (data.done) {
        _updateStateStreamController.close();
        return;
      }

      if (!data.hasUpdateStateChanges()) {
        return;
      }

      final stateChanges = data.updateStateChanges;
      if (stateChanges.canceled) {
        await _updateStateStreamController.close();
        return;
      }

      var d = stateChanges.newState.convert();

      _updateStateStreamController.add(d);

      if (d == FirmwareUpgradeState.upload) {
        _updateInProgressStreamController.add(true);
      }
    });
  }

  void _setupLogStream() {
    _McumgrFlutter._logEventChannel
        .receiveBroadcastStream()
        .map((event) => ProtoLogMessageStreamArg.fromBuffer(event))
        .where((event) => event.uuid == _deviceId)
        .listen((event) {
      if (event.hasError()) {
        _logMessageStreamController.addError(event.error);
      }

      if (event.done) {
        // _logMessageStreamController.close();
      }

      if (event.hasProtoLogMessage()) {
        final msg = event.protoLogMessage.convent();
        _logMessageStreamController.add(msg);
      }
    });
  }
}
