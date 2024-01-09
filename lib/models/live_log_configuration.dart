import 'package:mcumgr_flutter/mcumgr_flutter.dart';

class LiveLogConfiguration {
  bool? enabled;
  McuMgrLogLevel? level;

  LiveLogConfiguration({this.enabled, this.level});
}
