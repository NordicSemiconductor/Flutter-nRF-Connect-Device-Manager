
import 'dart:async';

import 'package:flutter/services.dart';

class McumgrFlutter {
  static const MethodChannel _channel =
      const MethodChannel('mcumgr_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
