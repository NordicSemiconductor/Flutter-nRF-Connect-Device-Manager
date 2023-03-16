import 'dart:async';
import 'dart:typed_data';

import 'package:mcumgr_flutter/proto/flutter_mcu.pb.dart';
import 'package:mcumgr_flutter/src/mcumgr_update_logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

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
  final StreamController<McuLogMessage> _logMessageStreamController =
      StreamController.broadcast();
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

  Stream<McuLogMessage> get logMessageStream {
    return _logMessageStreamController.stream;
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
    } catch (e) {
      // TODO: Handle Flutter error
      print(e);
    }

    final um = DeviceUpdateManager._deviceIdentifier(deviceId);
    um._setupStreams();
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

  Future<void> updateMap(Map<int, Uint8List> images) async {
    await methodChannel.invokeMethod(
        UpdateManagerMethod.update.rawValue,
        ProtoUpdateWithImageCallArguments(
            deviceUuid: this._deviceId,
            images: images.entries
                .map((e) => Pair(key: e.key, value: e.value))).writeToBuffer());
  }

  @override
  Future<void> update(List<Tuple2<int, Uint8List>> images,
          {FirmwareUpgradeConfiguration configuration =
              const FirmwareUpgradeConfiguration()}) async =>
      await methodChannel.invokeMethod(
          UpdateManagerMethod.update.rawValue,
          ProtoUpdateWithImageCallArguments(
            deviceUuid: _deviceId,
            images: images.map((e) => Pair(key: e.item1, value: e.item2)),
            configuration: configuration.proto(),
          ).writeToBuffer());

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

  void _setupStreams() {
    _setupProgressUpdateStream();
  }

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
        // TODO: check if this works
        // .where((event) => event.hasUpdateStateChanges())
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
      _logMessageStreamController
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
}
