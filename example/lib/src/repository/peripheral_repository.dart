import 'dart:async';
import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class PeripheralRepository {
  Stream<List<ScanResult>> get discoveredPeripherals =>
      FlutterBluePlus.scanResults.map((scanResult) {
        return scanResult
            .where((p) =>
                p.advertisementData.advName.isNotEmpty &&
                p.advertisementData.connectable)
            .toList();
      });

  Stream<BluetoothAdapterState> get deviceState => FlutterBluePlus.adapterState;

  Future<void> startScan() async {
    // enable bluetooth on Android
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }

    if (await FlutterBluePlus.isSupported == false) {
      print("Bluetooth not supported by this device");
      return;
    }

    FlutterBluePlus.setLogLevel(LogLevel.verbose);
    FlutterBluePlus.adapterState.listen((event) {
      print(event);
    });

    await FlutterBluePlus.adapterState
        .where(
            (BluetoothAdapterState state) => state == BluetoothAdapterState.on)
        .first;

    await FlutterBluePlus.startScan();
  }

  Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
  }

  Future<void> refresh() async {
    await FlutterBluePlus.stopScan();
    await FlutterBluePlus.startScan();
  }
}
