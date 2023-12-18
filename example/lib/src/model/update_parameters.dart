import 'package:mcumgr_flutter_example/src/model/firmware_image.dart';

class UpdateParameters {
  String? deviceID;
  SelectedFirmware? firmware;
}

class SelectedFirmware {
  final Application application;
  final Version version;
  final Board board;
  final BuildConfig firmware;

  SelectedFirmware({
    required this.application,
    required this.version,
    required this.board,
    required this.firmware,
  });
}
