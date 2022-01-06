import 'dart:async';

import 'package:mcumgr_flutter/mcumgr_flutter.dart';
import 'package:mcumgr_flutter/proto/flutter_mcu.pb.dart';

import 'method_channels.dart';
import '../proto/extensions/proto_ext.dart';

class McuMgrLogger extends UpdateLogger {
  StreamController<List<McuLogMessage>> _logMessageStreamController =
      StreamController.broadcast();
  final String _deviceId;

  McuMgrLogger._deviceIdentifier(this._deviceId);

  @override
  Stream<List<McuLogMessage>> get logMessageStream =>
      _logMessageStreamController.stream;

  @override
  // TODO: implement liveLoggingEnabled
  Stream<bool> get liveLoggingEnabled => throw UnimplementedError();

  @override
  void readLogs() {
    // TODO: implement readLogs
  }

  @override
  void toggleLiveLogging() {
    // TODO: implement toggleLiveLogging
  }

  @override
  // TODO: implement logMessageTimeWindow
  Future<Duration> get logMessageTimeWindow => throw UnimplementedError();

  @override
  void setLogMessageTimeWindow(Duration value) {
    // TODO: implement setLogMessageTimeWindow
  }

  void _setupLogStream() {
    UpdateLoggerChannel.logEventChannel
        .receiveBroadcastStream()
        .map((data) => ProtoLogMessageStreamArg.fromBuffer(data))
        .where(
            (arg) => (arg.uuid == _deviceId) && arg.protoLogMessage.isNotEmpty)
        .listen((msg) => _logMessageStreamController
            .add(msg.protoLogMessage.map((m) => m.convent()).toList()));
  }
}
