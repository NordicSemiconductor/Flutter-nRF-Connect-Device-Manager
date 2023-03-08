///
//  Generated code. Do not modify.
//  source: lib/proto/flutter_mcu.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

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
  factory ProtoUpdateCallArgument({
    $core.String? deviceUuid,
    $core.List<$core.int>? firmwareData,
  }) {
    final _result = create();
    if (deviceUuid != null) {
      _result.deviceUuid = deviceUuid;
    }
    if (firmwareData != null) {
      _result.firmwareData = firmwareData;
    }
    return _result;
  }
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
  ProtoUpdateCallArgument copyWith(void Function(ProtoUpdateCallArgument) updates) => super.copyWith((message) => updates(message as ProtoUpdateCallArgument)) as ProtoUpdateCallArgument; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateCallArgument create() => ProtoUpdateCallArgument._();
  ProtoUpdateCallArgument createEmptyInstance() => create();
  static $pb.PbList<ProtoUpdateCallArgument> createRepeated() => $pb.PbList<ProtoUpdateCallArgument>();
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateCallArgument getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoUpdateCallArgument>(create);
  static ProtoUpdateCallArgument? _defaultInstance;

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
  factory ProtoError({
    $core.String? localizedDescription,
  }) {
    final _result = create();
    if (localizedDescription != null) {
      _result.localizedDescription = localizedDescription;
    }
    return _result;
  }
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
  ProtoError copyWith(void Function(ProtoError) updates) => super.copyWith((message) => updates(message as ProtoError)) as ProtoError; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoError create() => ProtoError._();
  ProtoError createEmptyInstance() => create();
  static $pb.PbList<ProtoError> createRepeated() => $pb.PbList<ProtoError>();
  @$core.pragma('dart2js:noInline')
  static ProtoError getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoError>(create);
  static ProtoError? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get localizedDescription => $_getSZ(0);
  @$pb.TagNumber(1)
  set localizedDescription($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLocalizedDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocalizedDescription() => clearField(1);
}

class Pair extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Pair', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.O3)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Pair._() : super();
  factory Pair({
    $core.int? key,
    $core.List<$core.int>? value,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory Pair.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Pair.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Pair clone() => Pair()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Pair copyWith(void Function(Pair) updates) => super.copyWith((message) => updates(message as Pair)) as Pair; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Pair create() => Pair._();
  Pair createEmptyInstance() => create();
  static $pb.PbList<Pair> createRepeated() => $pb.PbList<Pair>();
  @$core.pragma('dart2js:noInline')
  static Pair getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Pair>(create);
  static Pair? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class ProtoUpdateWithImageCallArguments extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoUpdateWithImageCallArguments', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceUuid')
    ..pc<Pair>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'images', $pb.PbFieldType.PM, subBuilder: Pair.create)
    ..aOM<ProtoFirmwareUpgradeConfiguration>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'configuration', subBuilder: ProtoFirmwareUpgradeConfiguration.create)
    ..hasRequiredFields = false
  ;

  ProtoUpdateWithImageCallArguments._() : super();
  factory ProtoUpdateWithImageCallArguments({
    $core.String? deviceUuid,
    $core.Iterable<Pair>? images,
    ProtoFirmwareUpgradeConfiguration? configuration,
  }) {
    final _result = create();
    if (deviceUuid != null) {
      _result.deviceUuid = deviceUuid;
    }
    if (images != null) {
      _result.images.addAll(images);
    }
    if (configuration != null) {
      _result.configuration = configuration;
    }
    return _result;
  }
  factory ProtoUpdateWithImageCallArguments.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoUpdateWithImageCallArguments.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoUpdateWithImageCallArguments clone() => ProtoUpdateWithImageCallArguments()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoUpdateWithImageCallArguments copyWith(void Function(ProtoUpdateWithImageCallArguments) updates) => super.copyWith((message) => updates(message as ProtoUpdateWithImageCallArguments)) as ProtoUpdateWithImageCallArguments; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateWithImageCallArguments create() => ProtoUpdateWithImageCallArguments._();
  ProtoUpdateWithImageCallArguments createEmptyInstance() => create();
  static $pb.PbList<ProtoUpdateWithImageCallArguments> createRepeated() => $pb.PbList<ProtoUpdateWithImageCallArguments>();
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateWithImageCallArguments getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoUpdateWithImageCallArguments>(create);
  static ProtoUpdateWithImageCallArguments? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceUuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeviceUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceUuid() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Pair> get images => $_getList(1);

  @$pb.TagNumber(3)
  ProtoFirmwareUpgradeConfiguration get configuration => $_getN(2);
  @$pb.TagNumber(3)
  set configuration(ProtoFirmwareUpgradeConfiguration v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasConfiguration() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfiguration() => clearField(3);
  @$pb.TagNumber(3)
  ProtoFirmwareUpgradeConfiguration ensureConfiguration() => $_ensure(2);
}

class ProtoUpdateStateChangesStreamArg extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoUpdateStateChangesStreamArg', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'done')
    ..aOM<ProtoError>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', subBuilder: ProtoError.create)
    ..aOM<ProtoUpdateStateChanges>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updateStateChanges', protoName: 'updateStateChanges', subBuilder: ProtoUpdateStateChanges.create)
    ..hasRequiredFields = false
  ;

  ProtoUpdateStateChangesStreamArg._() : super();
  factory ProtoUpdateStateChangesStreamArg({
    $core.String? uuid,
    $core.bool? done,
    ProtoError? error,
    ProtoUpdateStateChanges? updateStateChanges,
  }) {
    final _result = create();
    if (uuid != null) {
      _result.uuid = uuid;
    }
    if (done != null) {
      _result.done = done;
    }
    if (error != null) {
      _result.error = error;
    }
    if (updateStateChanges != null) {
      _result.updateStateChanges = updateStateChanges;
    }
    return _result;
  }
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
  ProtoUpdateStateChangesStreamArg copyWith(void Function(ProtoUpdateStateChangesStreamArg) updates) => super.copyWith((message) => updates(message as ProtoUpdateStateChangesStreamArg)) as ProtoUpdateStateChangesStreamArg; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateStateChangesStreamArg create() => ProtoUpdateStateChangesStreamArg._();
  ProtoUpdateStateChangesStreamArg createEmptyInstance() => create();
  static $pb.PbList<ProtoUpdateStateChangesStreamArg> createRepeated() => $pb.PbList<ProtoUpdateStateChangesStreamArg>();
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateStateChangesStreamArg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoUpdateStateChangesStreamArg>(create);
  static ProtoUpdateStateChangesStreamArg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get done => $_getBF(1);
  @$pb.TagNumber(2)
  set done($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDone() => $_has(1);
  @$pb.TagNumber(2)
  void clearDone() => clearField(2);

  @$pb.TagNumber(3)
  ProtoError get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(ProtoError v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => clearField(3);
  @$pb.TagNumber(3)
  ProtoError ensureError() => $_ensure(2);

  @$pb.TagNumber(4)
  ProtoUpdateStateChanges get updateStateChanges => $_getN(3);
  @$pb.TagNumber(4)
  set updateStateChanges(ProtoUpdateStateChanges v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasUpdateStateChanges() => $_has(3);
  @$pb.TagNumber(4)
  void clearUpdateStateChanges() => clearField(4);
  @$pb.TagNumber(4)
  ProtoUpdateStateChanges ensureUpdateStateChanges() => $_ensure(3);
}

class ProtoUpdateStateChanges extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoUpdateStateChanges', createEmptyInstance: create)
    ..e<ProtoUpdateStateChanges_FirmwareUpgradeState>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'oldState', $pb.PbFieldType.OE, protoName: 'oldState', defaultOrMaker: ProtoUpdateStateChanges_FirmwareUpgradeState.NONE, valueOf: ProtoUpdateStateChanges_FirmwareUpgradeState.valueOf, enumValues: ProtoUpdateStateChanges_FirmwareUpgradeState.values)
    ..e<ProtoUpdateStateChanges_FirmwareUpgradeState>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newState', $pb.PbFieldType.OE, protoName: 'newState', defaultOrMaker: ProtoUpdateStateChanges_FirmwareUpgradeState.NONE, valueOf: ProtoUpdateStateChanges_FirmwareUpgradeState.valueOf, enumValues: ProtoUpdateStateChanges_FirmwareUpgradeState.values)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'canceled')
    ..hasRequiredFields = false
  ;

  ProtoUpdateStateChanges._() : super();
  factory ProtoUpdateStateChanges({
    ProtoUpdateStateChanges_FirmwareUpgradeState? oldState,
    ProtoUpdateStateChanges_FirmwareUpgradeState? newState,
    $core.bool? canceled,
  }) {
    final _result = create();
    if (oldState != null) {
      _result.oldState = oldState;
    }
    if (newState != null) {
      _result.newState = newState;
    }
    if (canceled != null) {
      _result.canceled = canceled;
    }
    return _result;
  }
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
  ProtoUpdateStateChanges copyWith(void Function(ProtoUpdateStateChanges) updates) => super.copyWith((message) => updates(message as ProtoUpdateStateChanges)) as ProtoUpdateStateChanges; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateStateChanges create() => ProtoUpdateStateChanges._();
  ProtoUpdateStateChanges createEmptyInstance() => create();
  static $pb.PbList<ProtoUpdateStateChanges> createRepeated() => $pb.PbList<ProtoUpdateStateChanges>();
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateStateChanges getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoUpdateStateChanges>(create);
  static ProtoUpdateStateChanges? _defaultInstance;

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
}

class ProtoFirmwareUpgradeConfiguration extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoFirmwareUpgradeConfiguration', createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'estimatedSwapTimeMs', protoName: 'estimatedSwapTimeMs')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'eraseAppSettings', protoName: 'eraseAppSettings')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pipelineDepth', protoName: 'pipelineDepth')
    ..e<ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'byteAlignment', $pb.PbFieldType.OE, protoName: 'byteAlignment', defaultOrMaker: ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment.DISABLED, valueOf: ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment.valueOf, enumValues: ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment.values)
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reassemblyBufferSize', $pb.PbFieldType.OU6, protoName: 'reassemblyBufferSize', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  ProtoFirmwareUpgradeConfiguration._() : super();
  factory ProtoFirmwareUpgradeConfiguration({
    $fixnum.Int64? estimatedSwapTimeMs,
    $core.bool? eraseAppSettings,
    $fixnum.Int64? pipelineDepth,
    ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment? byteAlignment,
    $fixnum.Int64? reassemblyBufferSize,
  }) {
    final _result = create();
    if (estimatedSwapTimeMs != null) {
      _result.estimatedSwapTimeMs = estimatedSwapTimeMs;
    }
    if (eraseAppSettings != null) {
      _result.eraseAppSettings = eraseAppSettings;
    }
    if (pipelineDepth != null) {
      _result.pipelineDepth = pipelineDepth;
    }
    if (byteAlignment != null) {
      _result.byteAlignment = byteAlignment;
    }
    if (reassemblyBufferSize != null) {
      _result.reassemblyBufferSize = reassemblyBufferSize;
    }
    return _result;
  }
  factory ProtoFirmwareUpgradeConfiguration.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoFirmwareUpgradeConfiguration.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoFirmwareUpgradeConfiguration clone() => ProtoFirmwareUpgradeConfiguration()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoFirmwareUpgradeConfiguration copyWith(void Function(ProtoFirmwareUpgradeConfiguration) updates) => super.copyWith((message) => updates(message as ProtoFirmwareUpgradeConfiguration)) as ProtoFirmwareUpgradeConfiguration; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoFirmwareUpgradeConfiguration create() => ProtoFirmwareUpgradeConfiguration._();
  ProtoFirmwareUpgradeConfiguration createEmptyInstance() => create();
  static $pb.PbList<ProtoFirmwareUpgradeConfiguration> createRepeated() => $pb.PbList<ProtoFirmwareUpgradeConfiguration>();
  @$core.pragma('dart2js:noInline')
  static ProtoFirmwareUpgradeConfiguration getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoFirmwareUpgradeConfiguration>(create);
  static ProtoFirmwareUpgradeConfiguration? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get estimatedSwapTimeMs => $_getI64(0);
  @$pb.TagNumber(1)
  set estimatedSwapTimeMs($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEstimatedSwapTimeMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearEstimatedSwapTimeMs() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get eraseAppSettings => $_getBF(1);
  @$pb.TagNumber(2)
  set eraseAppSettings($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEraseAppSettings() => $_has(1);
  @$pb.TagNumber(2)
  void clearEraseAppSettings() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get pipelineDepth => $_getI64(2);
  @$pb.TagNumber(3)
  set pipelineDepth($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPipelineDepth() => $_has(2);
  @$pb.TagNumber(3)
  void clearPipelineDepth() => clearField(3);

  @$pb.TagNumber(4)
  ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment get byteAlignment => $_getN(3);
  @$pb.TagNumber(4)
  set byteAlignment(ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasByteAlignment() => $_has(3);
  @$pb.TagNumber(4)
  void clearByteAlignment() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get reassemblyBufferSize => $_getI64(4);
  @$pb.TagNumber(5)
  set reassemblyBufferSize($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReassemblyBufferSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearReassemblyBufferSize() => clearField(5);
}

class ProtoProgressUpdateStreamArg extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoProgressUpdateStreamArg', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'done')
    ..aOM<ProtoError>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', subBuilder: ProtoError.create)
    ..aOM<ProtoProgressUpdate>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progressUpdate', protoName: 'progressUpdate', subBuilder: ProtoProgressUpdate.create)
    ..hasRequiredFields = false
  ;

  ProtoProgressUpdateStreamArg._() : super();
  factory ProtoProgressUpdateStreamArg({
    $core.String? uuid,
    $core.bool? done,
    ProtoError? error,
    ProtoProgressUpdate? progressUpdate,
  }) {
    final _result = create();
    if (uuid != null) {
      _result.uuid = uuid;
    }
    if (done != null) {
      _result.done = done;
    }
    if (error != null) {
      _result.error = error;
    }
    if (progressUpdate != null) {
      _result.progressUpdate = progressUpdate;
    }
    return _result;
  }
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
  ProtoProgressUpdateStreamArg copyWith(void Function(ProtoProgressUpdateStreamArg) updates) => super.copyWith((message) => updates(message as ProtoProgressUpdateStreamArg)) as ProtoProgressUpdateStreamArg; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoProgressUpdateStreamArg create() => ProtoProgressUpdateStreamArg._();
  ProtoProgressUpdateStreamArg createEmptyInstance() => create();
  static $pb.PbList<ProtoProgressUpdateStreamArg> createRepeated() => $pb.PbList<ProtoProgressUpdateStreamArg>();
  @$core.pragma('dart2js:noInline')
  static ProtoProgressUpdateStreamArg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoProgressUpdateStreamArg>(create);
  static ProtoProgressUpdateStreamArg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get done => $_getBF(1);
  @$pb.TagNumber(2)
  set done($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDone() => $_has(1);
  @$pb.TagNumber(2)
  void clearDone() => clearField(2);

  @$pb.TagNumber(3)
  ProtoError get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(ProtoError v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => clearField(3);
  @$pb.TagNumber(3)
  ProtoError ensureError() => $_ensure(2);

  @$pb.TagNumber(4)
  ProtoProgressUpdate get progressUpdate => $_getN(3);
  @$pb.TagNumber(4)
  set progressUpdate(ProtoProgressUpdate v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasProgressUpdate() => $_has(3);
  @$pb.TagNumber(4)
  void clearProgressUpdate() => clearField(4);
  @$pb.TagNumber(4)
  ProtoProgressUpdate ensureProgressUpdate() => $_ensure(3);
}

class ProtoProgressUpdate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoProgressUpdate', createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bytesSent', $pb.PbFieldType.OU6, protoName: 'bytesSent', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageSize', $pb.PbFieldType.OU6, protoName: 'imageSize', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ProtoProgressUpdate._() : super();
  factory ProtoProgressUpdate({
    $fixnum.Int64? bytesSent,
    $fixnum.Int64? imageSize,
    $core.double? timestamp,
  }) {
    final _result = create();
    if (bytesSent != null) {
      _result.bytesSent = bytesSent;
    }
    if (imageSize != null) {
      _result.imageSize = imageSize;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    return _result;
  }
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
  ProtoProgressUpdate copyWith(void Function(ProtoProgressUpdate) updates) => super.copyWith((message) => updates(message as ProtoProgressUpdate)) as ProtoProgressUpdate; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoProgressUpdate create() => ProtoProgressUpdate._();
  ProtoProgressUpdate createEmptyInstance() => create();
  static $pb.PbList<ProtoProgressUpdate> createRepeated() => $pb.PbList<ProtoProgressUpdate>();
  @$core.pragma('dart2js:noInline')
  static ProtoProgressUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoProgressUpdate>(create);
  static ProtoProgressUpdate? _defaultInstance;

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
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'done')
    ..aOM<ProtoError>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', subBuilder: ProtoError.create)
    ..pc<ProtoLogMessage>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'protoLogMessage', $pb.PbFieldType.PM, protoName: 'protoLogMessage', subBuilder: ProtoLogMessage.create)
    ..hasRequiredFields = false
  ;

  ProtoLogMessageStreamArg._() : super();
  factory ProtoLogMessageStreamArg({
    $core.String? uuid,
    $core.bool? done,
    ProtoError? error,
    $core.Iterable<ProtoLogMessage>? protoLogMessage,
  }) {
    final _result = create();
    if (uuid != null) {
      _result.uuid = uuid;
    }
    if (done != null) {
      _result.done = done;
    }
    if (error != null) {
      _result.error = error;
    }
    if (protoLogMessage != null) {
      _result.protoLogMessage.addAll(protoLogMessage);
    }
    return _result;
  }
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
  ProtoLogMessageStreamArg copyWith(void Function(ProtoLogMessageStreamArg) updates) => super.copyWith((message) => updates(message as ProtoLogMessageStreamArg)) as ProtoLogMessageStreamArg; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoLogMessageStreamArg create() => ProtoLogMessageStreamArg._();
  ProtoLogMessageStreamArg createEmptyInstance() => create();
  static $pb.PbList<ProtoLogMessageStreamArg> createRepeated() => $pb.PbList<ProtoLogMessageStreamArg>();
  @$core.pragma('dart2js:noInline')
  static ProtoLogMessageStreamArg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoLogMessageStreamArg>(create);
  static ProtoLogMessageStreamArg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get done => $_getBF(1);
  @$pb.TagNumber(2)
  set done($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDone() => $_has(1);
  @$pb.TagNumber(2)
  void clearDone() => clearField(2);

  @$pb.TagNumber(3)
  ProtoError get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(ProtoError v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => clearField(3);
  @$pb.TagNumber(3)
  ProtoError ensureError() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<ProtoLogMessage> get protoLogMessage => $_getList(3);
}

class ProtoLogMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoLogMessage', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..e<ProtoLogMessage_LogCategory>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logCategory', $pb.PbFieldType.OE, protoName: 'logCategory', defaultOrMaker: ProtoLogMessage_LogCategory.TRANSPORT, valueOf: ProtoLogMessage_LogCategory.valueOf, enumValues: ProtoLogMessage_LogCategory.values)
    ..e<ProtoLogMessage_LogLevel>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logLevel', $pb.PbFieldType.OE, protoName: 'logLevel', defaultOrMaker: ProtoLogMessage_LogLevel.DEBUG, valueOf: ProtoLogMessage_LogLevel.valueOf, enumValues: ProtoLogMessage_LogLevel.values)
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logDateTime', protoName: 'logDateTime')
    ..hasRequiredFields = false
  ;

  ProtoLogMessage._() : super();
  factory ProtoLogMessage({
    $core.String? message,
    ProtoLogMessage_LogCategory? logCategory,
    ProtoLogMessage_LogLevel? logLevel,
    $fixnum.Int64? logDateTime,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    if (logCategory != null) {
      _result.logCategory = logCategory;
    }
    if (logLevel != null) {
      _result.logLevel = logLevel;
    }
    if (logDateTime != null) {
      _result.logDateTime = logDateTime;
    }
    return _result;
  }
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
  ProtoLogMessage copyWith(void Function(ProtoLogMessage) updates) => super.copyWith((message) => updates(message as ProtoLogMessage)) as ProtoLogMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoLogMessage create() => ProtoLogMessage._();
  ProtoLogMessage createEmptyInstance() => create();
  static $pb.PbList<ProtoLogMessage> createRepeated() => $pb.PbList<ProtoLogMessage>();
  @$core.pragma('dart2js:noInline')
  static ProtoLogMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoLogMessage>(create);
  static ProtoLogMessage? _defaultInstance;

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

  @$pb.TagNumber(4)
  $fixnum.Int64 get logDateTime => $_getI64(3);
  @$pb.TagNumber(4)
  set logDateTime($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLogDateTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogDateTime() => clearField(4);
}

class ProtoMessageLiveLogEnabled extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProtoMessageLiveLogEnabled', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enabled')
    ..hasRequiredFields = false
  ;

  ProtoMessageLiveLogEnabled._() : super();
  factory ProtoMessageLiveLogEnabled({
    $core.String? uuid,
    $core.bool? enabled,
  }) {
    final _result = create();
    if (uuid != null) {
      _result.uuid = uuid;
    }
    if (enabled != null) {
      _result.enabled = enabled;
    }
    return _result;
  }
  factory ProtoMessageLiveLogEnabled.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProtoMessageLiveLogEnabled.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProtoMessageLiveLogEnabled clone() => ProtoMessageLiveLogEnabled()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProtoMessageLiveLogEnabled copyWith(void Function(ProtoMessageLiveLogEnabled) updates) => super.copyWith((message) => updates(message as ProtoMessageLiveLogEnabled)) as ProtoMessageLiveLogEnabled; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProtoMessageLiveLogEnabled create() => ProtoMessageLiveLogEnabled._();
  ProtoMessageLiveLogEnabled createEmptyInstance() => create();
  static $pb.PbList<ProtoMessageLiveLogEnabled> createRepeated() => $pb.PbList<ProtoMessageLiveLogEnabled>();
  @$core.pragma('dart2js:noInline')
  static ProtoMessageLiveLogEnabled getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtoMessageLiveLogEnabled>(create);
  static ProtoMessageLiveLogEnabled? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get enabled => $_getBF(1);
  @$pb.TagNumber(2)
  set enabled($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEnabled() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnabled() => clearField(2);
}

