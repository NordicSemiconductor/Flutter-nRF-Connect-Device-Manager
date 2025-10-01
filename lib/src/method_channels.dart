import 'package:flutter/services.dart';

const _namespace = "mcumgr_flutter";
const MethodChannel methodChannel =
    const MethodChannel(_namespace + '/method_channel');

class UpdateManagerChannel {
  static const EventChannel progressStream =
      const EventChannel(_namespace + '/update_progress_event_channel');
  static const EventChannel updateStateStream =
      const EventChannel(_namespace + '/update_state_event_channel');
  static const EventChannel updateInProgressChannel =
      const EventChannel(_namespace + '/update_in_progress_channel');
}

class UpdateLoggerChannel {
  // channel for log messages
  static const EventChannel logEventChannel =
      const EventChannel(_namespace + '/log_event_channel');
}

/// Channel methods related to UpdateManager
class UpdateManagerMethod {
  final String _rawValue;

  const UpdateManagerMethod(this._rawValue);

  String get rawValue => _rawValue;

  static const initializeUpdateManager =
      const UpdateManagerMethod('initializeUpdateManager');
  static const update = const UpdateManagerMethod('update');
  static const updateSingleImage =
      const UpdateManagerMethod('updateSingleImage');
  static const pause = const UpdateManagerMethod('pause');
  static const resume = const UpdateManagerMethod('resume');
  static const isPaused = const UpdateManagerMethod('isPaused');
  static const isInProgress = const UpdateManagerMethod('isInProgress');
  static const cancel = const UpdateManagerMethod('cancel');
  static const kill = const UpdateManagerMethod('kill');
  static const readImageList = const UpdateManagerMethod('readImageList');
  static const erase = const UpdateManagerMethod('erase');
}

/// Channel methods related to Logger
class UpdateLoggerMethod {
  final String _rawValue;

  const UpdateLoggerMethod(this._rawValue);

  String get rawValue => _rawValue;

  static const readLogs = const UpdateLoggerMethod('readLogs');
  static const clearLogs = const UpdateLoggerMethod('clearLogs');
}
