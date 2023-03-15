import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:mcumgr_flutter/mcumgr_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import 'mock_update_logger.dart';

class _FWState extends LinkedListEntry<_FWState> {
  final FirmwareUpgradeState state;
  final ProgressUpdate progressUpdate;

  _FWState(this.state, this.progressUpdate);

  @override
  String toString() => state.toString();
}

class MockManualUpdateManager extends FirmwareUpdateManager {
  final BehaviorSubject<ProgressUpdate> _progressStreamController =
      BehaviorSubject();
  final BehaviorSubject<FirmwareUpgradeState> _updateStateStreamController =
      BehaviorSubject.seeded(FirmwareUpgradeState.none);
  final BehaviorSubject<bool> _updateInProgressStreamController =
      BehaviorSubject.seeded(true);
  final StreamController<bool> _cancelTrigger = StreamController.broadcast();

  final LinkedList<_FWState> states = LinkedList<_FWState>()
    ..addAll([
      FirmwareUpgradeState.none,
      FirmwareUpgradeState.validate,
      FirmwareUpgradeState.upload,
      FirmwareUpgradeState.reset,
      FirmwareUpgradeState.confirm,
      FirmwareUpgradeState.success,
    ].map((e) => _FWState(e, ProgressUpdate(100, 300, DateTime.now()))));

  late Iterator<_FWState> _stateIterator = states.iterator;

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
  Future<void> cancel() async {}

  @override
  Future<bool> inProgress() async {
    return _updateInProgressStreamController.value!;
  }

  @override
  Future<bool> isPaused() async {
    return !_updateInProgressStreamController.value!;
  }

  @override
  Future<void> kill() async {}

  @override
  FirmwareUpdateLogger get logger => MockUpdateLogger();

  @override
  Future<void> pause() async => await resume();

  @override
  Stream<ProgressUpdate> get progressStream => _progressStreamController.stream;

  @override
  Future<void> resume() async {
    if (!_stateIterator.moveNext()) {
      _close();
    }

    final state = _stateIterator.current;

    _updateStateStreamController.add(state.state);
    _progressStreamController.add(state.progressUpdate);
  }

  @override
  Stream<FirmwareUpgradeState> setup() {
    return _updateStateStreamController.stream;
  }

  Future<void> updateMap(Map<int, Uint8List> images) async {}

  @override
  Stream<bool>? get updateInProgressStream =>
      _updateInProgressStreamController.stream;

  @override
  Stream<FirmwareUpgradeState>? get updateStateStream =>
      _updateStateStreamController.stream;

  @override
  Future<void> update(List<Tuple2<int, Uint8List>> images,
      {FirmwareUpgradeConfiguration configuration =
          const FirmwareUpgradeConfiguration()}) {
    Map<int, Uint8List> imageMap = {};
    // convert list to map
    images.forEach((e) => imageMap[e.item1] = e.item2);
    return updateMap(imageMap);
  }
}
