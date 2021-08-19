///
//  Generated code. Do not modify.
//  source: lib/proto/flutter_mcu.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ProtoUpdateStateChanges_FirmwareUpgradeState extends $pb.ProtobufEnum {
  static const ProtoUpdateStateChanges_FirmwareUpgradeState NONE = ProtoUpdateStateChanges_FirmwareUpgradeState._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NONE');
  static const ProtoUpdateStateChanges_FirmwareUpgradeState VALIDATE = ProtoUpdateStateChanges_FirmwareUpgradeState._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VALIDATE');
  static const ProtoUpdateStateChanges_FirmwareUpgradeState UPLOAD = ProtoUpdateStateChanges_FirmwareUpgradeState._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UPLOAD');
  static const ProtoUpdateStateChanges_FirmwareUpgradeState TEST = ProtoUpdateStateChanges_FirmwareUpgradeState._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TEST');
  static const ProtoUpdateStateChanges_FirmwareUpgradeState RESET = ProtoUpdateStateChanges_FirmwareUpgradeState._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RESET');
  static const ProtoUpdateStateChanges_FirmwareUpgradeState CONFIRM = ProtoUpdateStateChanges_FirmwareUpgradeState._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CONFIRM');
  static const ProtoUpdateStateChanges_FirmwareUpgradeState SUCCESS = ProtoUpdateStateChanges_FirmwareUpgradeState._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SUCCESS');

  static const $core.List<ProtoUpdateStateChanges_FirmwareUpgradeState> values = <ProtoUpdateStateChanges_FirmwareUpgradeState> [
    NONE,
    VALIDATE,
    UPLOAD,
    TEST,
    RESET,
    CONFIRM,
    SUCCESS,
  ];

  static final $core.Map<$core.int, ProtoUpdateStateChanges_FirmwareUpgradeState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProtoUpdateStateChanges_FirmwareUpgradeState? valueOf($core.int value) => _byValue[value];

  const ProtoUpdateStateChanges_FirmwareUpgradeState._($core.int v, $core.String n) : super(v, n);
}

class ProtoLogMessage_LogCategory extends $pb.ProtobufEnum {
  static const ProtoLogMessage_LogCategory TRANSPORT = ProtoLogMessage_LogCategory._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRANSPORT');
  static const ProtoLogMessage_LogCategory CONFIG = ProtoLogMessage_LogCategory._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CONFIG');
  static const ProtoLogMessage_LogCategory CRASH = ProtoLogMessage_LogCategory._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRASH');
  static const ProtoLogMessage_LogCategory DEFAULT = ProtoLogMessage_LogCategory._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DEFAULT');
  static const ProtoLogMessage_LogCategory FS = ProtoLogMessage_LogCategory._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FS');
  static const ProtoLogMessage_LogCategory IMAGE = ProtoLogMessage_LogCategory._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'IMAGE');
  static const ProtoLogMessage_LogCategory LOG = ProtoLogMessage_LogCategory._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LOG');
  static const ProtoLogMessage_LogCategory RUN_TEST = ProtoLogMessage_LogCategory._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RUN_TEST');
  static const ProtoLogMessage_LogCategory STATS = ProtoLogMessage_LogCategory._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STATS');
  static const ProtoLogMessage_LogCategory DFU = ProtoLogMessage_LogCategory._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DFU');

  static const $core.List<ProtoLogMessage_LogCategory> values = <ProtoLogMessage_LogCategory> [
    TRANSPORT,
    CONFIG,
    CRASH,
    DEFAULT,
    FS,
    IMAGE,
    LOG,
    RUN_TEST,
    STATS,
    DFU,
  ];

  static final $core.Map<$core.int, ProtoLogMessage_LogCategory> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProtoLogMessage_LogCategory? valueOf($core.int value) => _byValue[value];

  const ProtoLogMessage_LogCategory._($core.int v, $core.String n) : super(v, n);
}

class ProtoLogMessage_LogLevel extends $pb.ProtobufEnum {
  static const ProtoLogMessage_LogLevel DEBUG = ProtoLogMessage_LogLevel._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DEBUG');
  static const ProtoLogMessage_LogLevel VERBOSE = ProtoLogMessage_LogLevel._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VERBOSE');
  static const ProtoLogMessage_LogLevel INFO = ProtoLogMessage_LogLevel._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INFO');
  static const ProtoLogMessage_LogLevel APPLICATION = ProtoLogMessage_LogLevel._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'APPLICATION');
  static const ProtoLogMessage_LogLevel WARNING = ProtoLogMessage_LogLevel._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WARNING');
  static const ProtoLogMessage_LogLevel ERROR = ProtoLogMessage_LogLevel._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ERROR');

  static const $core.List<ProtoLogMessage_LogLevel> values = <ProtoLogMessage_LogLevel> [
    DEBUG,
    VERBOSE,
    INFO,
    APPLICATION,
    WARNING,
    ERROR,
  ];

  static final $core.Map<$core.int, ProtoLogMessage_LogLevel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProtoLogMessage_LogLevel? valueOf($core.int value) => _byValue[value];

  const ProtoLogMessage_LogLevel._($core.int v, $core.String n) : super(v, n);
}

