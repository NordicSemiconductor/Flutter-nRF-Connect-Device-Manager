import 'package:json_annotation/json_annotation.dart';

part 'firmware_image.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ApplicationResponse {
  final int version;
  final List<Application> applications;

  ApplicationResponse({
    required this.version,
    required this.applications,
  });

  factory ApplicationResponse.fromJson(Map<String, dynamic> json) =>
      _$ApplicationResponseFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Application {
  String appId;
  String appName;
  String userId;
  String description;
  String? iconUrl;
  List<String> tags;
  List<Version> versions;

  Application({
    required this.appId,
    required this.appName,
    required this.userId,
    required this.description,
    this.iconUrl,
    required this.tags,
    required this.versions,
  });

  factory Application.fromJson(Map<String, dynamic> json) =>
      _$ApplicationFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Version {
  bool requiresBonding;
  String releaseNotes;
  String version;
  List<Link> links;
  List<Board> board;

  Version({
    required this.requiresBonding,
    required this.releaseNotes,
    required this.version,
    required this.links,
    required this.board,
  });

  factory Version.fromJson(Map<String, dynamic> json) =>
      _$VersionFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Board {
  String name;
  List<BuildConfig> buildConfig;

  Board({
    required this.name,
    required this.buildConfig,
  });

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BuildConfig {
  String name;
  String? cmake;
  String? appCoreConfig;
  List<ChildCore>? childCore;
  String? partMgr;
  String file;
  List<Option>? options;

  BuildConfig({
    required this.name,
    this.cmake,
    this.appCoreConfig,
    this.childCore,
    this.partMgr,
    required this.file,
    this.options,
  });

  factory BuildConfig.fromJson(Map<String, dynamic> json) =>
      _$BuildConfigFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ChildCore {
  String name;
  String config;

  ChildCore({
    required this.name,
    required this.config,
  });

  factory ChildCore.fromJson(Map<String, dynamic> json) =>
      _$ChildCoreFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Option {
  String name;
  String command;

  Option({
    required this.name,
    required this.command,
  });

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Link {
  String text;
  String url;

  Link({
    required this.text,
    required this.url,
  });

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
}
