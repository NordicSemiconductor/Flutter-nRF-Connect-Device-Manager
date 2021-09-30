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
    _close();
  }

  void _close() {
    _logMessageStreamController.close();
    _progressStreamController.close();
    _updateStateStreamController.close();
    _logMessageStreamController.close();
    _updateInProgressStreamController.close();
  }

  // Stream<ProgressUpdate> get

  static Future<McuMgrUpdateManager> newManager(String deviceId) async {
    await _McumgrFlutter._channel
        .invokeMethod("initializeUpdateManager", deviceId);

    final um = McuMgrUpdateManager._deviceIdentifier(deviceId);
    um._setupProgressUpdateStream();
    um._setupUpdateStateStream();
    um._setupLogStream();
    return um;
  }

  @override
  Future<void> update(Uint8List data) async =>
      await _McumgrFlutter._channel.invokeMethod(
          "update",
          ProtoUpdateCallArgument(deviceUuid: _deviceId, firmwareData: data)
              .writeToBuffer());

  @override
  Future<void> multicoreUpdate(Map<int, Uint8List> images) async =>
      await _McumgrFlutter._channel.invokeMethod(
          "multicore_update",
          ProtoUpdateWithImageCallArguments(
                  deviceUuid: this._deviceId,
                  images: images.entries
                      .map((e) => Pair(key: e.key, value: e.value)))
              .writeToBuffer());

  @override
  Future<void> pause() async {
    await _McumgrFlutter._channel.invokeMethod('pause', _deviceId);
    _updateInProgressStreamController.add(false);
  }

  @override
  Future<void> resume() async {
    await _McumgrFlutter._channel.invokeMethod('resume', _deviceId);
    _updateInProgressStreamController.add(true);
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
