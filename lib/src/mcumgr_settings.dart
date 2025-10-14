import 'dart:async';

import 'package:flutter/services.dart';

import 'mcumgr_update_logger.dart';

enum PrecisionMode {
  auto('auto'),
  forceFloat32('forceFloat32'),
  forceDouble64('forceDouble64');

  const PrecisionMode(this.value);

  final String value;
}

const _methodChannel = MethodChannel('mcumgr_flutter/method_channel');

final class McumgrSettings {
  StreamSubscription? _streamSubscription = null;

  Future<void> init({
    required String deviceAddress,
    bool padTo4Bytes = false,
    bool encodeValueToCBOR = false,
    bool logEnabled = false,
    PrecisionMode precisionMode = PrecisionMode.auto,
  }) async {
    if (logEnabled) {
      final logger = McuMgrLogger.deviceIdentifier(deviceAddress);
      _streamSubscription = logger.logMessageStream.listen((logMessage) {
        print("MCUMGR Log: ${logMessage.message}");
      });
    }

    return _methodChannel.invokeMethod('initSettings', {
      'deviceAddress': deviceAddress,
      'padTo4Bytes': padTo4Bytes,
      'encodeValueToCBOR': encodeValueToCBOR,
      'precisionMode': precisionMode.value,
    });
  }

  Future<String> readSettings() async {
    final result = await _methodChannel.invokeMethod<String>('fetchSettings');

    if (result == null) {
      throw Exception("No response from native plugin");
    }

    return result;
  }

  Future<T> readSetting<T>(String key) async {
    final result = await _methodChannel.invokeMethod<T>('readSetting', key);

    if (result == null) {
      throw Exception("No response from native plugin");
    }

    return result;
  }

  Future<Uint8List> writeSetting(String key, dynamic value) async {
    final resultBytes = await _methodChannel.invokeMethod<Uint8List>('writeSetting', {'key': key, 'value': value});
    if (resultBytes == null) {
      throw Exception("No response from native plugin");
    }
    return resultBytes;
  }

  Future<void> dispose() {
    _streamSubscription?.cancel();
    return _methodChannel.invokeMethod('disposeSettings');
  }
}
