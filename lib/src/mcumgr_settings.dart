import 'package:flutter/services.dart';

const _methodChannel = MethodChannel('mcumgr_flutter/method_channel');

final class McumgrSettings {
  Future<void> init(String deviceAddress) {
    return _methodChannel.invokeMethod('initSettings', deviceAddress);
  }

  Future<String> readSettings() async {
    final result = await _methodChannel.invokeMethod<String>('fetchSettings');

    if (result == null) {
      throw Exception("No response from native plugin");
    }

    return result;
    ;
  }

  Future<T> readSetting<T>(String key) async {
    final result = await _methodChannel.invokeMethod<T>('readSetting', key);

    if (result == null) {
      throw Exception("No response from native plugin");
    }

    return result;
  }

  Future<Uint8List> writeSetting(String key, Uint8List value) async {
    final resultBytes = await _methodChannel.invokeMethod<Uint8List>('writeSetting', {'key': key, 'value': value});
    if (resultBytes == null) {
      throw Exception("No response from native plugin");
    }
    return resultBytes;
  }

  Future<void> dispose() {
    return _methodChannel.invokeMethod('disposeSettings');
  }
}
