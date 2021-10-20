part of mcumgr_flutter;

/// Object that handles update process.
abstract class UpdateManager {
  /// Stream emits `ProgressUpdate` events.
  Stream<ProgressUpdate> get progressStream;

  /// Stream emits events with stage of the update progress.
  // Stream<FirmwareUpgradeState>? get updateStateStream;

  /// Stream emits Log Messages
  Stream<McuLogMessage> get logMessageStream;

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

abstract class UpdateManagerFactory {
  Future<UpdateManager> create(String deviceId);
}

class McuMgrUpdateManagerFactory extends UpdateManagerFactory {
  @override
  Future<UpdateManager> create(String deviceId) async {
    return await McuMgrUpdateManager.newManager(deviceId);
  }
}

class MockUpdateManagerFactory extends UpdateManagerFactory {
  @override
  Future<UpdateManager> create(String deviceId) async {
    return MockUpdateManager();
  }
}
