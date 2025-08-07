import 'dart:typed_data';

import 'package:cbor/cbor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mcumgr_flutter/mcumgr_flutter.dart';
import 'package:mcumgr_flutter_example/src/bloc/bloc/update_bloc.dart';
import 'package:mcumgr_flutter_example/src/model/firmware_update_request.dart';
import 'package:mcumgr_flutter_example/src/providers/firmware_update_request_provider.dart';
import 'package:mcumgr_flutter_example/src/view/stepper_view/firmware_select.dart';
import 'package:mcumgr_flutter_example/src/view/stepper_view/peripheral_select.dart';
import 'package:mcumgr_flutter_example/src/view/stepper_view/update_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FirmwareUpdateRequestProvider(),
      builder: (context, child) => _materialApp(context),
    );
  }

  MaterialApp _materialApp(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('MCU Manager'),
          ),
          body: Column(
            children: [
              _body(context),
              _settings(context),
            ],
          )),
    );
  }

  Widget _body(BuildContext context) {
    final provider = context.watch<FirmwareUpdateRequestProvider>();
    return Stepper(
      currentStep: provider.currentStep,
      onStepContinue: () {
        setState(() {
          provider.nextStep();
        });
      },
      onStepCancel: () {
        setState(() {
          provider.previousStep();
        });
      },
      controlsBuilder: _controlBuilder,
      steps: [
        Step(
          title: Text('Select Firmware'),
          content: Center(child: FirmwareSelect()),
          isActive: provider.currentStep == 0,
        ),
        Step(
          title: Text('Select Device'),
          content: Center(child: PeripheralSelect()),
          isActive: provider.currentStep == 1,
        ),
        Step(
          title: Text('Update'),
          content: Text('Update'),
          isActive: provider.currentStep == 2,
        ),
      ],
    );
  }

  Widget _settings(BuildContext context) {
    final _mcumgrSettings = McumgrSettings();
    final provider = context.watch<FirmwareUpdateRequestProvider>();
    final parameters = provider.updateParameters;
    return Column(
      spacing: 16.0,
      children: [
        InkWell(
          onTap: () async {
            print("Scanning for devices...");
            FlutterBluePlus.startScan(timeout: Duration(seconds: 5));

            final scanResult = await FlutterBluePlus.scanResults
                .expand((results) => results)
                .firstWhere((r) => (r.device.advName ?? "").contains("Termo"));

            final device = scanResult.device;
            print('czym jest $device');
            final address = device.remoteId.str;

            print("Connecting to ${device.advName} $address...");
            await _mcumgrSettings.init(address);
            print("Connected!");
          },
          child: Text("Connect"),
        ),
        InkWell(
          onTap: () async {
            try {
              final result = await _mcumgrSettings.readSettings();
              print("Read all result: $result");
            } catch (e) {
              print("Error reading settings: $e");
            }
          },
          child: Text("Read all"),
        ),
        InkWell(
          onTap: () async {
            try {
              final rawBytes = await _mcumgrSettings.readSetting('app/alarm/en/val');
              print('Raw bytes: $rawBytes');

              final alarmEnabled = decodeBoolSetting(rawBytes);
              print('Alarm enabled?: $alarmEnabled');
            } catch (e) {
              print('Error reading setting: $e');
            }
          },
          child: Text("Read single"),
        ),
        InkWell(
          onTap: () async {
            try {
              final result = await _mcumgrSettings.writeSetting('app/alarm/en/val', Uint8List.fromList([0]));
              print("Write result: $result");
            } catch (e) {
              print("Error writing setting: $e");
            }
          },
          child: Text("Write"),
        ),
      ],
    );
  }

  Widget _controlBuilder(BuildContext context, ControlsDetails details) {
    final provider = context.watch<FirmwareUpdateRequestProvider>();
    FirmwareUpdateRequest parameters = provider.updateParameters;
    switch (provider.currentStep) {
      case 0:
        if (parameters.firmware == null) {
          return Container();
        }
        return Row(
          children: [
            ElevatedButton(
              onPressed: details.onStepContinue,
              child: Text('Next'),
            ),
          ],
        );
      case 1:
        if (parameters.peripheral == null) {
          return Container();
        }
        return Row(
          children: [
            TextButton(
              onPressed: details.onStepCancel,
              child: Text('Back'),
            ),
            ElevatedButton(
              onPressed: details.onStepContinue,
              child: Text('Next'),
            ),
          ],
        );
      case 2:
        return BlocProvider(
          create: (context) => UpdateBloc(firmwareUpdateRequest: parameters),
          child: UpdateStepView(),
        );
      default:
        throw Exception('Unknown step');
    }
  }

  double decodeDoubleSetting(Uint8List bytes) {
    if (bytes.length != 8) {
      throw Exception("Expected 8 bytes for float/double, got ${bytes.length}");
    }
    final doubleValue = ByteData.sublistView(bytes).getFloat64(0, Endian.little);
    return doubleValue;
  }

  bool decodeBoolSetting(Uint8List bytes) {
    if (bytes.isEmpty) throw Exception("Empty byte array for bool");
    return bytes[0] != 0;
  }

  // Future<void> readSingleSetting(McumgrSettings settings, String key) async {
  //   try {
  //     final resultBytes = await settings.readSetting(key);
  //     print("Raw SMP bytes: $resultBytes");
  //
  //     if (resultBytes.length <= 8) {
  //       print("Invalid response: too short");
  //       return;
  //     }
  //
  //     final payload = resultBytes.sublist(8);
  //     print("CBOR payload bytes: $payload");
  //
  //     final codec = const CborCodec();
  //     final decoded = codec.decode(payload).toObject();
  //
  //     print("Decoded setting: $decoded");
  //   } catch (e) {
  //     print("Error reading single setting: $e");
  //   }
  // }

  // Future<void> decodeSettings(Uint8List bytes) async {
  //   print('Raw SMP bytes: $bytes');
  //
  //   if (bytes.length <= 8) {
  //     print('Invalid SMP packet, too short.');
  //     return;
  //   }
  //
  //   final payload = bytes.sublist(8);
  //   print('CBOR payload bytes: $payload');
  //
  //   final codec = const CborCodec();
  //   try {
  //     final value = codec.decode(payload);
  //     final decoded = value.toObject();
  //     print('Decoded settings object: $decoded');
  //
  //     if (decoded is Map) {
  //       decoded.forEach((key, val) {
  //         print('Key: $key, Value: $val');
  //       });
  //     }
  //   } catch (e) {
  //     print('CBOR decode error: $e');
  //   }
  // }
}
