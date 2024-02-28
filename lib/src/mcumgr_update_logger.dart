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

  void _setupLogMessageStream() {
    UpdateLoggerChannel.logEventChannel
        .receiveBroadcastStream()
        .map((event) => ProtoLogMessageStreamArg.fromBuffer(event))
        .where((event) => event.uuid == _deviceId)
        .listen((data) {
      if (data.hasError() && !_logMessageStreamController.isClosed) {
        _logMessageStreamController.addError(data.error.localizedDescription);
      }

      if (data.done) {
        _logMessageStreamController.close();
      }

      if (data.hasProtoLogMessage() && !_logMessageStreamController.isClosed) {
        _logMessageStreamController.add(data.protoLogMessage.convent());
      }
    });
  }
}
