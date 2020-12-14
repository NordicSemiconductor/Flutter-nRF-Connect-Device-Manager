class McuLogMessage {
  final String message;
  final McuMgrLogCategory category;
  final McuMgrLogLevel level;

  const McuLogMessage(this.message, this.category, this.level);
}

class McuMgrLogCategory {
  final String rawValue;

  const McuMgrLogCategory(this.rawValue);

  static const transport = McuMgrLogCategory("Transport");
  static const config = McuMgrLogCategory("ConfigManager");
  static const crash = McuMgrLogCategory("CrashManager");
  static const defaultLevel = McuMgrLogCategory("DefaultManager");
  static const fs = McuMgrLogCategory("FSManager");
  static const image = McuMgrLogCategory("ImageManager");
  static const log = McuMgrLogCategory("LogManager");
  static const runTest = McuMgrLogCategory("RunTestManager");
  static const stats = McuMgrLogCategory("StatsManager");
  static const dfu = McuMgrLogCategory("DFU");
}

class McuMgrLogLevel {
  final int rawValue;

  const McuMgrLogLevel(this.rawValue);

  static const debug = McuMgrLogLevel(0);
  static const verbose = McuMgrLogLevel(1);
  static const info = McuMgrLogLevel(5);
  static const application = McuMgrLogLevel(10);
  static const warning = McuMgrLogLevel(15);
  static const error = McuMgrLogLevel(20);

  String get name {
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
}
