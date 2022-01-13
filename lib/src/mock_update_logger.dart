import '../mcumgr_flutter.dart';

class MockUpdateLogger extends UpdateLogger {
  Duration _timeWindow = Duration(seconds: 1);

  @override
  Future<Duration> get logMessageTimeWindow => Future.value(_timeWindow);

  @override
  set logMessageTimeWindow(Future<Duration> d) =>
      d.then((value) => _timeWindow = value);

  @override
  // TODO: implement logMessageStream
  Stream<List<McuLogMessage>> get logMessageStream =>
      throw UnimplementedError();

  @override
  // TODO: implement liveLoggingEnabled
  Stream<bool> get liveLoggingEnabled => throw UnimplementedError();

  @override
  /// Get cashed log messages. 
  Future<List<McuLogMessage>> readLogs() async {
    throw UnimplementedError();
  }

  @override
  void setLogMessageTimeWindow(Duration value) {
    // TODO: implement setLogMessageTimeWindow
  }

  @override
  Future<bool> toggleLiveLogging() {
    // TODO: implement toggleLiveLogging
    throw UnimplementedError();
  }
}
