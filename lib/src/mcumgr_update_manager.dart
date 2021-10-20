import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:mcumgr_flutter/proto/flutter_mcu.pb.dart';
import 'package:rxdart/rxdart.dart';

import '../mcumgr_flutter.dart';
import '../proto/extensions/proto_ext.dart';

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

class McuMgrUpdateManager extends UpdateManager {
  final String _deviceId;

  McuMgrUpdateManager._deviceIdentifier(this._deviceId);

  // STREAM CONTROLLERS
  // All stream controllers are closed in the `kill()` method.
  // ignore: close_sinks
  final StreamController<ProgressUpdate> _progressStreamController =
      StreamController.broadcast();
  // ignore: close_sinks
  StreamController<FirmwareUpgradeState>? _updateStateStreamController;
  // ignore: close_sinks
  final StreamController<McuLogMessage> _logMessageStreamController =
      StreamController.broadcast();
  // ignore: close_sinks
  final StreamController<bool>? _updateInProgressStreamController =
      BehaviorSubject.seeded(false);

  // STREAMS
  Stream<ProgressUpdate> get progressStream {
    return _progressStreamController.stream;
  }

  Stream<FirmwareUpgradeState>? get updateStateStream {
    return _updateStateStreamController?.stream;
  }

  Stream<McuLogMessage> get logMessageStream {
    return _logMessageStreamController.stream;
  }

  Stream<bool>? get updateInProgressStream {
    return _updateInProgressStreamController?.stream;
  }

  void dispose() async {
    await kill();
  }

  // Stream<ProgressUpdate> get

  static Future<McuMgrUpdateManager> newManager(String deviceId) async {
    await _McumgrFlutter._channel
        .invokeMethod("initializeUpdateManager", deviceId);

    final um = McuMgrUpdateManager._deviceIdentifier(deviceId);
    um._setupStreams();
    return um;
  }

  @override
  Stream<FirmwareUpgradeState> setup() {
    if (_updateStateStreamController?.isClosed != true) {
      _updateStateStreamController?.close();
    }

    _updateStateStreamController = StreamController.broadcast();
    _setupUpdateStateStream();
    return _updateStateStreamController!.stream;
  }

  @override
  Future<void> update(Map<int, Uint8List> images) async {
    await _McumgrFlutter._channel.invokeMethod(
        "multicoreUpdate",
        ProtoUpdateWithImageCallArguments(
            deviceUuid: this._deviceId,
            images: images.entries
                .map((e) => Pair(key: e.key, value: e.value))).writeToBuffer());
  }

  @override
  Future<void> pause() async {
    await _McumgrFlutter._channel.invokeMethod('pause', _deviceId);
    _updateInProgressStreamController!.add(false);
  }

  @override
  Future<void> resume() async {
    await _McumgrFlutter._channel.invokeMethod('resume', _deviceId);
    _updateInProgressStreamController!.add(true);
  }

  @override
  Future<void> cancel() async =>
      await _McumgrFlutter._channel.invokeMethod('cancel', _deviceId);

  @override
  Future<bool> inProgress() async =>
      await _McumgrFlutter._channel.invokeMethod('isInProgress', _deviceId);

  @override
  Future<bool> isPaused() async =>
      await _McumgrFlutter._channel.invokeMethod('isPaused', _deviceId);

  void _setupStreams() {
    _setupProgressUpdateStream();
    _setupLogStream();
  }

  void _setupProgressUpdateStream() {
    _McumgrFlutter._progressStream
        .receiveBroadcastStream()
        .map((event) => ProtoProgressUpdateStreamArg.fromBuffer(event))
        .where((event) => event.uuid == _deviceId)
        .where((event) => event.hasProgressUpdate())
        .listen((event) =>
            _progressStreamController.add(event.progressUpdate.convert()));
  }

  void _setupUpdateStateStream() {
    _McumgrFlutter._updateStateStream
        .receiveBroadcastStream()
        .map((event) => ProtoUpdateStateChangesStreamArg.fromBuffer(event))
        .where((event) => event.uuid == _deviceId)
        // TODO: check if this works
        // .where((event) => event.hasUpdateStateChanges())
        .listen((data) async {
      if (data.hasError()) {
        _updateStateStreamController!.addError(data.error.localizedDescription);
        return;
      }

      if (data.done) {
        _updateStateStreamController!.close();
        return;
      }

      if (!data.hasUpdateStateChanges()) {
        return;
      }

      final stateChanges = data.updateStateChanges;
      if (stateChanges.canceled) {
        await _updateStateStreamController!.close();
        return;
      }

      var d = stateChanges.newState.convert();

      _updateStateStreamController!.add(d);

      if (d == FirmwareUpgradeState.upload) {
        _updateInProgressStreamController!.add(true);
      }
    });
  }

  void _setupLogStream() {
    _McumgrFlutter._logEventChannel
        .receiveBroadcastStream()
        .map((event) => ProtoLogMessageStreamArg.fromBuffer(event))
        .where((event) => event.uuid == _deviceId)
        .where((event) => event.hasProtoLogMessage())
        .listen((event) =>
            _logMessageStreamController.add(event.protoLogMessage.convent()));
  }

  @override
  Future<void> kill() async {
    [
      _progressStreamController,
      _updateInProgressStreamController,
      _updateStateStreamController,
      _logMessageStreamController
    ].forEach((sc) {
      if (!(sc?.isClosed == true)) {
        sc?.close();
      }
    });

    await _McumgrFlutter._channel.invokeMethod('kill', _deviceId);
  }
}
