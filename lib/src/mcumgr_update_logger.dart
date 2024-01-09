import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mcumgr_flutter/mcumgr_flutter.dart';
import 'package:mcumgr_flutter/models/live_log_configuration.dart';
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
  final String _deviceId;

  McuMgrLogger.deviceIdentifier(this._deviceId) {
    _setupLogStream();
  }

  @override
  Stream<List<McuLogMessage>> get logMessageStream =>
      _logMessageStreamController.stream;

  @override
  Future<List<McuLogMessage>> readLogs({bool clearLogs = false}) =>
      _retrieveLogs(UpdateLoggerMethod.readLogs);

  void _setupLogStream() => UpdateLoggerChannel.logEventChannel
      .receiveBroadcastStream()
      .map((data) => ProtoLogMessageStreamArg.fromBuffer(data))
      .where((arg) => (arg.uuid == _deviceId) && arg.protoLogMessage.isNotEmpty)
      .listen((msg) => _logMessageStreamController
          .add(msg.protoLogMessage.map((m) => m.convent()).toList()));

  @override
  Future<void> clearLogs() async {
    await methodChannel.invoke(UpdateLoggerMethod.clearLogs, _deviceId);
  }

  Future<List<McuLogMessage>> _retrieveLogs(UpdateLoggerMethod method,
      {bool clearLogs = false}) async {
    final readLogCallArguments = ProtoReadLogCallArguments()
      ..uuid = _deviceId
      ..clearLogs = clearLogs;
    
    final streamArg = ProtoLogMessageStreamArg.fromBuffer(await methodChannel
        .invoke(method, readLogCallArguments.writeToBuffer()));
    return streamArg.protoLogMessage.map((e) => e.convent()).toList();
  }

  @override
  Future<LiveLogConfiguration> getConfiguration() {
    // TODO: implement getConfiguration
    throw UnimplementedError();
  }

  @override
  Future<void> setConfiguration(LiveLogConfiguration configuration) {
    final proto = configuration.proto();
    proto.uuid = _deviceId;
    return methodChannel.invoke(
      UpdateLoggerMethod.setLiveLogConfiguration,
      proto.writeToBuffer(),
    );
  }
}
