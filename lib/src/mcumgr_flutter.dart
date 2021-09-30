part of mcumgr_flutter;

/// Object that handles update process.
abstract class UpdateManager {
  /// Stream emits `ProgressUpdate` events.
  Stream<ProgressUpdate> get progressStream;

  /// Stream emits events with stage of the update progress.
  Stream<FirmwareUpgradeState> get updateStateStream;

  /// Stream emits Log Messages
  Stream<McuLogMessage> get logMessageStream;

  /// Stream emits bool value that indicates if the update in progress.
  ///
  /// ! Not implemented yet
  Stream<bool> get updateInProgressStream;

  /// Start update process.
  ///
  /// [data] is a Byte List of `*.bin` file.
  Future<void> update(Uint8List data);

  /// Start update process
  /// 
  /// This is the full-featured API to start DFU update, including support for Multi-Image uploads.
  /// 
  /// [images] is a `Map<int, Uint8List>` where key is an image core index
  Future<void> multicoreUpdate(Map<int, Uint8List> images);

  /// Pause the update process.
  Future<void> pause();

  /// Resume the update process.
  Future<void> resume();

  /// Cancel update.
  ///
  /// You can't resume process or restart update process after you cancel it.
  ///
  /// To restart update process you have to create new update manager.
  Future<void> cancel();

  /// Check if the progress is in process.
  Future<bool> inProgress();

  /// Check if the progress is paused.
  Future<bool> isPaused();
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
