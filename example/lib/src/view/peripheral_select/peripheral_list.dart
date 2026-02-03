import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_update_request.dart';
import 'package:mcumgr_flutter_example/src/providers/firmware_update_request_provider.dart';
import 'package:mcumgr_flutter_example/src/repository/peripheral_repository.dart';
import 'package:provider/provider.dart';

class PeripheralList extends StatefulWidget {
  const PeripheralList({Key? key}) : super(key: key);

  @override
  State<PeripheralList> createState() => _PeripheralListState();
}

class _PeripheralListState extends State<PeripheralList> {
  final repository = PeripheralRepository();

  late Future<void> _scanFuture;

  @override
  void initState() {
    super.initState();
    _scanFuture = repository.startScan();
  }

  @override
  void dispose() {
    repository.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Peripheral List')),
      body: _body(),
    );
  }

  FutureBuilder<void> _body() {
    return FutureBuilder(
      future: _scanFuture,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          return StreamBuilder(
            stream: repository.deviceState,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                final state = snapshot.data;
                return _bluetoothState(state);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _bluetoothState(BluetoothAdapterState state) {
    switch (state) {
      case BluetoothAdapterState.turningOn:
        return Text('Bluetooth is turning on');
      case BluetoothAdapterState.on:
        return StreamBuilder(
          stream: repository.discoveredPeripherals,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final peripherals = snapshot.data;
              return _peripheralList(peripherals);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        );
      case BluetoothAdapterState.turningOff:
        return Text('Bluetooth is turning off');
      case BluetoothAdapterState.off:
        return Text('Bluetooth is off');
      case BluetoothAdapterState.unauthorized:
        return Text('Bluetooth is unauthorized');
      case BluetoothAdapterState.unavailable:
        return Text('Bluetooth is unavailable');
      default:
        return Text('Unknown Bluetooth state');
    }
  }

  Widget _peripheralList(peripherals) {
    return ListView.builder(
      itemCount: peripherals.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            peripherals[index].device.name +
                " " +
                peripherals[index].device.advName +
                " " +
                peripherals[index].device.remoteId.toString(),
          ),
          onTap: () async {
            ScanResult p = peripherals[index];
            context.read<FirmwareUpdateRequestProvider>().setPeripheral(
              SelectedPeripheral(
                name: p.advertisementData.advName,
                identifier: p.device.remoteId.toString(),
              ),
            );
            print(
              'Selected peripheral: ${p.device.platformName} - ${p.device.remoteId}',
            );
            Navigator.pop(context, peripherals[index]);
          },
        );
      },
    );
  }
}
