//
//  Generated code. Do not modify.
//  source: lib/proto/flutter_mcu.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ProtoUpdateStateChanges_FirmwareUpgradeState extends $pb.ProtobufEnum {
  static const ProtoUpdateStateChanges_FirmwareUpgradeState NONE = ProtoUpdateStateChanges_FirmwareUpgradeState._(0, _omitEnumNames ? '' : 'NONE');
  static const ProtoUpdateStateChanges_FirmwareUpgradeState VALIDATE = ProtoUpdateStateChanges_FirmwareUpgradeState._(1, _omitEnumNames ? '' : 'VALIDATE');
  static const ProtoUpdateStateChanges_FirmwareUpgradeState UPLOAD = ProtoUpdateStateChanges_FirmwareUpgradeState._(2, _omitEnumNames ? '' : 'UPLOAD');
  static const ProtoUpdateStateChanges_FirmwareUpgradeState TEST = ProtoUpdateStateChanges_FirmwareUpgradeState._(3, _omitEnumNames ? '' : 'TEST');
  static const ProtoUpdateStateChanges_FirmwareUpgradeState RESET = ProtoUpdateStateChanges_FirmwareUpgradeState._(4, _omitEnumNames ? '' : 'RESET');
  static const ProtoUpdateStateChanges_FirmwareUpgradeState CONFIRM = ProtoUpdateStateChanges_FirmwareUpgradeState._(5, _omitEnumNames ? '' : 'CONFIRM');
  static const ProtoUpdateStateChanges_FirmwareUpgradeState SUCCESS = ProtoUpdateStateChanges_FirmwareUpgradeState._(6, _omitEnumNames ? '' : 'SUCCESS');
  static const ProtoUpdateStateChanges_FirmwareUpgradeState REQUEST_MCU_MGR_PARAMETERS = ProtoUpdateStateChanges_FirmwareUpgradeState._(7, _omitEnumNames ? '' : 'REQUEST_MCU_MGR_PARAMETERS');
  static const ProtoUpdateStateChanges_FirmwareUpgradeState ERASE_APP_SETTINGS = ProtoUpdateStateChanges_FirmwareUpgradeState._(8, _omitEnumNames ? '' : 'ERASE_APP_SETTINGS');

  static const $core.List<ProtoUpdateStateChanges_FirmwareUpgradeState> values = <ProtoUpdateStateChanges_FirmwareUpgradeState> [
    NONE,
    VALIDATE,
    UPLOAD,
    TEST,
    RESET,
    CONFIRM,
    SUCCESS,
    REQUEST_MCU_MGR_PARAMETERS,
    ERASE_APP_SETTINGS,
  ];

  static final $core.Map<$core.int, ProtoUpdateStateChanges_FirmwareUpgradeState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProtoUpdateStateChanges_FirmwareUpgradeState? valueOf($core.int value) => _byValue[value];

  const ProtoUpdateStateChanges_FirmwareUpgradeState._($core.int v, $core.String n) : super(v, n);
}

class ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment extends $pb.ProtobufEnum {
  static const ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment DISABLED = ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment._(0, _omitEnumNames ? '' : 'DISABLED');
  static const ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment TWO_BYTE = ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment._(1, _omitEnumNames ? '' : 'TWO_BYTE');
  static const ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment FOUR_BYTE = ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment._(2, _omitEnumNames ? '' : 'FOUR_BYTE');
  static const ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment EIGHT_BYTE = ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment._(3, _omitEnumNames ? '' : 'EIGHT_BYTE');
  static const ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment SIXTEEN_BYTE = ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment._(4, _omitEnumNames ? '' : 'SIXTEEN_BYTE');

  static const $core.List<ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment> values = <ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment> [
    DISABLED,
    TWO_BYTE,
    FOUR_BYTE,
    EIGHT_BYTE,
    SIXTEEN_BYTE,
  ];

  static final $core.Map<$core.int, ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment? valueOf($core.int value) => _byValue[value];

  const ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment._($core.int v, $core.String n) : super(v, n);
}

class ProtoLogMessage_LogCategory extends $pb.ProtobufEnum {
  static const ProtoLogMessage_LogCategory TRANSPORT = ProtoLogMessage_LogCategory._(0, _omitEnumNames ? '' : 'TRANSPORT');
  static const ProtoLogMessage_LogCategory CONFIG = ProtoLogMessage_LogCategory._(1, _omitEnumNames ? '' : 'CONFIG');
  static const ProtoLogMessage_LogCategory CRASH = ProtoLogMessage_LogCategory._(2, _omitEnumNames ? '' : 'CRASH');
  static const ProtoLogMessage_LogCategory DEFAULT = ProtoLogMessage_LogCategory._(3, _omitEnumNames ? '' : 'DEFAULT');
  static const ProtoLogMessage_LogCategory FS = ProtoLogMessage_LogCategory._(4, _omitEnumNames ? '' : 'FS');
  static const ProtoLogMessage_LogCategory IMAGE = ProtoLogMessage_LogCategory._(5, _omitEnumNames ? '' : 'IMAGE');
  static const ProtoLogMessage_LogCategory LOG = ProtoLogMessage_LogCategory._(6, _omitEnumNames ? '' : 'LOG');
  static const ProtoLogMessage_LogCategory RUN_TEST = ProtoLogMessage_LogCategory._(7, _omitEnumNames ? '' : 'RUN_TEST');
  static const ProtoLogMessage_LogCategory STATS = ProtoLogMessage_LogCategory._(8, _omitEnumNames ? '' : 'STATS');
  static const ProtoLogMessage_LogCategory DFU = ProtoLogMessage_LogCategory._(9, _omitEnumNames ? '' : 'DFU');

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
  static const ProtoLogMessage_LogLevel DEBUG = ProtoLogMessage_LogLevel._(0, _omitEnumNames ? '' : 'DEBUG');
  static const ProtoLogMessage_LogLevel VERBOSE = ProtoLogMessage_LogLevel._(1, _omitEnumNames ? '' : 'VERBOSE');
  static const ProtoLogMessage_LogLevel INFO = ProtoLogMessage_LogLevel._(2, _omitEnumNames ? '' : 'INFO');
  static const ProtoLogMessage_LogLevel APPLICATION = ProtoLogMessage_LogLevel._(3, _omitEnumNames ? '' : 'APPLICATION');
  static const ProtoLogMessage_LogLevel WARNING = ProtoLogMessage_LogLevel._(4, _omitEnumNames ? '' : 'WARNING');
  static const ProtoLogMessage_LogLevel ERROR = ProtoLogMessage_LogLevel._(5, _omitEnumNames ? '' : 'ERROR');

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


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
