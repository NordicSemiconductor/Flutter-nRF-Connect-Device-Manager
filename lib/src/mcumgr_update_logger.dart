import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mcumgr_flutter/mcumgr_flutter.dart';
import 'package:mcumgr_flutter/proto/flutter_mcu.pb.dart';

import 'method_channels.dart';
import '../proto/extensions/proto_ext.dart';

extension _Invocation on MethodChannel {
  Future<T?> invoke<T>(UpdateLoggerMethod method, [dynamic arguments]) {
    return this.invokeMethod<T>(method.rawValue, arguments);
  }
}

class McuMgrLogger extends FirmwareUpdateLogger {
  StreamController<List<McuLogMessage>> _logMessageStreamController =
      StreamController.broadcast();
  StreamController<bool> _liveLogEnabled = StreamController.broadcast();
  final String _deviceId;

  McuMgrLogger.deviceIdentifier(this._deviceId) {
    _setupLogStream();
    _setupLiveLogStatusStream();
  }

  @override
  Stream<List<McuLogMessage>> get logMessageStream =>
      _logMessageStreamController.stream;

  @override
  Stream<bool> get liveLoggingEnabled => _liveLogEnabled.stream;

  @override
  Future<List<McuLogMessage>> readLogs() =>
      _retrieveLogs(UpdateLoggerMethod.readLogs);

  @override
  Future<bool> toggleLiveLogging() async =>
      await methodChannel.invoke(UpdateLoggerMethod.toggleLiveLogs, _deviceId);

  void _setupLogStream() => UpdateLoggerChannel.logEventChannel
      .receiveBroadcastStream()
      .map((data) => ProtoLogMessageStreamArg.fromBuffer(data))
      .where((arg) => (arg.uuid == _deviceId) && arg.protoLogMessage.isNotEmpty)
      .listen((msg) => _logMessageStreamController
          .add(msg.protoLogMessage.map((m) => m.convent()).toList()));

  void _setupLiveLogStatusStream() {
    /*
    UpdateLoggerChannel.liveLogEnabledChannel
        .receiveBroadcastStream()
        .map((data) => ProtoMessageLiveLogEnabled.fromBuffer(data))
        .where((arg) => (arg.uuid == _deviceId))
        .listen((arg) => _liveLogEnabled.add(arg.enabled));
        */
  }

  @override
  Future<void> setLiveLoggingEnabled(bool value) async {
    // ProtoMessageLiveLogEnabled

    final msg = ProtoMessageLiveLogEnabled()
      ..enabled = value
      ..uuid = _deviceId;
    await methodChannel.invoke(
        UpdateLoggerMethod.setLiveLogsEnabled, msg.writeToBuffer());
  }

  @override
  Future<void> clearLogs() async {
    await methodChannel.invoke(UpdateLoggerMethod.clearLogs, _deviceId);
  }

  @override
  Future<List<McuLogMessage>> getAllLogs() =>
      _retrieveLogs(UpdateLoggerMethod.getAllLogs);

  Future<List<McuLogMessage>> _retrieveLogs(UpdateLoggerMethod method) async {
    final streamArg = ProtoLogMessageStreamArg.fromBuffer(
        await methodChannel.invoke(method, _deviceId));
    return streamArg.protoLogMessage.map((e) => e.convent()).toList();
  }
}
