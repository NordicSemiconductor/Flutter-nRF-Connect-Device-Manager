part of mcumgr_flutter;

class McuLogMessage {
  final String message;
  final McuMgrLogCategory category;
  final McuMgrLogLevel level;
  final DateTime dateTime;

  const McuLogMessage(this.message, this.category, this.level, this.dateTime);
}

class McuMgrLogCategory {
  final String _rawValue;

  const McuMgrLogCategory._value(this._rawValue);

  static const transport = McuMgrLogCategory._value("Transport");
  static const config = McuMgrLogCategory._value("ConfigManager");
  static const crash = McuMgrLogCategory._value("CrashManager");
  static const defaultLevel = McuMgrLogCategory._value("DefaultManager");
  static const fs = McuMgrLogCategory._value("FSManager");
  static const image = McuMgrLogCategory._value("ImageManager");
  static const log = McuMgrLogCategory._value("LogManager");
  static const runTest = McuMgrLogCategory._value("RunTestManager");
  static const stats = McuMgrLogCategory._value("StatsManager");
  static const dfu = McuMgrLogCategory._value("DFU");

  static List<McuMgrLogCategory> get values => [
        transport,
        config,
        crash,
        defaultLevel,
        fs,
        image,
        log,
        runTest,
        stats,
        dfu
      ];

  @override
  String toString() {
    return _rawValue;
  }
}

class McuMgrLogLevel {
  final int rawValue;

  const McuMgrLogLevel._value(this.rawValue);

  static const debug = McuMgrLogLevel._value(0);
  static const verbose = McuMgrLogLevel._value(1);
  static const info = McuMgrLogLevel._value(5);
  static const application = McuMgrLogLevel._value(10);
  static const warning = McuMgrLogLevel._value(15);
  static const error = McuMgrLogLevel._value(20);

  static List<McuMgrLogLevel> get values {
    return [
      debug,
      verbose,
      info,
      application,
      warning,
      error
    ];
  }

  String get shortName {
    switch (this) {
      case debug:
        return "D";
      case verbose:
        return "V";
      case info:
        return "I";
      case application:
        return "A";
      case warning:
        return "W";
      case error:
        return "E";
      default:
        return "";
    }
  }

  String get name {
    switch (this) {
      case debug:
        return "Debug";
      case verbose:
        return "Verbose";
      case info:
        return "Info";
      case application:
        return "Application";
      case warning:
        return "Warning";
      case error:
        return "Error";
      default:
        return "";
    }
  }
}
