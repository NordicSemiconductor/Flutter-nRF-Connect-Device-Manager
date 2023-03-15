import 'dart:async';
import 'dart:typed_data';

import 'package:mcumgr_flutter/mcumgr_flutter.dart';
import 'package:mcumgr_flutter/src/mock/mock_update_logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class _UpdateTuple {
  final ProgressUpdate progressUpdate;
  final bool inProgress;

  _UpdateTuple(this.progressUpdate, this.inProgress);
}

class MockUpdateManager extends FirmwareUpdateManager {
  final BehaviorSubject<ProgressUpdate> _progressStreamController =
      BehaviorSubject();
  final BehaviorSubject<FirmwareUpgradeState> _updateStateStreamController =
      BehaviorSubject.seeded(FirmwareUpgradeState.none);
  final BehaviorSubject<bool> _updateInProgressStreamController =
      BehaviorSubject.seeded(true);
  final StreamController<bool> _cancelTrigger = StreamController.broadcast();

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
    _cancelTrigger.close();
    _progressStreamController.close();
    _updateStateStreamController.close();
    _updateInProgressStreamController.close();
  }

  @override
  Future<void> cancel() async {
    _cancelTrigger.add(true);
    _close();
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

  Future<void> _startUpdate() async {
    _updateStateStreamController.add(FirmwareUpgradeState.validate);
    await Future.delayed(Duration(milliseconds: 10));

    _updateStateStreamController.add(FirmwareUpgradeState.upload);
    await Future.delayed(Duration(milliseconds: 1000));

    final progStream = Stream.periodic(Duration(milliseconds: 20),
        (i) => ProgressUpdate(i, 100, DateTime.now()));

    final queue = Rx.combineLatest2(progStream, updateInProgressStream,
            (a, b) => _UpdateTuple(a as ProgressUpdate, b as bool))
        .bufferTest((event) => event.inProgress)
        .flatMap((value) => Stream.fromIterable(value))
        .map((event) => event.progressUpdate)
        .take(100)
        .takeUntil(_cancelTrigger.stream);

    await for (var e in queue) {
      _progressStreamController.add(e);
    }

    final states = [
      FirmwareUpgradeState.test,
      FirmwareUpgradeState.reset,
      FirmwareUpgradeState.confirm,
      FirmwareUpgradeState.success
    ];

    await for (var e in Stream.fromIterable(states)
        .takeUntil(_cancelTrigger.stream)
        .interval(Duration(milliseconds: 10))) {
      _updateStateStreamController.add(e);
    }
    _progressStreamController.close();
    _updateStateStreamController.close();
    // _logMessageStreamController.close();
  }

  @override
  Future<void> kill() async {}

  @override
  Stream<FirmwareUpgradeState> setup() {
    return _updateStateStreamController.stream;
  }

  Future<void> updateMap(Map<int, Uint8List> images) async {
    await _startUpdate();
  }

  @override
  FirmwareUpdateLogger get logger => MockUpdateLogger();

  @override
  Future<void> update(List<Tuple2<int, Uint8List>> images,
      {FirmwareUpgradeConfiguration configuration =
          const FirmwareUpgradeConfiguration()}) {
    Map<int, Uint8List> imageMap =
        Map.fromIterable(images, key: (e) => e.item1, value: (e) => e.item2);

    return updateMap(imageMap);
  }
}
