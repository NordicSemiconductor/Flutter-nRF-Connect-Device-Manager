import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mcumgr_flutter/mcumgr_flutter.dart';

final class SettingsManagerWidget extends StatefulWidget {
  const SettingsManagerWidget({super.key});

  @override
  State<SettingsManagerWidget> createState() => _SettingsManagerWidgetState();
}

class _SettingsManagerWidgetState extends State<SettingsManagerWidget> {
  final _mcumgrSettings = McumgrSettings();
  final _settingsKeyController = TextEditingController();
  final _writeValueController = TextEditingController();

  BluetoothDevice? _connectedDevice;
  bool _isScanning = false;
  bool _isConnecting = false;
  List<ScanResult> _scanResults = [];

  @override
  void dispose() {
    _settingsKeyController.dispose();
    _writeValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.0,
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: _connectedDevice != null ? Colors.green[100] : Colors.red[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            _connectedDevice != null ? 'Connected to: ${_connectedDevice!.advName}' : 'Not connected',
            style: TextStyle(
              color: _connectedDevice != null ? Colors.green[800] : Colors.red[800],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Scan for devices
        ElevatedButton(
          onPressed: _isScanning ? null : _scanForDevices,
          child: Text(_isScanning ? 'Scanning...' : 'Scan for Devices'),
        ),

        // Device list - only show when not connected
        if (_scanResults.isNotEmpty && _connectedDevice == null)
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _scanResults.length,
              itemBuilder: (context, index) {
                final result = _scanResults[index];
                final device = result.device;
                return ListTile(
                  title: Text(device.advName.isNotEmpty ? device.advName : 'Unknown Device'),
                  subtitle: Text(device.remoteId.str),
                  trailing: ElevatedButton(
                    onPressed: _isConnecting ? null : () => _connectToDevice(device),
                    child: Text(_isConnecting ? 'Connecting...' : 'Connect'),
                  ),
                );
              },
            ),
          ),

        // Only show settings controls when connected
        if (_connectedDevice != null) ...[
          // Settings Key Input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _settingsKeyController,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Settings Key',
                hintText: 'val',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // Value Input for Write Operations
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _writeValueController,
              autocorrect: false,
              onChanged: (_) {
                setState(() {});
              },
              decoration: const InputDecoration(
                labelText: 'Value to Write',
                hintText: '123.456/true/false/string/10',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _readAllSettings,
                child: const Text("Read All"),
              ),
              ElevatedButton(
                onPressed: _readSingleSetting,
                child: const Text("Read Single"),
              ),
              ElevatedButton(
                onPressed: _writeValueController.text.isNotEmpty ? _writeSetting : null,
                child: const Text("Write"),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Future<void> _scanForDevices() async {
    setState(() {
      _isScanning = true;
      _scanResults.clear();
    });

    try {
      print("Scanning for devices...");
      // Listen to scan results stream
      final subscription = FlutterBluePlus.scanResults.listen((results) {
        setState(() {
          _scanResults = results.where((result) => result.device.advName.isNotEmpty).toList();
        });
      });
      await FlutterBluePlus.adapterState.where((val) => val == BluetoothAdapterState.on).first;
      // Start scanning
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
      await FlutterBluePlus.isScanning.where((val) => val == false).first;
      // Cancel subscription
      await subscription.cancel();
    } catch (e) {
      print("Error scanning for devices: $e");
    } finally {
      setState(() {
        _isScanning = false;
      });
    }
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    setState(() {
      _isConnecting = true;
    });

    try {
      final address = device.remoteId.str;
      print("Connecting to ${device.advName} $address...");

      await _mcumgrSettings.init(
        deviceAddress: address,
        encodeValueToCBOR: true,
        padTo4Bytes: true,
      );

      setState(() {
        _connectedDevice = device;
      });

      print("Connected to ${device.advName}!");
    } catch (e) {
      print("Error connecting to device: $e");
    } finally {
      setState(() {
        _isConnecting = false;
      });
    }
  }

  Future<void> _readAllSettings() async {
    try {
      final result = await _mcumgrSettings.readSettings();
      print("Read all result: $result");
    } catch (e) {
      print("Error reading settings: $e");
    }
  }

  Future<void> _readSingleSetting() async {
    final key = _settingsKeyController.text;
    if (key.isEmpty) {
      _showSnackBar('Please enter a settings key');
      return;
    }

    try {
      final rawResponse = await _mcumgrSettings.readSetting(key);

      if (rawResponse case Uint8List()) {
        String s = String.fromCharCodes(List.from(rawResponse)..removeAt(0));
        _showSnackBar('String value: $s');
      }

      try {
        final doubleValue = decodeDoubleSetting(rawResponse);
        _showSnackBar('Double value: $doubleValue');
      } catch (e) {
        try {
          final boolValue = decodeBoolSetting(rawResponse);
          _showSnackBar('Boolean value: $boolValue');
        } catch (e) {
          _showSnackBar('Raw response: ${rawResponse.toString()}');
        }
      }
    } catch (e) {
      _showSnackBar('Error reading setting: $e');
    }
  }

  Future<void> _writeSetting() async {
    final key = _settingsKeyController.text;
    final valueText = _writeValueController.text;

    if (key.isEmpty) {
      _showSnackBar('Please enter a settings key');
      return;
    }

    if (valueText.isEmpty) {
      _showSnackBar('Please enter a value to write');
      return;
    }

    // Parse the value to appropriate type
    dynamic parsedValue;

    // Check for boolean values
    if (valueText.toLowerCase() == 'true') {
      parsedValue = true;
    } else if (valueText.toLowerCase() == 'false') {
      parsedValue = false;
    } else {
      // Try parsing as int
      final intValue = int.tryParse(valueText);
      if (intValue != null) {
        parsedValue = intValue;
      } else {
        // Try parsing as double
        final doubleValue = double.tryParse(valueText);
        if (doubleValue != null) {
          parsedValue = doubleValue;
        } else {
          // Keep as string
          parsedValue = valueText;
        }
      }
    }

    try {
      final result = await _mcumgrSettings.writeSetting(key, parsedValue);
      if (result.isNotEmpty) {
        _showSnackBar('Successfully wrote setting: $key = $parsedValue (${parsedValue.runtimeType})');
      } else {
        _showSnackBar('Setting written successfully');
      }
    } catch (e) {
      _showSnackBar('Error writing setting: $e');
    }
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
        ),
      );
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
}
