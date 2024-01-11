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
  StreamController<McuLogMessage> _logMessageStreamController =
      StreamController.broadcast();
  final String _deviceId;

  McuMgrLogger.deviceIdentifier(this._deviceId) {
    _setupLogMessageStream();
  }

  @override
  Stream<McuLogMessage> get logMessageStream =>
      _logMessageStreamController.stream;

  @override
  Future<List<McuLogMessage>> readLogs({bool clearLogs = false}) =>
      _retrieveLogs(UpdateLoggerMethod.readLogs);

  @override
  Future<void> clearLogs() async {
    await methodChannel.invoke(UpdateLoggerMethod.clearLogs, _deviceId);
  }

  Future<List<McuLogMessage>> _retrieveLogs(UpdateLoggerMethod method,
      {bool clearLogs = false}) async {
    final readLogCallArguments = ProtoReadLogCallArguments()
      ..uuid = _deviceId
      ..clearLogs = clearLogs;

    final data = await methodChannel.invoke(
        UpdateLoggerMethod.readLogs, readLogCallArguments.writeToBuffer());

    final proto = ProtoReadMessagesResponse.fromBuffer(data);
    return proto.protoLogMessage.map((e) => e.convent()).toList();
  }

  @override
  Future<LiveLogConfiguration> getConfiguration() {
    return methodChannel
        .invoke(UpdateLoggerMethod.getLiveLogConfiguration, _deviceId)
        .then((data) => ProtoLiveLogConfiguration.fromBuffer(data).convert());
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

  void _setupLogMessageStream() {
    UpdateLoggerChannel.logEventChannel
        .receiveBroadcastStream()
        .map((event) => ProtoLogMessageStreamArg.fromBuffer(event))
        .map((event) { 
          print('event: ${event.uuid}');
          return event;
        })
        .where((event) => event.uuid == _deviceId)
        .where((event) => event.hasProtoLogMessage())
        .listen((data) {
      if (data.hasError()) {
        _logMessageStreamController.addError(data.error.localizedDescription);
      }

      if (data.done) {
        _logMessageStreamController.close();
      }

      if (data.hasProtoLogMessage()) {
        _logMessageStreamController.add(data.protoLogMessage.convent());
      }
    });
  }
}
