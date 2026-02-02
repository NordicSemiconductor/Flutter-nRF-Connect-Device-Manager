import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mcumgr_flutter/mcumgr_flutter.dart';

class WebUpdateManager extends FirmwareUpdateManager {
  WebUpdateManager(String deviceId) {
    throw UnimplementedError(
      "WebUpdateManager is not supported on this platform.",
    );
  }

  @override
  FirmwareUpdateLogger get logger => throw UnimplementedError();

  @override
  Stream<ProgressUpdate> get progressStream => throw UnimplementedError();

  @override
  Stream<FirmwareUpgradeState>? get updateStateStream =>
      throw UnimplementedError();

  @override
  Stream<bool>? get updateInProgressStream => throw UnimplementedError();

  @override
  Stream<FirmwareUpgradeState> setup() {
    throw UnimplementedError();
  }

  @override
  Future<void> update(
    List<Image> images, {
    FirmwareUpgradeConfiguration configuration =
        const FirmwareUpgradeConfiguration(),
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateWithImageData({
    required Uint8List imageData,
    Uint8List? hash,
    FirmwareUpgradeConfiguration? configuration,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> pause() {
    throw UnimplementedError();
  }

  @override
  Future<void> resume() {
    throw UnimplementedError();
  }

  @override
  Future<void> cancel() {
    throw UnimplementedError();
  }

  @override
  Future<bool> inProgress() {
    throw UnimplementedError();
  }

  @override
  Future<bool> isPaused() {
    throw UnimplementedError();
  }

  @override
  Future<void> kill() {
    throw UnimplementedError();
  }

  @override
  Future<List<ImageSlot>?> readImageList() {
    throw UnimplementedError();
  }
}
