///
//  Generated code. Do not modify.
//  source: flutter_mcu.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'flutter_mcu.pbenum.dart';

export 'flutter_mcu.pbenum.dart';

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

class ProtoError extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoError', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'localizedDescription', protoName: 'localizedDescription')
    ..hasRequiredFields = false
  ;

  ProtoError._() : super();
  factory ProtoError() => create();
  factory ProtoError.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoError.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoError clone() => ProtoError()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoError copyWith(void Function(ProtoError) updates) => super.copyWith((message) => updates(message as ProtoError)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoError create() => ProtoError._();
  ProtoError createEmptyInstance() => create();
  static $pb.PbList<ProtoError> createRepeated() => $pb.PbList<ProtoError>();
  @$core.pragma('dart2js:noInline')
  static ProtoError getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoError>(create);
  static ProtoError _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get localizedDescription => $_getSZ(0);
  @$pb.TagNumber(1)
  set localizedDescription($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLocalizedDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocalizedDescription() => clearField(1);
}

class UpdateStateChanges extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateStateChanges', createEmptyInstance: create)
    ..e<UpdateStateChanges_FirmwareUpgradeState>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'oldState', $pb.PbFieldType.OE, protoName: 'oldState', defaultOrMaker: UpdateStateChanges_FirmwareUpgradeState.NONE, valueOf: UpdateStateChanges_FirmwareUpgradeState.valueOf, enumValues: UpdateStateChanges_FirmwareUpgradeState.values)
    ..e<UpdateStateChanges_FirmwareUpgradeState>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newState', $pb.PbFieldType.OE, protoName: 'newState', defaultOrMaker: UpdateStateChanges_FirmwareUpgradeState.NONE, valueOf: UpdateStateChanges_FirmwareUpgradeState.valueOf, enumValues: UpdateStateChanges_FirmwareUpgradeState.values)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'canceled')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasError', protoName: 'hasError')
    ..aOM<ProtoError>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', subBuilder: ProtoError.create)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completed')
    ..hasRequiredFields = false
  ;

  UpdateStateChanges._() : super();
  factory UpdateStateChanges() => create();
  factory UpdateStateChanges.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateStateChanges.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateStateChanges clone() => UpdateStateChanges()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateStateChanges copyWith(void Function(UpdateStateChanges) updates) => super.copyWith((message) => updates(message as UpdateStateChanges)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateStateChanges create() => UpdateStateChanges._();
  UpdateStateChanges createEmptyInstance() => create();
  static $pb.PbList<UpdateStateChanges> createRepeated() => $pb.PbList<UpdateStateChanges>();
  @$core.pragma('dart2js:noInline')
  static UpdateStateChanges getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateStateChanges>(create);
  static UpdateStateChanges _defaultInstance;

  @$pb.TagNumber(1)
  UpdateStateChanges_FirmwareUpgradeState get oldState => $_getN(0);
  @$pb.TagNumber(1)
  set oldState(UpdateStateChanges_FirmwareUpgradeState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOldState() => $_has(0);
  @$pb.TagNumber(1)
  void clearOldState() => clearField(1);

  @$pb.TagNumber(2)
  UpdateStateChanges_FirmwareUpgradeState get newState => $_getN(1);
  @$pb.TagNumber(2)
  set newState(UpdateStateChanges_FirmwareUpgradeState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewState() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewState() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get canceled => $_getBF(2);
  @$pb.TagNumber(3)
  set canceled($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCanceled() => $_has(2);
  @$pb.TagNumber(3)
  void clearCanceled() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get hasError => $_getBF(3);
  @$pb.TagNumber(4)
  set hasError($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHasError() => $_has(3);
  @$pb.TagNumber(4)
  void clearHasError() => clearField(4);

  @$pb.TagNumber(5)
  ProtoError get error_5 => $_getN(4);
  @$pb.TagNumber(5)
  set error_5(ProtoError v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasError_5() => $_has(4);
  @$pb.TagNumber(5)
  void clearError_5() => clearField(5);
  @$pb.TagNumber(5)
  ProtoError ensureError_5() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.bool get completed => $_getBF(5);
  @$pb.TagNumber(6)
  set completed($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCompleted() => $_has(5);
  @$pb.TagNumber(6)
  void clearCompleted() => clearField(6);
}

class ProgressUpdate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProgressUpdate', createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bytesSent', $pb.PbFieldType.OU6, protoName: 'bytesSent', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageSize', $pb.PbFieldType.OU6, protoName: 'imageSize', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ProgressUpdate._() : super();
  factory ProgressUpdate() => create();
  factory ProgressUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProgressUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProgressUpdate clone() => ProgressUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProgressUpdate copyWith(void Function(ProgressUpdate) updates) => super.copyWith((message) => updates(message as ProgressUpdate)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProgressUpdate create() => ProgressUpdate._();
  ProgressUpdate createEmptyInstance() => create();
  static $pb.PbList<ProgressUpdate> createRepeated() => $pb.PbList<ProgressUpdate>();
  @$core.pragma('dart2js:noInline')
  static ProgressUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProgressUpdate>(create);
  static ProgressUpdate _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get bytesSent => $_getI64(0);
  @$pb.TagNumber(1)
  set bytesSent($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBytesSent() => $_has(0);
  @$pb.TagNumber(1)
  void clearBytesSent() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get imageSize => $_getI64(1);
  @$pb.TagNumber(2)
  set imageSize($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasImageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearImageSize() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get timestamp => $_getN(2);
  @$pb.TagNumber(3)
  set timestamp($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);
}

