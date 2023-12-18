// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firmware_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationResponse _$ApplicationResponseFromJson(Map<String, dynamic> json) =>
    ApplicationResponse(
      version: json['version'] as int,
      applications: (json['applications'] as List<dynamic>)
          .map((e) => Application.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApplicationResponseToJson(
        ApplicationResponse instance) =>
    <String, dynamic>{
      'version': instance.version,
      'applications': instance.applications,
    };

Application _$ApplicationFromJson(Map<String, dynamic> json) => Application(
      appId: json['app_id'] as String,
      appName: json['app_name'] as String,
      userId: json['user_id'] as String,
      description: json['description'] as String,
      iconUrl: json['icon_url'] as String?,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      versions: (json['versions'] as List<dynamic>)
          .map((e) => Version.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApplicationToJson(Application instance) =>
    <String, dynamic>{
      'app_id': instance.appId,
      'app_name': instance.appName,
      'user_id': instance.userId,
      'description': instance.description,
      'icon_url': instance.iconUrl,
      'tags': instance.tags,
      'versions': instance.versions,
    };

Version _$VersionFromJson(Map<String, dynamic> json) => Version(
      requiresBonding: json['requires_bonding'] as bool,
      releaseNotes: json['release_notes'] as String,
      version: json['version'] as String,
      links: (json['links'] as List<dynamic>)
          .map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      board: (json['board'] as List<dynamic>)
          .map((e) => Board.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VersionToJson(Version instance) => <String, dynamic>{
      'requires_bonding': instance.requiresBonding,
      'release_notes': instance.releaseNotes,
      'version': instance.version,
      'links': instance.links,
      'board': instance.board,
    };

Board _$BoardFromJson(Map<String, dynamic> json) => Board(
      name: json['name'] as String,
      buildConfig: (json['build_config'] as List<dynamic>)
          .map((e) => BuildConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BoardToJson(Board instance) => <String, dynamic>{
      'name': instance.name,
      'build_config': instance.buildConfig,
    };

BuildConfig _$BuildConfigFromJson(Map<String, dynamic> json) => BuildConfig(
      name: json['name'] as String,
      cmake: json['cmake'] as String?,
      appCoreConfig: json['app_core_config'] as String?,
      childCore: (json['child_core'] as List<dynamic>?)
          ?.map((e) => ChildCore.fromJson(e as Map<String, dynamic>))
          .toList(),
      partMgr: json['part_mgr'] as String?,
      file: json['file'] as String,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BuildConfigToJson(BuildConfig instance) =>
    <String, dynamic>{
      'name': instance.name,
      'cmake': instance.cmake,
      'app_core_config': instance.appCoreConfig,
      'child_core': instance.childCore,
      'part_mgr': instance.partMgr,
      'file': instance.file,
      'options': instance.options,
    };

ChildCore _$ChildCoreFromJson(Map<String, dynamic> json) => ChildCore(
      name: json['name'] as String,
      config: json['config'] as String,
    );

Map<String, dynamic> _$ChildCoreToJson(ChildCore instance) => <String, dynamic>{
      'name': instance.name,
      'config': instance.config,
    };

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      name: json['name'] as String,
      command: json['command'] as String,
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'name': instance.name,
      'command': instance.command,
    };

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      text: json['text'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'text': instance.text,
      'url': instance.url,
    };
