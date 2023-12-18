import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mcumgr_flutter_example/src/model/update_parameters.dart';
import 'package:mcumgr_flutter_example/src/providers/update_parameters_provider.dart';
import 'package:mcumgr_flutter_example/src/repository/peripheral_repository.dart';
import 'package:provider/provider.dart';

class PeripheralList extends StatelessWidget {
  final repository = PeripheralRepository();
  PeripheralList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Peripheral List')),
      body: _body(),
    );
  }

  FutureBuilder<void> _body() {
    return FutureBuilder(
        future: repository.startScan(),
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
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
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
            });
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
          title: Text(peripherals[index].device.name),
          onTap: () {
            ScanResult p = peripherals[index];

            context.read<UpdateParametersProvider>().setPeripheral(
                SelectedPeripheral(
                    name: p.advertisementData.advName,
                    identifier: p.device.remoteId.toString()));
            Navigator.pop(context, peripherals[index]);
          },
        );
      },
    );
  }
}
