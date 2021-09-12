import 'dart:typed_data';

import 'package:mcumgr_flutter/mcumgr_flutter.dart';
import 'package:rxdart/rxdart.dart';

class MockUpdateManager extends UpdateManager {
  final BehaviorSubject<ProgressUpdate> _progressStreamController =
      BehaviorSubject();
  final BehaviorSubject<FirmwareUpgradeState> _updateStateStreamController =
      BehaviorSubject();
  final BehaviorSubject<McuLogMessage> _logMessageStreamController =
      BehaviorSubject();
  final BehaviorSubject<bool> _updateInProgressStreamController =
      BehaviorSubject();

  @override
  Stream<McuLogMessage> get logMessageStream =>
      _logMessageStreamController.stream;

  @override
  Stream<ProgressUpdate> get progressStream => _progressStreamController.stream;

  @override
  Stream<bool> get updateInProgressStream =>
      _updateInProgressStreamController.stream;

  @override
  Stream<FirmwareUpgradeState> get updateStateStream =>
      _updateStateStreamController.stream;

  void dispose() {
    _close();
  }

  void _close() {
    _logMessageStreamController.close();
    _progressStreamController.close();
    _updateStateStreamController.close();
    _logMessageStreamController.close();
    _updateInProgressStreamController.close();
  }

  @override
  Future<void> cancel() {
    // TODO: implement cancel
    throw UnimplementedError();
  }

  @override
  Future<bool> inProgress() {
    // TODO: implement inProgress
    throw UnimplementedError();
  }

  @override
  Future<bool> isPaused() {
    // TODO: implement isPaused
    throw UnimplementedError();
  }

  @override
  Future<void> pause() {
    // TODO: implement pause
    throw UnimplementedError();
  }

  @override
  Future<void> resume() {
    // TODO: implement resume
    throw UnimplementedError();
  }

  @override
  Future<void> update(Uint8List data) async {
    _startUpdate();
  }

  Future<void> _startUpdate() async {
    _updateStateStreamController.add(FirmwareUpgradeState.validate);

    await Future.delayed(Duration(seconds: 2));

    _updateStateStreamController.add(FirmwareUpgradeState.upload);
    await Future.delayed(Duration(seconds: 1));

    final progStream = Stream.periodic(Duration(milliseconds: 500),
        (i) => ProgressUpdate(i, 100, DateTime.now())).take(100);

    await for (var e in progStream) {
      _progressStreamController.add(e);
    }

    final states = [
      FirmwareUpgradeState.test,
      FirmwareUpgradeState.reset,
      FirmwareUpgradeState.confirm,
      FirmwareUpgradeState.success
    ];

    Stream.periodic(Duration(seconds: 5), (i) => states[i])
        .take(4)
        .listen((event) {
      _updateStateStreamController.add(event);
    });
  }
}
