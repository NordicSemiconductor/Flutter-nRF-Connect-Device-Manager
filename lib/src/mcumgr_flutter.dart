part of mcumgr_flutter;

/// Object that handles update process.
abstract class UpdateManager {
  /// Get logger related to this update manager.
  UpdateLogger get logger;

  /// Stream emits `ProgressUpdate` events.
  Stream<ProgressUpdate> get progressStream;

  /// Stream emits events with stage of the update progress.
  // Stream<FirmwareUpgradeState>? get updateStateStream;

  /// Stream emits bool value that indicates if the update in progress.
  ///
  /// ! Not implemented yet
  Stream<bool>? get updateInProgressStream;

  /// Prepare State Stream
  /// This method should be called befor staring the update
  Stream<FirmwareUpgradeState> setup();

  /// Stream emits update state during update process
  ///
  /// It doesn't exist until method `setup()`  wasn't called.
  Stream<FirmwareUpgradeState>? get updateStateStream;

  /// Start update process
  ///
  /// This is the full-featured API to start DFU update, including support for Multi-Image uploads.
  ///
  /// [images] is a `Map<int, Uint8List>` where key is an image core index
  Future<void> update(Map<int, Uint8List> images);

  /// Pause the update process.
  Future<void> pause();

  /// Resume the update process.
  Future<void> resume();

  /// Cancel update.
  Future<void> cancel();

  /// Check if the progress is in process.
  Future<bool> inProgress();

  /// Check if the progress is paused.
  Future<bool> isPaused();

  /// Kill the update manager instance.
  ///
  /// If you just cancel update or get error during the update, the UM instance
  /// will still alive and you will be able to restart the update process
  /// on the same manager.
  ///
  /// `kill()` method remove platform-side instance of the UpdateManager.
  /// After that you won't be able to restart update, you'll have to
  /// create another `UpdateManager`
  ///
  /// This method also closes all streams if they were not closed.
  Future<void> kill();
}

abstract class UpdateLogger {
  /// Stream emits Log Messages
  Stream<List<McuLogMessage>> get logMessageStream;

  /// Time window for log messages
  ///
  /// Default value is `const Duration(seconds: 1)`
  Future<Duration> get logMessageTimeWindow;

  /// Set time window for log messages
  void setLogMessageTimeWindow(Duration value);

  /// Subscribe to detect if live logging is enabled
  Stream<bool> get liveLoggingEnabled;

  /// Enable/Disable live logging
  void toggleLiveLogging();

  /// New logs will be sent thgrough `logMessageStream`
  void readLogs();
}

abstract class UpdateManagerFactory {
  Future<UpdateManager> getUpdateManager(String deviceId);
}

class McuMgrUpdateManagerFactory extends UpdateManagerFactory {
  @override
  Future<UpdateManager> getUpdateManager(String deviceId) async {
    return await McuMgrUpdateManager.getInstance(deviceId);
  }
}

class MockUpdateManagerFactory extends UpdateManagerFactory {
  @override
  Future<UpdateManager> getUpdateManager(String deviceId) async {
    return MockUpdateManager();
  }

  @override
  Future<UpdateLogger> getUpdateLogger(String deviceId) {
    // TODO: implement getUpdateLogger
    throw UnimplementedError();
  }
}
