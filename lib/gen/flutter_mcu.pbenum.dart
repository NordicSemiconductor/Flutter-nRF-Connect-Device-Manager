///
//  Generated code. Do not modify.
//  source: flutter_mcu.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class UpdateStateChanges_FirmwareUpgradeState extends $pb.ProtobufEnum {
  static const UpdateStateChanges_FirmwareUpgradeState NONE = UpdateStateChanges_FirmwareUpgradeState._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NONE');
  static const UpdateStateChanges_FirmwareUpgradeState VALIDATE = UpdateStateChanges_FirmwareUpgradeState._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VALIDATE');
  static const UpdateStateChanges_FirmwareUpgradeState UPLOAD = UpdateStateChanges_FirmwareUpgradeState._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UPLOAD');
  static const UpdateStateChanges_FirmwareUpgradeState TEST = UpdateStateChanges_FirmwareUpgradeState._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TEST');
  static const UpdateStateChanges_FirmwareUpgradeState RESET = UpdateStateChanges_FirmwareUpgradeState._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RESET');
  static const UpdateStateChanges_FirmwareUpgradeState CONFIRM = UpdateStateChanges_FirmwareUpgradeState._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CONFIRM');
  static const UpdateStateChanges_FirmwareUpgradeState SUCCESS = UpdateStateChanges_FirmwareUpgradeState._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SUCCESS');

  static const $core.List<UpdateStateChanges_FirmwareUpgradeState> values = <UpdateStateChanges_FirmwareUpgradeState> [
    NONE,
    VALIDATE,
    UPLOAD,
    TEST,
    RESET,
    CONFIRM,
    SUCCESS,
  ];

  static final $core.Map<$core.int, UpdateStateChanges_FirmwareUpgradeState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static UpdateStateChanges_FirmwareUpgradeState valueOf($core.int value) => _byValue[value];

  const UpdateStateChanges_FirmwareUpgradeState._($core.int v, $core.String n) : super(v, n);
}

