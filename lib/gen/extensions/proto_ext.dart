import 'package:mcumgr_flutter/gen/flutter_mcu.pb.dart';
import 'package:mcumgr_flutter/src/progress_update.dart';

extension ProtoProgressToModel on ProtoProgressUpdate {
  ProgressUpdate convert() {
    final int bytesSent = this.bytesSent as int;
    final int imageSize = this.imageSize as int;
    final int milliseconds = (this.timestamp * 1000) as int;
    final date = DateTime.fromMillisecondsSinceEpoch(milliseconds);

    return ProgressUpdate(bytesSent, imageSize, date);
  }
}
