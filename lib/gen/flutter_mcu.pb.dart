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

class ProtoUpdateCallArgument extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoUpdateCallArgument', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceUuid')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firmwareData', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ProtoUpdateCallArgument._() : super();
  factory ProtoUpdateCallArgument() => create();
  factory ProtoUpdateCallArgument.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoUpdateCallArgument.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoUpdateCallArgument clone() => ProtoUpdateCallArgument()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoUpdateCallArgument copyWith(void Function(ProtoUpdateCallArgument) updates) => super.copyWith((message) => updates(message as ProtoUpdateCallArgument)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateCallArgument create() => ProtoUpdateCallArgument._();
  ProtoUpdateCallArgument createEmptyInstance() => create();
  static $pb.PbList<ProtoUpdateCallArgument> createRepeated() => $pb.PbList<ProtoUpdateCallArgument>();
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateCallArgument getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoUpdateCallArgument>(create);
  static ProtoUpdateCallArgument _defaultInstance;

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

class ProtoUpdateStateChangesStreamArg extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoUpdateStateChangesStreamArg', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..aOM<ProtoUpdateStateChanges>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updateStateChanges', protoName: 'updateStateChanges', subBuilder: ProtoUpdateStateChanges.create)
    ..hasRequiredFields = false
  ;

  ProtoUpdateStateChangesStreamArg._() : super();
  factory ProtoUpdateStateChangesStreamArg() => create();
  factory ProtoUpdateStateChangesStreamArg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoUpdateStateChangesStreamArg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoUpdateStateChangesStreamArg clone() => ProtoUpdateStateChangesStreamArg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoUpdateStateChangesStreamArg copyWith(void Function(ProtoUpdateStateChangesStreamArg) updates) => super.copyWith((message) => updates(message as ProtoUpdateStateChangesStreamArg)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateStateChangesStreamArg create() => ProtoUpdateStateChangesStreamArg._();
  ProtoUpdateStateChangesStreamArg createEmptyInstance() => create();
  static $pb.PbList<ProtoUpdateStateChangesStreamArg> createRepeated() => $pb.PbList<ProtoUpdateStateChangesStreamArg>();
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateStateChangesStreamArg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoUpdateStateChangesStreamArg>(create);
  static ProtoUpdateStateChangesStreamArg _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);

  @$pb.TagNumber(2)
  ProtoUpdateStateChanges get updateStateChanges => $_getN(1);
  @$pb.TagNumber(2)
  set updateStateChanges(ProtoUpdateStateChanges v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdateStateChanges() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateStateChanges() => clearField(2);
  @$pb.TagNumber(2)
  ProtoUpdateStateChanges ensureUpdateStateChanges() => $_ensure(1);
}

class ProtoUpdateStateChanges extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoUpdateStateChanges', createEmptyInstance: create)
    ..e<ProtoUpdateStateChanges_FirmwareUpgradeState>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'oldState', $pb.PbFieldType.OE, protoName: 'oldState', defaultOrMaker: ProtoUpdateStateChanges_FirmwareUpgradeState.NONE, valueOf: ProtoUpdateStateChanges_FirmwareUpgradeState.valueOf, enumValues: ProtoUpdateStateChanges_FirmwareUpgradeState.values)
    ..e<ProtoUpdateStateChanges_FirmwareUpgradeState>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newState', $pb.PbFieldType.OE, protoName: 'newState', defaultOrMaker: ProtoUpdateStateChanges_FirmwareUpgradeState.NONE, valueOf: ProtoUpdateStateChanges_FirmwareUpgradeState.valueOf, enumValues: ProtoUpdateStateChanges_FirmwareUpgradeState.values)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'canceled')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasError', protoName: 'hasError')
    ..aOM<ProtoError>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'protoError', protoName: 'protoError', subBuilder: ProtoError.create)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completed')
    ..hasRequiredFields = false
  ;

  ProtoUpdateStateChanges._() : super();
  factory ProtoUpdateStateChanges() => create();
  factory ProtoUpdateStateChanges.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoUpdateStateChanges.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoUpdateStateChanges clone() => ProtoUpdateStateChanges()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoUpdateStateChanges copyWith(void Function(ProtoUpdateStateChanges) updates) => super.copyWith((message) => updates(message as ProtoUpdateStateChanges)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateStateChanges create() => ProtoUpdateStateChanges._();
  ProtoUpdateStateChanges createEmptyInstance() => create();
  static $pb.PbList<ProtoUpdateStateChanges> createRepeated() => $pb.PbList<ProtoUpdateStateChanges>();
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateStateChanges getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoUpdateStateChanges>(create);
  static ProtoUpdateStateChanges _defaultInstance;

  @$pb.TagNumber(1)
  ProtoUpdateStateChanges_FirmwareUpgradeState get oldState => $_getN(0);
  @$pb.TagNumber(1)
  set oldState(ProtoUpdateStateChanges_FirmwareUpgradeState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOldState() => $_has(0);
  @$pb.TagNumber(1)
  void clearOldState() => clearField(1);

  @$pb.TagNumber(2)
  ProtoUpdateStateChanges_FirmwareUpgradeState get newState => $_getN(1);
  @$pb.TagNumber(2)
  set newState(ProtoUpdateStateChanges_FirmwareUpgradeState v) { setField(2, v); }
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
  ProtoError get protoError => $_getN(4);
  @$pb.TagNumber(5)
  set protoError(ProtoError v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasProtoError() => $_has(4);
  @$pb.TagNumber(5)
  void clearProtoError() => clearField(5);
  @$pb.TagNumber(5)
  ProtoError ensureProtoError() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.bool get completed => $_getBF(5);
  @$pb.TagNumber(6)
  set completed($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCompleted() => $_has(5);
  @$pb.TagNumber(6)
  void clearCompleted() => clearField(6);
}

class ProtoProgressUpdateStreamArg extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoProgressUpdateStreamArg', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..aOM<ProtoProgressUpdate>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progressUpdate', protoName: 'progressUpdate', subBuilder: ProtoProgressUpdate.create)
    ..hasRequiredFields = false
  ;

  ProtoProgressUpdateStreamArg._() : super();
  factory ProtoProgressUpdateStreamArg() => create();
  factory ProtoProgressUpdateStreamArg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoProgressUpdateStreamArg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoProgressUpdateStreamArg clone() => ProtoProgressUpdateStreamArg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoProgressUpdateStreamArg copyWith(void Function(ProtoProgressUpdateStreamArg) updates) => super.copyWith((message) => updates(message as ProtoProgressUpdateStreamArg)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoProgressUpdateStreamArg create() => ProtoProgressUpdateStreamArg._();
  ProtoProgressUpdateStreamArg createEmptyInstance() => create();
  static $pb.PbList<ProtoProgressUpdateStreamArg> createRepeated() => $pb.PbList<ProtoProgressUpdateStreamArg>();
  @$core.pragma('dart2js:noInline')
  static ProtoProgressUpdateStreamArg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoProgressUpdateStreamArg>(create);
  static ProtoProgressUpdateStreamArg _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);

  @$pb.TagNumber(2)
  ProtoProgressUpdate get progressUpdate => $_getN(1);
  @$pb.TagNumber(2)
  set progressUpdate(ProtoProgressUpdate v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasProgressUpdate() => $_has(1);
  @$pb.TagNumber(2)
  void clearProgressUpdate() => clearField(2);
  @$pb.TagNumber(2)
  ProtoProgressUpdate ensureProgressUpdate() => $_ensure(1);
}

class ProtoProgressUpdate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoProgressUpdate', createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bytesSent', $pb.PbFieldType.OU6, protoName: 'bytesSent', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageSize', $pb.PbFieldType.OU6, protoName: 'imageSize', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ProtoProgressUpdate._() : super();
  factory ProtoProgressUpdate() => create();
  factory ProtoProgressUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoProgressUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoProgressUpdate clone() => ProtoProgressUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoProgressUpdate copyWith(void Function(ProtoProgressUpdate) updates) => super.copyWith((message) => updates(message as ProtoProgressUpdate)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoProgressUpdate create() => ProtoProgressUpdate._();
  ProtoProgressUpdate createEmptyInstance() => create();
  static $pb.PbList<ProtoProgressUpdate> createRepeated() => $pb.PbList<ProtoProgressUpdate>();
  @$core.pragma('dart2js:noInline')
  static ProtoProgressUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoProgressUpdate>(create);
  static ProtoProgressUpdate _defaultInstance;

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

class ProtoLogMessageStreamArg extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoLogMessageStreamArg', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..aOM<ProtoLogMessage>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'protoLogMessage', protoName: 'protoLogMessage', subBuilder: ProtoLogMessage.create)
    ..hasRequiredFields = false
  ;

  ProtoLogMessageStreamArg._() : super();
  factory ProtoLogMessageStreamArg() => create();
  factory ProtoLogMessageStreamArg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoLogMessageStreamArg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoLogMessageStreamArg clone() => ProtoLogMessageStreamArg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoLogMessageStreamArg copyWith(void Function(ProtoLogMessageStreamArg) updates) => super.copyWith((message) => updates(message as ProtoLogMessageStreamArg)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoLogMessageStreamArg create() => ProtoLogMessageStreamArg._();
  ProtoLogMessageStreamArg createEmptyInstance() => create();
  static $pb.PbList<ProtoLogMessageStreamArg> createRepeated() => $pb.PbList<ProtoLogMessageStreamArg>();
  @$core.pragma('dart2js:noInline')
  static ProtoLogMessageStreamArg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoLogMessageStreamArg>(create);
  static ProtoLogMessageStreamArg _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);

  @$pb.TagNumber(2)
  ProtoLogMessage get protoLogMessage => $_getN(1);
  @$pb.TagNumber(2)
  set protoLogMessage(ProtoLogMessage v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasProtoLogMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearProtoLogMessage() => clearField(2);
  @$pb.TagNumber(2)
  ProtoLogMessage ensureProtoLogMessage() => $_ensure(1);
}

class ProtoLogMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoLogMessage', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..e<ProtoLogMessage_LogCategory>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logCategory', $pb.PbFieldType.OE, protoName: 'logCategory', defaultOrMaker: ProtoLogMessage_LogCategory.TRANSPORT, valueOf: ProtoLogMessage_LogCategory.valueOf, enumValues: ProtoLogMessage_LogCategory.values)
    ..e<ProtoLogMessage_LogLevel>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logLevel', $pb.PbFieldType.OE, protoName: 'logLevel', defaultOrMaker: ProtoLogMessage_LogLevel.DEBUG, valueOf: ProtoLogMessage_LogLevel.valueOf, enumValues: ProtoLogMessage_LogLevel.values)
    ..hasRequiredFields = false
  ;

  ProtoLogMessage._() : super();
  factory ProtoLogMessage() => create();
  factory ProtoLogMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoLogMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoLogMessage clone() => ProtoLogMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoLogMessage copyWith(void Function(ProtoLogMessage) updates) => super.copyWith((message) => updates(message as ProtoLogMessage)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoLogMessage create() => ProtoLogMessage._();
  ProtoLogMessage createEmptyInstance() => create();
  static $pb.PbList<ProtoLogMessage> createRepeated() => $pb.PbList<ProtoLogMessage>();
  @$core.pragma('dart2js:noInline')
  static ProtoLogMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoLogMessage>(create);
  static ProtoLogMessage _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);

  @$pb.TagNumber(2)
  ProtoLogMessage_LogCategory get logCategory => $_getN(1);
  @$pb.TagNumber(2)
  set logCategory(ProtoLogMessage_LogCategory v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasLogCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearLogCategory() => clearField(2);

  @$pb.TagNumber(3)
  ProtoLogMessage_LogLevel get logLevel => $_getN(2);
  @$pb.TagNumber(3)
  set logLevel(ProtoLogMessage_LogLevel v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLogLevel() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogLevel() => clearField(3);
}

