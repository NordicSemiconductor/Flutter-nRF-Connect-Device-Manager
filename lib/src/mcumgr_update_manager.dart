import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mcumgr_flutter/proto/flutter_mcu.pb.dart';
import 'package:mcumgr_flutter/src/mcumgr_update_logger.dart';
import 'package:rxdart/rxdart.dart';

import '../mcumgr_flutter.dart';
import '../proto/extensions/proto_ext.dart';
import 'method_channels.dart';

class DeviceUpdateManager extends FirmwareUpdateManager {
  final String _deviceId;
  final McuMgrLogger _logger;

  DeviceUpdateManager._deviceIdentifier(this._deviceId)
      : this._logger = McuMgrLogger.deviceIdentifier(_deviceId);

  // STREAM CONTROLLERS
  // All stream controllers are closed in the `kill()` method.
  // ignore: close_sinks
  final StreamController<ProgressUpdate> _progressStreamController =
      StreamController.broadcast();
  // ignore: close_sinks
  StreamController<FirmwareUpgradeState>? _updateStateStreamController;
  // ignore: close_sinks
  final StreamController<bool>? _updateInProgressStreamController =
      BehaviorSubject.seeded(false);

  // STREAMS
  Stream<ProgressUpdate> get progressStream {
    return _progressStreamController.stream;
  }

  Stream<FirmwareUpgradeState>? get updateStateStream {
    return _updateStateStreamController?.stream;
  }

  Stream<bool>? get updateInProgressStream {
    return _updateInProgressStreamController?.stream;
  }

  void dispose() async {
    await kill();
  }

  // Stream<ProgressUpdate> get

  static Future<DeviceUpdateManager> getInstance(String deviceId) async {
    try {
      await methodChannel.invokeMethod(
          UpdateManagerMethod.initializeUpdateManager.rawValue, deviceId);
    } catch (error, stack) {
      if (error is PlatformException && error.code == 'UpdateManagerExists') {
        // If the manager already exists, we can ignore the error and proceed.
        // The native side has already created it. We just need the Dart wrapper.
      } else {
        FlutterError.reportError(FlutterErrorDetails(
          exception: error,
          stack: stack,
          library: 'mcumgr_flutter',
          context: ErrorDescription('getInstance: initialize Update Manager'),
        ));
        rethrow;
      }
    }

    final um = DeviceUpdateManager._deviceIdentifier(deviceId);
    um._setupUpdateStateStream();
    um._setupProgressUpdateStream();
    return um;
  }

  @override
  Stream<FirmwareUpgradeState> setup() {
    if (_updateStateStreamController?.isClosed != true) {
      _updateStateStreamController?.close();
    }

    _updateStateStreamController = StreamController.broadcast();
    _setupUpdateStateStream();
    return _updateStateStreamController!.stream;
  }
/*
  Future<void> updateMap(List<Image> images) async {
    return await methodChannel.invokeMethod(
        UpdateManagerMethod.update.rawValue,
        ProtoUpdateWithImageCallArguments(
            deviceUuid: this._deviceId,
            images: images.entries
                .map((e) => Pair(key: e.key, value: e.value))).writeToBuffer());
  }
  */

  @override
  Future<void> update(List<Image> images,
      {FirmwareUpgradeConfiguration configuration =
          const FirmwareUpgradeConfiguration()}) async {
    return await methodChannel.invokeMethod(
        UpdateManagerMethod.update.rawValue,
        ProtoUpdateWithImageCallArguments(
          deviceUuid: _deviceId,
          images: images.map((e) => e.toProto()).toList(),
          configuration: configuration.proto(),
        ).writeToBuffer());
  }

  @override
  Future<void> updateWithImageData({
    required Uint8List imageData,
    Uint8List? hash,
    FirmwareUpgradeConfiguration? configuration,
  }) {
    return methodChannel.invokeMethod(
        UpdateManagerMethod.updateSingleImage.rawValue,
        ProtoUpdateCallArgument(
          deviceUuid: _deviceId,
          firmwareData: imageData,
          hash: hash,
          configuration: configuration?.proto(),
        ).writeToBuffer());
  }

  @override
  Future<void> pause() async {
    await methodChannel.invokeMethod(
        UpdateManagerMethod.pause.rawValue, _deviceId);
    _updateInProgressStreamController!.add(false);
  }

  @override
  Future<void> resume() async {
    await methodChannel.invokeMethod(
        UpdateManagerMethod.resume.rawValue, _deviceId);
    _updateInProgressStreamController!.add(true);
  }

  @override
  Future<void> cancel() async => await methodChannel.invokeMethod(
      UpdateManagerMethod.cancel.rawValue, _deviceId);

  @override
  Future<bool> inProgress() async => await methodChannel.invokeMethod(
      UpdateManagerMethod.isInProgress.rawValue, _deviceId);

  @override
  Future<bool> isPaused() async => await methodChannel.invokeMethod(
      UpdateManagerMethod.isPaused.rawValue, _deviceId);

  void _setupProgressUpdateStream() {
    UpdateManagerChannel.progressStream
        .receiveBroadcastStream()
        .map((event) => ProtoProgressUpdateStreamArg.fromBuffer(event))
        .where((event) => event.uuid == _deviceId)
        .where((event) => event.hasProgressUpdate())
        .listen((event) =>
            _progressStreamController.add(event.progressUpdate.convert()));
  }

  void _setupUpdateStateStream() {
    UpdateManagerChannel.updateStateStream
        .receiveBroadcastStream()
        .map((event) => ProtoUpdateStateChangesStreamArg.fromBuffer(event))
        .where((event) => event.uuid == _deviceId)
        .listen((data) async {
      if (data.hasError()) {
        _updateStateStreamController!.addError(data.error.localizedDescription);
        return;
      }

      if (data.done) {
        _updateStateStreamController!.close();
        return;
      }

      if (!data.hasUpdateStateChanges()) {
        return;
      }

      final stateChanges = data.updateStateChanges;
      if (stateChanges.canceled) {
        await _updateStateStreamController!.close();
        return;
      }

      var d = stateChanges.newState.convert();

      _updateStateStreamController!.add(d);

      if (d == FirmwareUpgradeState.upload) {
        _updateInProgressStreamController!.add(true);
      }
    });
  }

  @override
  Future<void> kill() async {
    [
      _progressStreamController,
      _updateInProgressStreamController,
      _updateStateStreamController,
    ].forEach((sc) {
      if (!(sc?.isClosed == true)) {
        sc?.close();
      }
    });

    await methodChannel.invokeMethod(
        UpdateManagerMethod.kill.rawValue, _deviceId);
  }

  @override
  FirmwareUpdateLogger get logger => _logger;

  @override
  Future<List<ImageSlot>?> readImageList() async {
    final response = await methodChannel.invokeMethod(
        UpdateManagerMethod.readImageList.rawValue, _deviceId);

    if (response is Uint8List) {
      final listImagesResponse = ProtoListImagesResponse.fromBuffer(response);
      if (listImagesResponse.existing) {
        return listImagesResponse.images.map((e) => e.convert()).toList();
      } else {
        return null;
      }
    } else {
      // Optionally handle error or unexpected response type
      throw Exception(
          'Unexpected response type from readImageList: ${response.runtimeType}');
    }
  }
}
