import 'dart:typed_data';

import 'package:mcumgr_flutter/mcumgr_flutter.dart';
import 'package:rxdart/rxdart.dart';

class _UpdateTupple {
  final ProgressUpdate progressUpdate;
  final bool inProgress;

  _UpdateTupple(this.progressUpdate, this.inProgress);
}

class MockUpdateManager extends UpdateManager {
  final BehaviorSubject<ProgressUpdate> _progressStreamController =
      BehaviorSubject();
  final BehaviorSubject<FirmwareUpgradeState> _updateStateStreamController =
      BehaviorSubject.seeded(FirmwareUpgradeState.none);
  final BehaviorSubject<McuLogMessage> _logMessageStreamController =
      BehaviorSubject();
  final BehaviorSubject<bool> _updateInProgressStreamController =
      BehaviorSubject.seeded(true);

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
  Future<bool> inProgress() async {
    return _updateInProgressStreamController.value!;
  }

  @override
  Future<bool> isPaused() async {
    return !_updateInProgressStreamController.value!;
  }

  @override
  Future<void> pause() async {
    _updateInProgressStreamController.add(false);
  }

  @override
  Future<void> resume() async {
    _updateInProgressStreamController.add(true);
  }

  @override
  Future<void> update(Uint8List data) async {
    _startUpdate();
  }

  Future<void> _startUpdate() async {
    _updateStateStreamController.add(FirmwareUpgradeState.validate);

    await Future.delayed(Duration(seconds: 1));

    _updateStateStreamController.add(FirmwareUpgradeState.upload);
    await Future.delayed(Duration(seconds: 1));

    final progStream = Stream.periodic(Duration(milliseconds: 200),
        (i) => ProgressUpdate(i, 100, DateTime.now()));

    final queue = Rx.combineLatest2(progStream, updateInProgressStream,
            (a, b) => _UpdateTupple(a as ProgressUpdate, b as bool))
        .bufferTest((event) => event.inProgress)
        .flatMap((value) => Stream.fromIterable(value))
        .map((event) => event.progressUpdate)
        .interval(Duration(milliseconds: 100))
        .take(100);

    await for (var e in queue) {
      _progressStreamController.add(e);
    }

    final states = [
      FirmwareUpgradeState.test,
      FirmwareUpgradeState.reset,
      FirmwareUpgradeState.confirm,
      FirmwareUpgradeState.success
    ];

    await for (var e
        in Stream.fromIterable(states).interval(Duration(seconds: 3))) {
      _updateStateStreamController.add(e);
    }

    _progressStreamController.close();
    _updateStateStreamController.close();
  }
}
