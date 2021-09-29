import 'package:json_annotation/json_annotation.dart';

part 'manifest.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Manifest {
  @JsonKey(name: 'format-version')
  int formatVersion;
  int time;
  List<ManifestFile> files;

  factory Manifest.fromJson(Map<String, dynamic> json) =>
      _$ManifestFromJson(json);

  Manifest({
    required this.formatVersion,
    required this.time,
    required this.files,
  });
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ManifestFile {
  String? type;
  String? board;
  String? soc;
  int? loadAddress;
  @JsonKey(name: 'version_MCUBOOT')
  String? versionMcuboot;
  String? serialRecoveryIndex;
  int? size;
  int? modtime;
  String? version;

  // Required properties
  String file;
  int image;

  factory ManifestFile.fromJson(Map<String, dynamic> json) =>
      _$ManifestFileFromJson(json);

  ManifestFile({
    this.type,
    this.board,
    this.soc,
    this.loadAddress,
    this.versionMcuboot,
    this.serialRecoveryIndex,
    this.size,
    this.modtime,
    this.version,
    required this.file,
    required this.image,
  });
}
