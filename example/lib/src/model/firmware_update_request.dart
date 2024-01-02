import 'dart:typed_data';

import 'package:mcumgr_flutter_example/src/model/firmware_image.dart';
import 'package:tuple/tuple.dart';

class FirmwareUpdateRequest {
  SelectedFirmware? firmware;
  SelectedPeripheral? peripheral;
  Uint8List? zipFile;
  List<Tuple2<int, Uint8List>>? firmwareImages;
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

  @override
  String toString() {
    return 'SelectedFirmware{application: $application, version: $version, board: $board, firmware: $firmware}';
  }
}

class SelectedPeripheral {
  final String name;
  final String identifier;

  SelectedPeripheral({
    required this.name,
    required this.identifier,
  });
}
