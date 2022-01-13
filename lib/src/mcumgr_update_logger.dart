import 'dart:async';

import 'package:mcumgr_flutter/mcumgr_flutter.dart';
import 'package:mcumgr_flutter/proto/flutter_mcu.pb.dart';

import 'method_channels.dart';
import '../proto/extensions/proto_ext.dart';

class McuMgrLogger extends UpdateLogger {
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
  Future<List<McuLogMessage>> readLogs() async {
    final streamArg = ProtoLogMessageStreamArg.fromBuffer(
        await methodChannel.invokeMethod(UpdateLoggerMethod.getLogs.rawValue));
    return streamArg.protoLogMessage.map((e) => e.convent()).toList();
  }

  @override
  Future<bool> toggleLiveLogging() async => await methodChannel.invokeMethod(
      UpdateLoggerMethod.toggleLiveLoggs.rawValue, _deviceId);

  @override
  Future<Duration> get logMessageTimeWindow => throw UnimplementedError();

  @override
  void setLogMessageTimeWindow(Duration value) {
    throw UnimplementedError();
  }

  void _setupLogStream() => UpdateLoggerChannel.logEventChannel
      .receiveBroadcastStream()
      .map((data) => ProtoLogMessageStreamArg.fromBuffer(data))
      .where((arg) => (arg.uuid == _deviceId) && arg.protoLogMessage.isNotEmpty)
      .listen((msg) => _logMessageStreamController
          .add(msg.protoLogMessage.map((m) => m.convent()).toList()));

  void _setupLiveLogStatusStream() {
    UpdateLoggerChannel.liveLogEnabledChannel
        .receiveBroadcastStream()
        .map((data) => ProtoMessageLiveLogEnabled.fromBuffer(data))
        .where((arg) => (arg.uuid == _deviceId))
        .listen((arg) => _liveLogEnabled.add(arg.enabled));
  }
}
