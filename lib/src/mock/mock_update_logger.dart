import 'package:flutter/services.dart';

import '../../mcumgr_flutter.dart';

class MockUpdateLogger extends FirmwareUpdateLogger {
  bool _liveUpdate = true;

  @override
  Stream<List<McuLogMessage>> get logMessageStream => getAllLogs().asStream();

  @override
  Stream<bool> get liveLoggingEnabled => Stream.value(_liveUpdate);

  @override

  /// Get cashed log messages.
  Future<List<McuLogMessage>> readLogs() async {
    return [
      McuLogMessage(
          'msg', McuMgrLogCategory.dfu, McuMgrLogLevel.info, DateTime.now()),
    ];
  }

  @override
  Future<bool> toggleLiveLogging() async => _liveUpdate = !_liveUpdate;

  McuMgrLogLevel levelFromString(String str) {
    switch (str) {
      case '[I]':
        return McuMgrLogLevel.info;
      case '[D]':
        return McuMgrLogLevel.debug;
      case '[W]':
        return McuMgrLogLevel.warning;
      case '[E]':
        return McuMgrLogLevel.error;
      case '[V]':
        return McuMgrLogLevel.verbose;
      case '[A]':
        return McuMgrLogLevel.application;
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> setLiveLoggingEnabled(bool value) async {}

  @override
  Future<void> clearLogs() => getAllLogs();

  @override
  Future<List<McuLogMessage>> getAllLogs() {
    final path =
        'packages/mcumgr_flutter/assets/mock_logs.txt'; // packages/mcumgr_flutter/assets/mock_logs.txt

    return rootBundle
        .loadString(path)
        .then((event) => event.split('\n').map((e) {
              final sublines = e.split(' ');
              final dateTime = DateTime.parse(sublines[0]);
              final logLevel = levelFromString(sublines[1]);
              final message = sublines.skip(2).join(' ');
              return McuLogMessage(
                  message, McuMgrLogCategory.dfu, logLevel, dateTime);
            }).toList());
  }
}
