// This is a generated file - do not edit.
//
// Generated from lib/proto/flutter_mcu.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'flutter_mcu.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'flutter_mcu.pbenum.dart';

/// Flutter call arguments
class ProtoUpdateCallArgument extends $pb.GeneratedMessage {
  factory ProtoUpdateCallArgument({
    $core.String? deviceUuid,
    $core.List<$core.int>? hash,
    $core.List<$core.int>? firmwareData,
    ProtoFirmwareUpgradeConfiguration? configuration,
  }) {
    final result = create();
    if (deviceUuid != null) result.deviceUuid = deviceUuid;
    if (hash != null) result.hash = hash;
    if (firmwareData != null) result.firmwareData = firmwareData;
    if (configuration != null) result.configuration = configuration;
    return result;
  }

  ProtoUpdateCallArgument._();

  factory ProtoUpdateCallArgument.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProtoUpdateCallArgument.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProtoUpdateCallArgument',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceUuid')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'hash', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'firmwareData', $pb.PbFieldType.OY)
    ..aOM<ProtoFirmwareUpgradeConfiguration>(
        4, _omitFieldNames ? '' : 'configuration',
        subBuilder: ProtoFirmwareUpgradeConfiguration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoUpdateCallArgument clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoUpdateCallArgument copyWith(
          void Function(ProtoUpdateCallArgument) updates) =>
      super.copyWith((message) => updates(message as ProtoUpdateCallArgument))
          as ProtoUpdateCallArgument;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoUpdateCallArgument create() => ProtoUpdateCallArgument._();
  @$core.override
  ProtoUpdateCallArgument createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateCallArgument getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProtoUpdateCallArgument>(create);
  static ProtoUpdateCallArgument? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceUuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDeviceUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get hash => $_getN(1);
  @$pb.TagNumber(2)
  set hash($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearHash() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get firmwareData => $_getN(2);
  @$pb.TagNumber(3)
  set firmwareData($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFirmwareData() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirmwareData() => $_clearField(3);

  @$pb.TagNumber(4)
  ProtoFirmwareUpgradeConfiguration get configuration => $_getN(3);
  @$pb.TagNumber(4)
  set configuration(ProtoFirmwareUpgradeConfiguration value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasConfiguration() => $_has(3);
  @$pb.TagNumber(4)
  void clearConfiguration() => $_clearField(4);
  @$pb.TagNumber(4)
  ProtoFirmwareUpgradeConfiguration ensureConfiguration() => $_ensure(3);
}

class ProtoError extends $pb.GeneratedMessage {
  factory ProtoError({
    $core.String? localizedDescription,
  }) {
    final result = create();
    if (localizedDescription != null)
      result.localizedDescription = localizedDescription;
    return result;
  }

  ProtoError._();

  factory ProtoError.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProtoError.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProtoError',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'localizedDescription',
        protoName: 'localizedDescription')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoError clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoError copyWith(void Function(ProtoError) updates) =>
      super.copyWith((message) => updates(message as ProtoError)) as ProtoError;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoError create() => ProtoError._();
  @$core.override
  ProtoError createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProtoError getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProtoError>(create);
  static ProtoError? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get localizedDescription => $_getSZ(0);
  @$pb.TagNumber(1)
  set localizedDescription($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLocalizedDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocalizedDescription() => $_clearField(1);
}

class ProtoImage extends $pb.GeneratedMessage {
  factory ProtoImage({
    $core.int? image,
    $core.int? slot,
    $core.List<$core.int>? hash,
    $core.List<$core.int>? data,
  }) {
    final result = create();
    if (image != null) result.image = image;
    if (slot != null) result.slot = slot;
    if (hash != null) result.hash = hash;
    if (data != null) result.data = data;
    return result;
  }

  ProtoImage._();

  factory ProtoImage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProtoImage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProtoImage',
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'image')
    ..aI(2, _omitFieldNames ? '' : 'slot')
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'hash', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoImage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoImage copyWith(void Function(ProtoImage) updates) =>
      super.copyWith((message) => updates(message as ProtoImage)) as ProtoImage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoImage create() => ProtoImage._();
  @$core.override
  ProtoImage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProtoImage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProtoImage>(create);
  static ProtoImage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get image => $_getIZ(0);
  @$pb.TagNumber(1)
  set image($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasImage() => $_has(0);
  @$pb.TagNumber(1)
  void clearImage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get slot => $_getIZ(1);
  @$pb.TagNumber(2)
  set slot($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSlot() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlot() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get hash => $_getN(2);
  @$pb.TagNumber(3)
  set hash($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHash() => $_has(2);
  @$pb.TagNumber(3)
  void clearHash() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get data => $_getN(3);
  @$pb.TagNumber(4)
  set data($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasData() => $_has(3);
  @$pb.TagNumber(4)
  void clearData() => $_clearField(4);
}

class ProtoUpdateWithImageCallArguments extends $pb.GeneratedMessage {
  factory ProtoUpdateWithImageCallArguments({
    $core.String? deviceUuid,
    $core.Iterable<ProtoImage>? images,
    ProtoFirmwareUpgradeConfiguration? configuration,
  }) {
    final result = create();
    if (deviceUuid != null) result.deviceUuid = deviceUuid;
    if (images != null) result.images.addAll(images);
    if (configuration != null) result.configuration = configuration;
    return result;
  }

  ProtoUpdateWithImageCallArguments._();

  factory ProtoUpdateWithImageCallArguments.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProtoUpdateWithImageCallArguments.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProtoUpdateWithImageCallArguments',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceUuid')
    ..pPM<ProtoImage>(2, _omitFieldNames ? '' : 'images',
        subBuilder: ProtoImage.create)
    ..aOM<ProtoFirmwareUpgradeConfiguration>(
        3, _omitFieldNames ? '' : 'configuration',
        subBuilder: ProtoFirmwareUpgradeConfiguration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoUpdateWithImageCallArguments clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoUpdateWithImageCallArguments copyWith(
          void Function(ProtoUpdateWithImageCallArguments) updates) =>
      super.copyWith((message) =>
              updates(message as ProtoUpdateWithImageCallArguments))
          as ProtoUpdateWithImageCallArguments;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoUpdateWithImageCallArguments create() =>
      ProtoUpdateWithImageCallArguments._();
  @$core.override
  ProtoUpdateWithImageCallArguments createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateWithImageCallArguments getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProtoUpdateWithImageCallArguments>(
          create);
  static ProtoUpdateWithImageCallArguments? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceUuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceUuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDeviceUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<ProtoImage> get images => $_getList(1);

  @$pb.TagNumber(3)
  ProtoFirmwareUpgradeConfiguration get configuration => $_getN(2);
  @$pb.TagNumber(3)
  set configuration(ProtoFirmwareUpgradeConfiguration value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasConfiguration() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfiguration() => $_clearField(3);
  @$pb.TagNumber(3)
  ProtoFirmwareUpgradeConfiguration ensureConfiguration() => $_ensure(2);
}

/// STATE
class ProtoUpdateStateChangesStreamArg extends $pb.GeneratedMessage {
  factory ProtoUpdateStateChangesStreamArg({
    $core.String? uuid,
    $core.bool? done,
    ProtoError? error,
    ProtoUpdateStateChanges? updateStateChanges,
  }) {
    final result = create();
    if (uuid != null) result.uuid = uuid;
    if (done != null) result.done = done;
    if (error != null) result.error = error;
    if (updateStateChanges != null)
      result.updateStateChanges = updateStateChanges;
    return result;
  }

  ProtoUpdateStateChangesStreamArg._();

  factory ProtoUpdateStateChangesStreamArg.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProtoUpdateStateChangesStreamArg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProtoUpdateStateChangesStreamArg',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uuid')
    ..aOB(2, _omitFieldNames ? '' : 'done')
    ..aOM<ProtoError>(3, _omitFieldNames ? '' : 'error',
        subBuilder: ProtoError.create)
    ..aOM<ProtoUpdateStateChanges>(
        4, _omitFieldNames ? '' : 'updateStateChanges',
        protoName: 'updateStateChanges',
        subBuilder: ProtoUpdateStateChanges.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoUpdateStateChangesStreamArg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoUpdateStateChangesStreamArg copyWith(
          void Function(ProtoUpdateStateChangesStreamArg) updates) =>
      super.copyWith(
              (message) => updates(message as ProtoUpdateStateChangesStreamArg))
          as ProtoUpdateStateChangesStreamArg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoUpdateStateChangesStreamArg create() =>
      ProtoUpdateStateChangesStreamArg._();
  @$core.override
  ProtoUpdateStateChangesStreamArg createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateStateChangesStreamArg getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProtoUpdateStateChangesStreamArg>(
          create);
  static ProtoUpdateStateChangesStreamArg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get done => $_getBF(1);
  @$pb.TagNumber(2)
  set done($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDone() => $_has(1);
  @$pb.TagNumber(2)
  void clearDone() => $_clearField(2);

  @$pb.TagNumber(3)
  ProtoError get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(ProtoError value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);
  @$pb.TagNumber(3)
  ProtoError ensureError() => $_ensure(2);

  @$pb.TagNumber(4)
  ProtoUpdateStateChanges get updateStateChanges => $_getN(3);
  @$pb.TagNumber(4)
  set updateStateChanges(ProtoUpdateStateChanges value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasUpdateStateChanges() => $_has(3);
  @$pb.TagNumber(4)
  void clearUpdateStateChanges() => $_clearField(4);
  @$pb.TagNumber(4)
  ProtoUpdateStateChanges ensureUpdateStateChanges() => $_ensure(3);
}

class ProtoUpdateStateChanges extends $pb.GeneratedMessage {
  factory ProtoUpdateStateChanges({
    ProtoUpdateStateChanges_FirmwareUpgradeState? oldState,
    ProtoUpdateStateChanges_FirmwareUpgradeState? newState,
    $core.bool? canceled,
  }) {
    final result = create();
    if (oldState != null) result.oldState = oldState;
    if (newState != null) result.newState = newState;
    if (canceled != null) result.canceled = canceled;
    return result;
  }

  ProtoUpdateStateChanges._();

  factory ProtoUpdateStateChanges.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProtoUpdateStateChanges.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProtoUpdateStateChanges',
      createEmptyInstance: create)
    ..aE<ProtoUpdateStateChanges_FirmwareUpgradeState>(
        1, _omitFieldNames ? '' : 'oldState',
        protoName: 'oldState',
        enumValues: ProtoUpdateStateChanges_FirmwareUpgradeState.values)
    ..aE<ProtoUpdateStateChanges_FirmwareUpgradeState>(
        2, _omitFieldNames ? '' : 'newState',
        protoName: 'newState',
        enumValues: ProtoUpdateStateChanges_FirmwareUpgradeState.values)
    ..aOB(3, _omitFieldNames ? '' : 'canceled')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoUpdateStateChanges clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoUpdateStateChanges copyWith(
          void Function(ProtoUpdateStateChanges) updates) =>
      super.copyWith((message) => updates(message as ProtoUpdateStateChanges))
          as ProtoUpdateStateChanges;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoUpdateStateChanges create() => ProtoUpdateStateChanges._();
  @$core.override
  ProtoUpdateStateChanges createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProtoUpdateStateChanges getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProtoUpdateStateChanges>(create);
  static ProtoUpdateStateChanges? _defaultInstance;

  @$pb.TagNumber(1)
  ProtoUpdateStateChanges_FirmwareUpgradeState get oldState => $_getN(0);
  @$pb.TagNumber(1)
  set oldState(ProtoUpdateStateChanges_FirmwareUpgradeState value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOldState() => $_has(0);
  @$pb.TagNumber(1)
  void clearOldState() => $_clearField(1);

  @$pb.TagNumber(2)
  ProtoUpdateStateChanges_FirmwareUpgradeState get newState => $_getN(1);
  @$pb.TagNumber(2)
  set newState(ProtoUpdateStateChanges_FirmwareUpgradeState value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasNewState() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewState() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get canceled => $_getBF(2);
  @$pb.TagNumber(3)
  set canceled($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCanceled() => $_has(2);
  @$pb.TagNumber(3)
  void clearCanceled() => $_clearField(3);
}

class ProtoFirmwareUpgradeConfiguration extends $pb.GeneratedMessage {
  factory ProtoFirmwareUpgradeConfiguration({
    $fixnum.Int64? estimatedSwapTimeMs,
    $core.bool? eraseAppSettings,
    $fixnum.Int64? pipelineDepth,
    ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment? byteAlignment,
    $fixnum.Int64? reassemblyBufferSize,
    ProtoFirmwareUpgradeConfiguration_FirmwareUpgradeMode? firmwareUpgradeMode,
  }) {
    final result = create();
    if (estimatedSwapTimeMs != null)
      result.estimatedSwapTimeMs = estimatedSwapTimeMs;
    if (eraseAppSettings != null) result.eraseAppSettings = eraseAppSettings;
    if (pipelineDepth != null) result.pipelineDepth = pipelineDepth;
    if (byteAlignment != null) result.byteAlignment = byteAlignment;
    if (reassemblyBufferSize != null)
      result.reassemblyBufferSize = reassemblyBufferSize;
    if (firmwareUpgradeMode != null)
      result.firmwareUpgradeMode = firmwareUpgradeMode;
    return result;
  }

  ProtoFirmwareUpgradeConfiguration._();

  factory ProtoFirmwareUpgradeConfiguration.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProtoFirmwareUpgradeConfiguration.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProtoFirmwareUpgradeConfiguration',
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'estimatedSwapTimeMs',
        protoName: 'estimatedSwapTimeMs')
    ..aOB(2, _omitFieldNames ? '' : 'eraseAppSettings',
        protoName: 'eraseAppSettings')
    ..aInt64(3, _omitFieldNames ? '' : 'pipelineDepth',
        protoName: 'pipelineDepth')
    ..aE<ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment>(
        4, _omitFieldNames ? '' : 'byteAlignment',
        protoName: 'byteAlignment',
        enumValues:
            ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment.values)
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'reassemblyBufferSize', $pb.PbFieldType.OU6,
        protoName: 'reassemblyBufferSize', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aE<ProtoFirmwareUpgradeConfiguration_FirmwareUpgradeMode>(
        6, _omitFieldNames ? '' : 'firmwareUpgradeMode',
        protoName: 'firmwareUpgradeMode',
        enumValues:
            ProtoFirmwareUpgradeConfiguration_FirmwareUpgradeMode.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoFirmwareUpgradeConfiguration clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoFirmwareUpgradeConfiguration copyWith(
          void Function(ProtoFirmwareUpgradeConfiguration) updates) =>
      super.copyWith((message) =>
              updates(message as ProtoFirmwareUpgradeConfiguration))
          as ProtoFirmwareUpgradeConfiguration;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoFirmwareUpgradeConfiguration create() =>
      ProtoFirmwareUpgradeConfiguration._();
  @$core.override
  ProtoFirmwareUpgradeConfiguration createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProtoFirmwareUpgradeConfiguration getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProtoFirmwareUpgradeConfiguration>(
          create);
  static ProtoFirmwareUpgradeConfiguration? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get estimatedSwapTimeMs => $_getI64(0);
  @$pb.TagNumber(1)
  set estimatedSwapTimeMs($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEstimatedSwapTimeMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearEstimatedSwapTimeMs() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get eraseAppSettings => $_getBF(1);
  @$pb.TagNumber(2)
  set eraseAppSettings($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEraseAppSettings() => $_has(1);
  @$pb.TagNumber(2)
  void clearEraseAppSettings() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get pipelineDepth => $_getI64(2);
  @$pb.TagNumber(3)
  set pipelineDepth($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPipelineDepth() => $_has(2);
  @$pb.TagNumber(3)
  void clearPipelineDepth() => $_clearField(3);

  @$pb.TagNumber(4)
  ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment get byteAlignment =>
      $_getN(3);
  @$pb.TagNumber(4)
  set byteAlignment(
          ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasByteAlignment() => $_has(3);
  @$pb.TagNumber(4)
  void clearByteAlignment() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get reassemblyBufferSize => $_getI64(4);
  @$pb.TagNumber(5)
  set reassemblyBufferSize($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReassemblyBufferSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearReassemblyBufferSize() => $_clearField(5);

  @$pb.TagNumber(6)
  ProtoFirmwareUpgradeConfiguration_FirmwareUpgradeMode
      get firmwareUpgradeMode => $_getN(5);
  @$pb.TagNumber(6)
  set firmwareUpgradeMode(
          ProtoFirmwareUpgradeConfiguration_FirmwareUpgradeMode value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasFirmwareUpgradeMode() => $_has(5);
  @$pb.TagNumber(6)
  void clearFirmwareUpgradeMode() => $_clearField(6);
}

class ProtoProgressUpdateStreamArg extends $pb.GeneratedMessage {
  factory ProtoProgressUpdateStreamArg({
    $core.String? uuid,
    $core.bool? done,
    ProtoError? error,
    ProtoProgressUpdate? progressUpdate,
  }) {
    final result = create();
    if (uuid != null) result.uuid = uuid;
    if (done != null) result.done = done;
    if (error != null) result.error = error;
    if (progressUpdate != null) result.progressUpdate = progressUpdate;
    return result;
  }

  ProtoProgressUpdateStreamArg._();

  factory ProtoProgressUpdateStreamArg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProtoProgressUpdateStreamArg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProtoProgressUpdateStreamArg',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uuid')
    ..aOB(2, _omitFieldNames ? '' : 'done')
    ..aOM<ProtoError>(3, _omitFieldNames ? '' : 'error',
        subBuilder: ProtoError.create)
    ..aOM<ProtoProgressUpdate>(4, _omitFieldNames ? '' : 'progressUpdate',
        protoName: 'progressUpdate', subBuilder: ProtoProgressUpdate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoProgressUpdateStreamArg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoProgressUpdateStreamArg copyWith(
          void Function(ProtoProgressUpdateStreamArg) updates) =>
      super.copyWith(
              (message) => updates(message as ProtoProgressUpdateStreamArg))
          as ProtoProgressUpdateStreamArg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoProgressUpdateStreamArg create() =>
      ProtoProgressUpdateStreamArg._();
  @$core.override
  ProtoProgressUpdateStreamArg createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProtoProgressUpdateStreamArg getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProtoProgressUpdateStreamArg>(create);
  static ProtoProgressUpdateStreamArg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get done => $_getBF(1);
  @$pb.TagNumber(2)
  set done($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDone() => $_has(1);
  @$pb.TagNumber(2)
  void clearDone() => $_clearField(2);

  @$pb.TagNumber(3)
  ProtoError get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(ProtoError value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);
  @$pb.TagNumber(3)
  ProtoError ensureError() => $_ensure(2);

  @$pb.TagNumber(4)
  ProtoProgressUpdate get progressUpdate => $_getN(3);
  @$pb.TagNumber(4)
  set progressUpdate(ProtoProgressUpdate value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasProgressUpdate() => $_has(3);
  @$pb.TagNumber(4)
  void clearProgressUpdate() => $_clearField(4);
  @$pb.TagNumber(4)
  ProtoProgressUpdate ensureProgressUpdate() => $_ensure(3);
}

class ProtoProgressUpdate extends $pb.GeneratedMessage {
  factory ProtoProgressUpdate({
    $fixnum.Int64? bytesSent,
    $fixnum.Int64? imageSize,
    $core.double? timestamp,
  }) {
    final result = create();
    if (bytesSent != null) result.bytesSent = bytesSent;
    if (imageSize != null) result.imageSize = imageSize;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  ProtoProgressUpdate._();

  factory ProtoProgressUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProtoProgressUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProtoProgressUpdate',
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'bytesSent', $pb.PbFieldType.OU6,
        protoName: 'bytesSent', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'imageSize', $pb.PbFieldType.OU6,
        protoName: 'imageSize', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aD(3, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoProgressUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoProgressUpdate copyWith(void Function(ProtoProgressUpdate) updates) =>
      super.copyWith((message) => updates(message as ProtoProgressUpdate))
          as ProtoProgressUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoProgressUpdate create() => ProtoProgressUpdate._();
  @$core.override
  ProtoProgressUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProtoProgressUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProtoProgressUpdate>(create);
  static ProtoProgressUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get bytesSent => $_getI64(0);
  @$pb.TagNumber(1)
  set bytesSent($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBytesSent() => $_has(0);
  @$pb.TagNumber(1)
  void clearBytesSent() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get imageSize => $_getI64(1);
  @$pb.TagNumber(2)
  set imageSize($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasImageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearImageSize() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get timestamp => $_getN(2);
  @$pb.TagNumber(3)
  set timestamp($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => $_clearField(3);
}

/// LOGS
class ProtoLogMessageStreamArg extends $pb.GeneratedMessage {
  factory ProtoLogMessageStreamArg({
    $core.String? uuid,
    $core.bool? done,
    ProtoError? error,
    ProtoLogMessage? protoLogMessage,
  }) {
    final result = create();
    if (uuid != null) result.uuid = uuid;
    if (done != null) result.done = done;
    if (error != null) result.error = error;
    if (protoLogMessage != null) result.protoLogMessage = protoLogMessage;
    return result;
  }

  ProtoLogMessageStreamArg._();

  factory ProtoLogMessageStreamArg.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProtoLogMessageStreamArg.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProtoLogMessageStreamArg',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uuid')
    ..aOB(2, _omitFieldNames ? '' : 'done')
    ..aOM<ProtoError>(3, _omitFieldNames ? '' : 'error',
        subBuilder: ProtoError.create)
    ..aOM<ProtoLogMessage>(4, _omitFieldNames ? '' : 'protoLogMessage',
        protoName: 'protoLogMessage', subBuilder: ProtoLogMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoLogMessageStreamArg clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoLogMessageStreamArg copyWith(
          void Function(ProtoLogMessageStreamArg) updates) =>
      super.copyWith((message) => updates(message as ProtoLogMessageStreamArg))
          as ProtoLogMessageStreamArg;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoLogMessageStreamArg create() => ProtoLogMessageStreamArg._();
  @$core.override
  ProtoLogMessageStreamArg createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProtoLogMessageStreamArg getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProtoLogMessageStreamArg>(create);
  static ProtoLogMessageStreamArg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get done => $_getBF(1);
  @$pb.TagNumber(2)
  set done($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDone() => $_has(1);
  @$pb.TagNumber(2)
  void clearDone() => $_clearField(2);

  @$pb.TagNumber(3)
  ProtoError get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(ProtoError value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);
  @$pb.TagNumber(3)
  ProtoError ensureError() => $_ensure(2);

  @$pb.TagNumber(4)
  ProtoLogMessage get protoLogMessage => $_getN(3);
  @$pb.TagNumber(4)
  set protoLogMessage(ProtoLogMessage value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasProtoLogMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearProtoLogMessage() => $_clearField(4);
  @$pb.TagNumber(4)
  ProtoLogMessage ensureProtoLogMessage() => $_ensure(3);
}

class ProtoLogMessage extends $pb.GeneratedMessage {
  factory ProtoLogMessage({
    $core.String? message,
    ProtoLogMessage_LogCategory? logCategory,
    ProtoLogMessage_LogLevel? logLevel,
    $fixnum.Int64? logDateTime,
  }) {
    final result = create();
    if (message != null) result.message = message;
    if (logCategory != null) result.logCategory = logCategory;
    if (logLevel != null) result.logLevel = logLevel;
    if (logDateTime != null) result.logDateTime = logDateTime;
    return result;
  }

  ProtoLogMessage._();

  factory ProtoLogMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProtoLogMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProtoLogMessage',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..aE<ProtoLogMessage_LogCategory>(2, _omitFieldNames ? '' : 'logCategory',
        protoName: 'logCategory',
        enumValues: ProtoLogMessage_LogCategory.values)
    ..aE<ProtoLogMessage_LogLevel>(3, _omitFieldNames ? '' : 'logLevel',
        protoName: 'logLevel', enumValues: ProtoLogMessage_LogLevel.values)
    ..aInt64(4, _omitFieldNames ? '' : 'logDateTime', protoName: 'logDateTime')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoLogMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoLogMessage copyWith(void Function(ProtoLogMessage) updates) =>
      super.copyWith((message) => updates(message as ProtoLogMessage))
          as ProtoLogMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoLogMessage create() => ProtoLogMessage._();
  @$core.override
  ProtoLogMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProtoLogMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProtoLogMessage>(create);
  static ProtoLogMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);

  @$pb.TagNumber(2)
  ProtoLogMessage_LogCategory get logCategory => $_getN(1);
  @$pb.TagNumber(2)
  set logCategory(ProtoLogMessage_LogCategory value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasLogCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearLogCategory() => $_clearField(2);

  @$pb.TagNumber(3)
  ProtoLogMessage_LogLevel get logLevel => $_getN(2);
  @$pb.TagNumber(3)
  set logLevel(ProtoLogMessage_LogLevel value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasLogLevel() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogLevel() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get logDateTime => $_getI64(3);
  @$pb.TagNumber(4)
  set logDateTime($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLogDateTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogDateTime() => $_clearField(4);
}

class ProtoReadLogCallArguments extends $pb.GeneratedMessage {
  factory ProtoReadLogCallArguments({
    $core.String? uuid,
    $core.bool? clearLogs,
  }) {
    final result = create();
    if (uuid != null) result.uuid = uuid;
    if (clearLogs != null) result.clearLogs = clearLogs;
    return result;
  }

  ProtoReadLogCallArguments._();

  factory ProtoReadLogCallArguments.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProtoReadLogCallArguments.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProtoReadLogCallArguments',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uuid')
    ..aOB(2, _omitFieldNames ? '' : 'clearLogs', protoName: 'clearLogs')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoReadLogCallArguments clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoReadLogCallArguments copyWith(
          void Function(ProtoReadLogCallArguments) updates) =>
      super.copyWith((message) => updates(message as ProtoReadLogCallArguments))
          as ProtoReadLogCallArguments;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoReadLogCallArguments create() => ProtoReadLogCallArguments._();
  @$core.override
  ProtoReadLogCallArguments createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProtoReadLogCallArguments getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProtoReadLogCallArguments>(create);
  static ProtoReadLogCallArguments? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get clearLogs => $_getBF(1);
  @$pb.TagNumber(2)
  set clearLogs($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasClearLogs() => $_has(1);
  @$pb.TagNumber(2)
  void clearClearLogs() => $_clearField(2);
}

class ProtoReadMessagesResponse extends $pb.GeneratedMessage {
  factory ProtoReadMessagesResponse({
    $core.String? uuid,
    $core.Iterable<ProtoLogMessage>? protoLogMessage,
  }) {
    final result = create();
    if (uuid != null) result.uuid = uuid;
    if (protoLogMessage != null) result.protoLogMessage.addAll(protoLogMessage);
    return result;
  }

  ProtoReadMessagesResponse._();

  factory ProtoReadMessagesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProtoReadMessagesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProtoReadMessagesResponse',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uuid')
    ..pPM<ProtoLogMessage>(2, _omitFieldNames ? '' : 'protoLogMessage',
        protoName: 'protoLogMessage', subBuilder: ProtoLogMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoReadMessagesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoReadMessagesResponse copyWith(
          void Function(ProtoReadMessagesResponse) updates) =>
      super.copyWith((message) => updates(message as ProtoReadMessagesResponse))
          as ProtoReadMessagesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoReadMessagesResponse create() => ProtoReadMessagesResponse._();
  @$core.override
  ProtoReadMessagesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProtoReadMessagesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProtoReadMessagesResponse>(create);
  static ProtoReadMessagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<ProtoLogMessage> get protoLogMessage => $_getList(1);
}

/// IMAGE MANAGER
class ProtoListImagesResponse extends $pb.GeneratedMessage {
  factory ProtoListImagesResponse({
    $core.String? uuid,
    $core.bool? existing,
    $core.Iterable<ProtoImageSlot>? images,
  }) {
    final result = create();
    if (uuid != null) result.uuid = uuid;
    if (existing != null) result.existing = existing;
    if (images != null) result.images.addAll(images);
    return result;
  }

  ProtoListImagesResponse._();

  factory ProtoListImagesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProtoListImagesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProtoListImagesResponse',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uuid')
    ..aOB(2, _omitFieldNames ? '' : 'existing')
    ..pPM<ProtoImageSlot>(3, _omitFieldNames ? '' : 'images',
        subBuilder: ProtoImageSlot.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoListImagesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoListImagesResponse copyWith(
          void Function(ProtoListImagesResponse) updates) =>
      super.copyWith((message) => updates(message as ProtoListImagesResponse))
          as ProtoListImagesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoListImagesResponse create() => ProtoListImagesResponse._();
  @$core.override
  ProtoListImagesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProtoListImagesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProtoListImagesResponse>(create);
  static ProtoListImagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get existing => $_getBF(1);
  @$pb.TagNumber(2)
  set existing($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExisting() => $_has(1);
  @$pb.TagNumber(2)
  void clearExisting() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<ProtoImageSlot> get images => $_getList(2);
}

class ProtoImageSlot extends $pb.GeneratedMessage {
  factory ProtoImageSlot({
    $fixnum.Int64? image,
    $fixnum.Int64? slot,
    $core.String? version,
    $core.List<$core.int>? hash,
    $core.bool? bootable,
    $core.bool? pending,
    $core.bool? confirmed,
    $core.bool? active,
    $core.bool? permanent,
  }) {
    final result = create();
    if (image != null) result.image = image;
    if (slot != null) result.slot = slot;
    if (version != null) result.version = version;
    if (hash != null) result.hash = hash;
    if (bootable != null) result.bootable = bootable;
    if (pending != null) result.pending = pending;
    if (confirmed != null) result.confirmed = confirmed;
    if (active != null) result.active = active;
    if (permanent != null) result.permanent = permanent;
    return result;
  }

  ProtoImageSlot._();

  factory ProtoImageSlot.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProtoImageSlot.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProtoImageSlot',
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'image', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'slot', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'version')
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'hash', $pb.PbFieldType.OY)
    ..aOB(5, _omitFieldNames ? '' : 'bootable')
    ..aOB(6, _omitFieldNames ? '' : 'pending')
    ..aOB(7, _omitFieldNames ? '' : 'confirmed')
    ..aOB(8, _omitFieldNames ? '' : 'active')
    ..aOB(9, _omitFieldNames ? '' : 'permanent')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoImageSlot clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtoImageSlot copyWith(void Function(ProtoImageSlot) updates) =>
      super.copyWith((message) => updates(message as ProtoImageSlot))
          as ProtoImageSlot;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtoImageSlot create() => ProtoImageSlot._();
  @$core.override
  ProtoImageSlot createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProtoImageSlot getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProtoImageSlot>(create);
  static ProtoImageSlot? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get image => $_getI64(0);
  @$pb.TagNumber(1)
  set image($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasImage() => $_has(0);
  @$pb.TagNumber(1)
  void clearImage() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get slot => $_getI64(1);
  @$pb.TagNumber(2)
  set slot($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSlot() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlot() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get version => $_getSZ(2);
  @$pb.TagNumber(3)
  set version($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get hash => $_getN(3);
  @$pb.TagNumber(4)
  set hash($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHash() => $_has(3);
  @$pb.TagNumber(4)
  void clearHash() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get bootable => $_getBF(4);
  @$pb.TagNumber(5)
  set bootable($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBootable() => $_has(4);
  @$pb.TagNumber(5)
  void clearBootable() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get pending => $_getBF(5);
  @$pb.TagNumber(6)
  set pending($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPending() => $_has(5);
  @$pb.TagNumber(6)
  void clearPending() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get confirmed => $_getBF(6);
  @$pb.TagNumber(7)
  set confirmed($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasConfirmed() => $_has(6);
  @$pb.TagNumber(7)
  void clearConfirmed() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get active => $_getBF(7);
  @$pb.TagNumber(8)
  set active($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasActive() => $_has(7);
  @$pb.TagNumber(8)
  void clearActive() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get permanent => $_getBF(8);
  @$pb.TagNumber(9)
  set permanent($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPermanent() => $_has(8);
  @$pb.TagNumber(9)
  void clearPermanent() => $_clearField(9);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
