part of mcumgr_flutter;

class FirmwareUpgradeConfiguration {
  /// Estimated time required for swapping images, in seconds.
  /// If the mode is set to `.testAndConfirm`, the manager will try to reconnect after this time. 0 by default.
  final Duration estimatedSwapTime;

  /// If enabled, after successful upload but before test/confirm/reset phase, an Erase App Settings Command will be sent and awaited before proceeding.
  final bool eraseAppSettings;

  /// If set to a value larger than 1, this enables SMP Pipelining, wherein multiple packets of data ('chunks') are sent at once before awaiting a response, which can lead to a big increase in transfer speed if the receiving hardware supports this feature.
  final int pipelineDepth;

  /// Necessary to set when Pipeline Length is larger than 1 (SMP Pipelining Enabled) to predict offset jumps as multiple
  /// packets are sent.
  final ImageUploadAlignment byteAlignment;

  /// If set, it is used instead of the MTU Size as the maximum size of the packet. It is designed to be used with a size
  /// larger than the MTU, meaning larger Data chunks per Sequence Number, trusting the reassembly Buffer on the receiving
  /// side to merge it all back. Thus, increasing transfer speeds.
  ///
  /// Can be used in conjunction with SMP Pipelining.
  final int reassemblyBufferSize;

  /// Previously set directly in `FirmwareUpgradeManager`, it has since been moved here, to the Configuration. It modifies the steps after `upload` step in Firmware Upgrade that need to be performed for the Upgrade process to be considered Successful.
  final FirmwareUpgradeMode firmwareUpgradeMode;

  const FirmwareUpgradeConfiguration({
    this.estimatedSwapTime = const Duration(seconds: 0),
    this.eraseAppSettings = true,
    this.pipelineDepth = 1,
    this.byteAlignment = ImageUploadAlignment.fourByte,
    this.reassemblyBufferSize = 0,
    this.firmwareUpgradeMode = FirmwareUpgradeMode.confirmOnly,
  }) : assert(reassemblyBufferSize >= 0,
            "Reassembly Buffer Size must be a positive number or 0");
}

/// Object that handles update process.
abstract class FirmwareUpdateManager {
  /// Get logger related to this update manager.
  FirmwareUpdateLogger get logger;

  /// Stream emits `ProgressUpdate` events.
  Stream<ProgressUpdate> get progressStream;

  /// Stream emits events with stage of the update progress.
  // Stream<FirmwareUpgradeState>? get updateStateStream;

  /// Stream emits bool value that indicates if the update in progress.
  ///
  /// ! Not implemented yet
  Stream<bool>? get updateInProgressStream;

  /// Prepare State Stream
  /// This method should be called before staring the update
  Stream<FirmwareUpgradeState> setup();

  /// Stream emits update state during update process
  ///
  /// It doesn't exist until method `setup()`  wasn't called.
  Stream<FirmwareUpgradeState>? get updateStateStream;

  /// Start update process
  ///
  /// This is the full-featured API to start DFU update, including support for Multi-Image uploads.
  ///
  /// [images] is a `List<Tuple2<int, Uint8List>>` where `int` is the image number and `Uint8List` is the image data.
  Future<void> update(List<Image> images,
      {FirmwareUpgradeConfiguration configuration =
          const FirmwareUpgradeConfiguration()});

  /// Start update process.
  ///
  /// This is the simplified API to start DFU update for single image.
  Future<void> updateWithImageData({
    required Uint8List imageData,
    required Uint8List hash,
    FirmwareUpgradeConfiguration? configuration,
  });

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

abstract class FirmwareUpdateLogger {
  /// Stream emits Log Messages
  Stream<McuLogMessage> get logMessageStream;

  /// New logs will be sent through `logMessageStream`
  ///
  /// [clearLogs] if true, all logs will be cleared after reading. Default value is `false`
  Future<List<McuLogMessage>> readLogs({bool clearLogs = false});

  /// Clear all log messages
  Future<void> clearLogs();
}

/// Object that creates `UpdateManager` instance.
abstract class UpdateManagerFactory {
  Future<FirmwareUpdateManager> getUpdateManager(String deviceId);
}

/// Implementation of `UpdateManagerFactory` that creates `UpdateManager` instance for production.
class FirmwareUpdateManagerFactory extends UpdateManagerFactory {
  @override
  Future<FirmwareUpdateManager> getUpdateManager(String deviceId) async {
    return await DeviceUpdateManager.getInstance(deviceId);
  }
}
