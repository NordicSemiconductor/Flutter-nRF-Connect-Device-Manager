import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:mcumgr_flutter/mcumgr_flutter.dart';
import 'package:mcumgr_flutter/src/mcumgr_web_loader.dart';
import 'package:web/web.dart' as web;

@JS('McuMgrFlutter')
external McuMgrFlutterJS get mcuMgrFlutter;

@JS()
extension type McuMgrFlutterJS._(JSObject _) implements JSObject {
  external JSPromise<JSString> update(
    JSString deviceId,
    JSObject images,
    JSObject config,
  );
  external void pause(JSString deviceId);
  external void resume(JSString deviceId);
  external void cancel(JSString deviceId);
}

class WebUpdateManager extends FirmwareUpdateManager {
  final String _deviceId;

  WebUpdateManager(this._deviceId);

  final StreamController<ProgressUpdate> _progressStreamController =
      StreamController.broadcast();
  final StreamController<FirmwareUpgradeState> _updateStateStreamController =
      StreamController.broadcast();
  final StreamController<bool> _updateInProgressStreamController =
      StreamController.broadcast();

  @override
  FirmwareUpdateLogger get logger => _WebLogger();

  @override
  Stream<ProgressUpdate> get progressStream => _progressStreamController.stream;

  @override
  Stream<FirmwareUpgradeState>? get updateStateStream =>
      _updateStateStreamController.stream;

  @override
  Stream<bool>? get updateInProgressStream =>
      _updateInProgressStreamController.stream;

  @override
  Stream<FirmwareUpgradeState> setup() {
    return _updateStateStreamController.stream;
  }

  @override
  Future<void> update(
    List<Image> images, {
    FirmwareUpgradeConfiguration configuration =
        const FirmwareUpgradeConfiguration(),
  }) async {
    // Ensure JS is loaded
    await McuMgrWebLoader.loadJs();

    _updateInProgressStreamController.add(true);
    _updateStateStreamController.add(FirmwareUpgradeState.upload);

    print(
      "WebUpdateManager: Starting update for device $_deviceId with ${images.length} images.",
    );

    // Setup Event Listeners

    // Progress Listener
    web.window.addEventListener(
      'mcumgr_progress',
      (web.CustomEvent event) {
        final detail = event.detail as JSObject;
        final info = detail as McuProgressEventDetail;
        if (info.deviceId.toDart == _deviceId) {
          _progressStreamController.add(
            ProgressUpdate(info.progress.toDartInt, 100, DateTime.now()),
          );
        }
      }.toJS,
    );

    // State Listener
    web.window.addEventListener(
      'mcumgr_state',
      (web.CustomEvent event) {
        final detail = event.detail as JSObject;
        final info = detail as McuStateEventDetail;

        if (info.deviceId.toDart == _deviceId) {
          String state = info.state.toDart;
          if (state == 'success') {
            _updateStateStreamController.add(FirmwareUpgradeState.success);
            _updateInProgressStreamController.add(false);
          } else if (state == 'error') {
            _updateStateStreamController.addError(
              info.error?.toDart ?? "Unknown Error",
            );
            _updateInProgressStreamController.add(false);
          }
        }
      }.toJS,
    );

    // Log Listener
    web.window.addEventListener(
      'mcumgr_log',
      (web.CustomEvent event) {
        final detail = event.detail as JSObject;
        final message = (detail as McuLogEventDetail).message.toDart;
        print("JS: $message");
      }.toJS,
    );

    try {
      final jsImages =
          images
              .map((img) {
                return McuImage(image: img.image.toJS, data: img.data.toJS);
              })
              .toList()
              .toJS;

      await mcuMgrFlutter.update(_deviceId.toJS, jsImages, JSObject()).toDart;
    } catch (e) {
      _updateStateStreamController.addError(e);
      _updateInProgressStreamController.add(false);
    }
  }

  @override
  Future<void> updateWithImageData({
    required Uint8List imageData,
    Uint8List? hash,
    FirmwareUpgradeConfiguration? configuration,
  }) async {
    await update([
      Image(image: 0, data: imageData, hash: hash),
    ], configuration: configuration ?? const FirmwareUpgradeConfiguration());
  }

  @override
  Future<void> pause() async {
    mcuMgrFlutter.pause(_deviceId.toJS);
    _updateInProgressStreamController.add(false);
  }

  @override
  Future<void> resume() async {
    mcuMgrFlutter.resume(_deviceId.toJS);
    _updateInProgressStreamController.add(true);
  }

  @override
  Future<void> cancel() async {
    mcuMgrFlutter.cancel(_deviceId.toJS);
    _updateInProgressStreamController.add(false);
  }

  @override
  Future<bool> inProgress() async {
    return false;
  }

  @override
  Future<bool> isPaused() async {
    return false;
  }

  @override
  Future<void> kill() async {
    await _progressStreamController.close();
    await _updateStateStreamController.close();
    await _updateInProgressStreamController.close();
  }

  @override
  Future<List<ImageSlot>?> readImageList() async {
    return [];
  }
}

// Interop Extensions

@JS()
extension type McuImage._(JSObject _) implements JSObject {
  external factory McuImage({JSNumber image, JSUint8Array data});
}

@JS()
extension type McuProgressEventDetail._(JSObject _) implements JSObject {
  external JSString get deviceId;
  external JSNumber get progress;
}

@JS()
extension type McuStateEventDetail._(JSObject _) implements JSObject {
  external JSString get deviceId;
  external JSString get state;
  external JSString? get error;
}

@JS()
extension type McuLogEventDetail._(JSObject _) implements JSObject {
  external JSString get message;
}

class _WebLogger implements FirmwareUpdateLogger {
  final _logController = StreamController<McuLogMessage>.broadcast();

  @override
  Stream<McuLogMessage> get logMessageStream => _logController.stream;

  @override
  Future<List<McuLogMessage>> readLogs({bool clearLogs = false}) async {
    return [];
  }

  @override
  Future<void> clearLogs() async {}
}
