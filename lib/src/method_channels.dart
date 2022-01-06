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
      const EventChannel(_namespace + '/updateInProgressChannel');
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

  static const update = const UpdateManagerMethod('update');
  static const getUpdateManager = const UpdateManagerMethod('getUpdateManager');
  static const pause = const UpdateManagerMethod('pause');
  static const resume = const UpdateManagerMethod('resume');
  static const isPaused = const UpdateManagerMethod('isPaused');
  static const isInProgress = const UpdateManagerMethod('isInProgress');
  static const cancel = const UpdateManagerMethod('cancel');
  static const kill = const UpdateManagerMethod('kill');
}

/// Channel methods related to Logger
class UpdateLoggerMethod {
  final String _rawValue;

  const UpdateLoggerMethod(this._rawValue);

  String get rawValue => _rawValue;

  static const getUpdateLogger = const UpdateManagerMethod('getUpdateLogger');
  static const enableLiveUpdate = const UpdateLoggerMethod('enableLiveUpdate');
  static const disableLiveUpdate =
      const UpdateLoggerMethod('disableLiveUpdate');
  static const getLogs = const UpdateLoggerMethod('getLogs');
}
