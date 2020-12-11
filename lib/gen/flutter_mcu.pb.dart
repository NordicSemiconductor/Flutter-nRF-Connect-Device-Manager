///
//  Generated code. Do not modify.
//  source: flutter_mcu.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class UpdateCallArgument extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateCallArgument', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceUuid')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firmwareData', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  UpdateCallArgument._() : super();
  factory UpdateCallArgument() => create();
  factory UpdateCallArgument.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateCallArgument.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateCallArgument clone() => UpdateCallArgument()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateCallArgument copyWith(void Function(UpdateCallArgument) updates) => super.copyWith((message) => updates(message as UpdateCallArgument)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateCallArgument create() => UpdateCallArgument._();
  UpdateCallArgument createEmptyInstance() => create();
  static $pb.PbList<UpdateCallArgument> createRepeated() => $pb.PbList<UpdateCallArgument>();
  @$core.pragma('dart2js:noInline')
  static UpdateCallArgument getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateCallArgument>(create);
  static UpdateCallArgument _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceUuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeviceUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceUuid() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get firmwareData => $_getN(1);
  @$pb.TagNumber(2)
  set firmwareData($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFirmwareData() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirmwareData() => clearField(2);
}

