//
//  Generated code. Do not modify.
//  source: lib/proto/flutter_mcu.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use protoUpdateCallArgumentDescriptor instead')
const ProtoUpdateCallArgument$json = {
  '1': 'ProtoUpdateCallArgument',
  '2': [
    {'1': 'device_uuid', '3': 1, '4': 1, '5': 9, '10': 'deviceUuid'},
    {'1': 'firmware_data', '3': 2, '4': 1, '5': 12, '10': 'firmwareData'},
  ],
};

/// Descriptor for `ProtoUpdateCallArgument`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoUpdateCallArgumentDescriptor = $convert.base64Decode(
    'ChdQcm90b1VwZGF0ZUNhbGxBcmd1bWVudBIfCgtkZXZpY2VfdXVpZBgBIAEoCVIKZGV2aWNlVX'
    'VpZBIjCg1maXJtd2FyZV9kYXRhGAIgASgMUgxmaXJtd2FyZURhdGE=');

@$core.Deprecated('Use protoErrorDescriptor instead')
const ProtoError$json = {
  '1': 'ProtoError',
  '2': [
    {'1': 'localizedDescription', '3': 1, '4': 1, '5': 9, '10': 'localizedDescription'},
  ],
};

/// Descriptor for `ProtoError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoErrorDescriptor = $convert.base64Decode(
    'CgpQcm90b0Vycm9yEjIKFGxvY2FsaXplZERlc2NyaXB0aW9uGAEgASgJUhRsb2NhbGl6ZWREZX'
    'NjcmlwdGlvbg==');

@$core.Deprecated('Use pairDescriptor instead')
const Pair$json = {
  '1': 'Pair',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `Pair`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pairDescriptor = $convert.base64Decode(
    'CgRQYWlyEhAKA2tleRgBIAEoBVIDa2V5EhQKBXZhbHVlGAIgASgMUgV2YWx1ZQ==');

@$core.Deprecated('Use protoUpdateWithImageCallArgumentsDescriptor instead')
const ProtoUpdateWithImageCallArguments$json = {
  '1': 'ProtoUpdateWithImageCallArguments',
  '2': [
    {'1': 'device_uuid', '3': 1, '4': 1, '5': 9, '10': 'deviceUuid'},
    {'1': 'images', '3': 2, '4': 3, '5': 11, '6': '.Pair', '10': 'images'},
    {'1': 'configuration', '3': 3, '4': 1, '5': 11, '6': '.ProtoFirmwareUpgradeConfiguration', '10': 'configuration'},
  ],
};

/// Descriptor for `ProtoUpdateWithImageCallArguments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoUpdateWithImageCallArgumentsDescriptor = $convert.base64Decode(
    'CiFQcm90b1VwZGF0ZVdpdGhJbWFnZUNhbGxBcmd1bWVudHMSHwoLZGV2aWNlX3V1aWQYASABKA'
    'lSCmRldmljZVV1aWQSHQoGaW1hZ2VzGAIgAygLMgUuUGFpclIGaW1hZ2VzEkgKDWNvbmZpZ3Vy'
    'YXRpb24YAyABKAsyIi5Qcm90b0Zpcm13YXJlVXBncmFkZUNvbmZpZ3VyYXRpb25SDWNvbmZpZ3'
    'VyYXRpb24=');

@$core.Deprecated('Use protoUpdateWithSingleImageCallArgumentsDescriptor instead')
const ProtoUpdateWithSingleImageCallArguments$json = {
  '1': 'ProtoUpdateWithSingleImageCallArguments',
  '2': [
    {'1': 'device_uuid', '3': 1, '4': 1, '5': 9, '10': 'deviceUuid'},
    {'1': 'image', '3': 2, '4': 1, '5': 12, '10': 'image'},
    {'1': 'configuration', '3': 3, '4': 1, '5': 11, '6': '.ProtoFirmwareUpgradeConfiguration', '10': 'configuration'},
  ],
};

/// Descriptor for `ProtoUpdateWithSingleImageCallArguments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoUpdateWithSingleImageCallArgumentsDescriptor = $convert.base64Decode(
    'CidQcm90b1VwZGF0ZVdpdGhTaW5nbGVJbWFnZUNhbGxBcmd1bWVudHMSHwoLZGV2aWNlX3V1aW'
    'QYASABKAlSCmRldmljZVV1aWQSFAoFaW1hZ2UYAiABKAxSBWltYWdlEkgKDWNvbmZpZ3VyYXRp'
    'b24YAyABKAsyIi5Qcm90b0Zpcm13YXJlVXBncmFkZUNvbmZpZ3VyYXRpb25SDWNvbmZpZ3VyYX'
    'Rpb24=');

@$core.Deprecated('Use protoUpdateStateChangesStreamArgDescriptor instead')
const ProtoUpdateStateChangesStreamArg$json = {
  '1': 'ProtoUpdateStateChangesStreamArg',
  '2': [
    {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    {'1': 'done', '3': 2, '4': 1, '5': 8, '10': 'done'},
    {'1': 'error', '3': 3, '4': 1, '5': 11, '6': '.ProtoError', '10': 'error'},
    {'1': 'updateStateChanges', '3': 4, '4': 1, '5': 11, '6': '.ProtoUpdateStateChanges', '10': 'updateStateChanges'},
  ],
};

/// Descriptor for `ProtoUpdateStateChangesStreamArg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoUpdateStateChangesStreamArgDescriptor = $convert.base64Decode(
    'CiBQcm90b1VwZGF0ZVN0YXRlQ2hhbmdlc1N0cmVhbUFyZxISCgR1dWlkGAEgASgJUgR1dWlkEh'
    'IKBGRvbmUYAiABKAhSBGRvbmUSIQoFZXJyb3IYAyABKAsyCy5Qcm90b0Vycm9yUgVlcnJvchJI'
    'ChJ1cGRhdGVTdGF0ZUNoYW5nZXMYBCABKAsyGC5Qcm90b1VwZGF0ZVN0YXRlQ2hhbmdlc1ISdX'
    'BkYXRlU3RhdGVDaGFuZ2Vz');

@$core.Deprecated('Use protoUpdateStateChangesDescriptor instead')
const ProtoUpdateStateChanges$json = {
  '1': 'ProtoUpdateStateChanges',
  '2': [
    {'1': 'oldState', '3': 1, '4': 1, '5': 14, '6': '.ProtoUpdateStateChanges.FirmwareUpgradeState', '10': 'oldState'},
    {'1': 'newState', '3': 2, '4': 1, '5': 14, '6': '.ProtoUpdateStateChanges.FirmwareUpgradeState', '10': 'newState'},
    {'1': 'canceled', '3': 3, '4': 1, '5': 8, '10': 'canceled'},
  ],
  '4': [ProtoUpdateStateChanges_FirmwareUpgradeState$json],
};

@$core.Deprecated('Use protoUpdateStateChangesDescriptor instead')
const ProtoUpdateStateChanges_FirmwareUpgradeState$json = {
  '1': 'FirmwareUpgradeState',
  '2': [
    {'1': 'NONE', '2': 0},
    {'1': 'VALIDATE', '2': 1},
    {'1': 'UPLOAD', '2': 2},
    {'1': 'TEST', '2': 3},
    {'1': 'RESET', '2': 4},
    {'1': 'CONFIRM', '2': 5},
    {'1': 'SUCCESS', '2': 6},
    {'1': 'REQUEST_MCU_MGR_PARAMETERS', '2': 7},
    {'1': 'ERASE_APP_SETTINGS', '2': 8},
  ],
};

/// Descriptor for `ProtoUpdateStateChanges`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoUpdateStateChangesDescriptor = $convert.base64Decode(
    'ChdQcm90b1VwZGF0ZVN0YXRlQ2hhbmdlcxJJCghvbGRTdGF0ZRgBIAEoDjItLlByb3RvVXBkYX'
    'RlU3RhdGVDaGFuZ2VzLkZpcm13YXJlVXBncmFkZVN0YXRlUghvbGRTdGF0ZRJJCghuZXdTdGF0'
    'ZRgCIAEoDjItLlByb3RvVXBkYXRlU3RhdGVDaGFuZ2VzLkZpcm13YXJlVXBncmFkZVN0YXRlUg'
    'huZXdTdGF0ZRIaCghjYW5jZWxlZBgDIAEoCFIIY2FuY2VsZWQioQEKFEZpcm13YXJlVXBncmFk'
    'ZVN0YXRlEggKBE5PTkUQABIMCghWQUxJREFURRABEgoKBlVQTE9BRBACEggKBFRFU1QQAxIJCg'
    'VSRVNFVBAEEgsKB0NPTkZJUk0QBRILCgdTVUNDRVNTEAYSHgoaUkVRVUVTVF9NQ1VfTUdSX1BB'
    'UkFNRVRFUlMQBxIWChJFUkFTRV9BUFBfU0VUVElOR1MQCA==');

@$core.Deprecated('Use protoFirmwareUpgradeConfigurationDescriptor instead')
const ProtoFirmwareUpgradeConfiguration$json = {
  '1': 'ProtoFirmwareUpgradeConfiguration',
  '2': [
    {'1': 'estimatedSwapTimeMs', '3': 1, '4': 1, '5': 3, '10': 'estimatedSwapTimeMs'},
    {'1': 'eraseAppSettings', '3': 2, '4': 1, '5': 8, '10': 'eraseAppSettings'},
    {'1': 'pipelineDepth', '3': 3, '4': 1, '5': 3, '10': 'pipelineDepth'},
    {'1': 'byteAlignment', '3': 4, '4': 1, '5': 14, '6': '.ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment', '10': 'byteAlignment'},
    {'1': 'reassemblyBufferSize', '3': 5, '4': 1, '5': 4, '10': 'reassemblyBufferSize'},
  ],
  '4': [ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment$json],
};

@$core.Deprecated('Use protoFirmwareUpgradeConfigurationDescriptor instead')
const ProtoFirmwareUpgradeConfiguration_ImageUploadAlignment$json = {
  '1': 'ImageUploadAlignment',
  '2': [
    {'1': 'DISABLED', '2': 0},
    {'1': 'TWO_BYTE', '2': 1},
    {'1': 'FOUR_BYTE', '2': 2},
    {'1': 'EIGHT_BYTE', '2': 3},
    {'1': 'SIXTEEN_BYTE', '2': 4},
  ],
};

/// Descriptor for `ProtoFirmwareUpgradeConfiguration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoFirmwareUpgradeConfigurationDescriptor = $convert.base64Decode(
    'CiFQcm90b0Zpcm13YXJlVXBncmFkZUNvbmZpZ3VyYXRpb24SMAoTZXN0aW1hdGVkU3dhcFRpbW'
    'VNcxgBIAEoA1ITZXN0aW1hdGVkU3dhcFRpbWVNcxIqChBlcmFzZUFwcFNldHRpbmdzGAIgASgI'
    'UhBlcmFzZUFwcFNldHRpbmdzEiQKDXBpcGVsaW5lRGVwdGgYAyABKANSDXBpcGVsaW5lRGVwdG'
    'gSXQoNYnl0ZUFsaWdubWVudBgEIAEoDjI3LlByb3RvRmlybXdhcmVVcGdyYWRlQ29uZmlndXJh'
    'dGlvbi5JbWFnZVVwbG9hZEFsaWdubWVudFINYnl0ZUFsaWdubWVudBIyChRyZWFzc2VtYmx5Qn'
    'VmZmVyU2l6ZRgFIAEoBFIUcmVhc3NlbWJseUJ1ZmZlclNpemUiYwoUSW1hZ2VVcGxvYWRBbGln'
    'bm1lbnQSDAoIRElTQUJMRUQQABIMCghUV09fQllURRABEg0KCUZPVVJfQllURRACEg4KCkVJR0'
    'hUX0JZVEUQAxIQCgxTSVhURUVOX0JZVEUQBA==');

@$core.Deprecated('Use protoProgressUpdateStreamArgDescriptor instead')
const ProtoProgressUpdateStreamArg$json = {
  '1': 'ProtoProgressUpdateStreamArg',
  '2': [
    {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    {'1': 'done', '3': 2, '4': 1, '5': 8, '10': 'done'},
    {'1': 'error', '3': 3, '4': 1, '5': 11, '6': '.ProtoError', '10': 'error'},
    {'1': 'progressUpdate', '3': 4, '4': 1, '5': 11, '6': '.ProtoProgressUpdate', '10': 'progressUpdate'},
  ],
};

/// Descriptor for `ProtoProgressUpdateStreamArg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoProgressUpdateStreamArgDescriptor = $convert.base64Decode(
    'ChxQcm90b1Byb2dyZXNzVXBkYXRlU3RyZWFtQXJnEhIKBHV1aWQYASABKAlSBHV1aWQSEgoEZG'
    '9uZRgCIAEoCFIEZG9uZRIhCgVlcnJvchgDIAEoCzILLlByb3RvRXJyb3JSBWVycm9yEjwKDnBy'
    'b2dyZXNzVXBkYXRlGAQgASgLMhQuUHJvdG9Qcm9ncmVzc1VwZGF0ZVIOcHJvZ3Jlc3NVcGRhdG'
    'U=');

@$core.Deprecated('Use protoProgressUpdateDescriptor instead')
const ProtoProgressUpdate$json = {
  '1': 'ProtoProgressUpdate',
  '2': [
    {'1': 'bytesSent', '3': 1, '4': 1, '5': 4, '10': 'bytesSent'},
    {'1': 'imageSize', '3': 2, '4': 1, '5': 4, '10': 'imageSize'},
    {'1': 'timestamp', '3': 3, '4': 1, '5': 1, '10': 'timestamp'},
  ],
};

/// Descriptor for `ProtoProgressUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoProgressUpdateDescriptor = $convert.base64Decode(
    'ChNQcm90b1Byb2dyZXNzVXBkYXRlEhwKCWJ5dGVzU2VudBgBIAEoBFIJYnl0ZXNTZW50EhwKCW'
    'ltYWdlU2l6ZRgCIAEoBFIJaW1hZ2VTaXplEhwKCXRpbWVzdGFtcBgDIAEoAVIJdGltZXN0YW1w');

@$core.Deprecated('Use protoLogMessageStreamArgDescriptor instead')
const ProtoLogMessageStreamArg$json = {
  '1': 'ProtoLogMessageStreamArg',
  '2': [
    {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    {'1': 'done', '3': 2, '4': 1, '5': 8, '10': 'done'},
    {'1': 'error', '3': 3, '4': 1, '5': 11, '6': '.ProtoError', '10': 'error'},
    {'1': 'protoLogMessage', '3': 4, '4': 3, '5': 11, '6': '.ProtoLogMessage', '10': 'protoLogMessage'},
  ],
};

/// Descriptor for `ProtoLogMessageStreamArg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoLogMessageStreamArgDescriptor = $convert.base64Decode(
    'ChhQcm90b0xvZ01lc3NhZ2VTdHJlYW1BcmcSEgoEdXVpZBgBIAEoCVIEdXVpZBISCgRkb25lGA'
    'IgASgIUgRkb25lEiEKBWVycm9yGAMgASgLMgsuUHJvdG9FcnJvclIFZXJyb3ISOgoPcHJvdG9M'
    'b2dNZXNzYWdlGAQgAygLMhAuUHJvdG9Mb2dNZXNzYWdlUg9wcm90b0xvZ01lc3NhZ2U=');

@$core.Deprecated('Use protoLogMessageDescriptor instead')
const ProtoLogMessage$json = {
  '1': 'ProtoLogMessage',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'logCategory', '3': 2, '4': 1, '5': 14, '6': '.ProtoLogMessage.LogCategory', '10': 'logCategory'},
    {'1': 'logLevel', '3': 3, '4': 1, '5': 14, '6': '.ProtoLogMessage.LogLevel', '10': 'logLevel'},
    {'1': 'logDateTime', '3': 4, '4': 1, '5': 3, '10': 'logDateTime'},
  ],
  '4': [ProtoLogMessage_LogCategory$json, ProtoLogMessage_LogLevel$json],
};

@$core.Deprecated('Use protoLogMessageDescriptor instead')
const ProtoLogMessage_LogCategory$json = {
  '1': 'LogCategory',
  '2': [
    {'1': 'TRANSPORT', '2': 0},
    {'1': 'CONFIG', '2': 1},
    {'1': 'CRASH', '2': 2},
    {'1': 'DEFAULT', '2': 3},
    {'1': 'FS', '2': 4},
    {'1': 'IMAGE', '2': 5},
    {'1': 'LOG', '2': 6},
    {'1': 'RUN_TEST', '2': 7},
    {'1': 'STATS', '2': 8},
    {'1': 'DFU', '2': 9},
  ],
};

@$core.Deprecated('Use protoLogMessageDescriptor instead')
const ProtoLogMessage_LogLevel$json = {
  '1': 'LogLevel',
  '2': [
    {'1': 'DEBUG', '2': 0},
    {'1': 'VERBOSE', '2': 1},
    {'1': 'INFO', '2': 2},
    {'1': 'APPLICATION', '2': 3},
    {'1': 'WARNING', '2': 4},
    {'1': 'ERROR', '2': 5},
  ],
};

/// Descriptor for `ProtoLogMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoLogMessageDescriptor = $convert.base64Decode(
    'Cg9Qcm90b0xvZ01lc3NhZ2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZRI+Cgtsb2dDYXRlZ2'
    '9yeRgCIAEoDjIcLlByb3RvTG9nTWVzc2FnZS5Mb2dDYXRlZ29yeVILbG9nQ2F0ZWdvcnkSNQoI'
    'bG9nTGV2ZWwYAyABKA4yGS5Qcm90b0xvZ01lc3NhZ2UuTG9nTGV2ZWxSCGxvZ0xldmVsEiAKC2'
    'xvZ0RhdGVUaW1lGAQgASgDUgtsb2dEYXRlVGltZSJ+CgtMb2dDYXRlZ29yeRINCglUUkFOU1BP'
    'UlQQABIKCgZDT05GSUcQARIJCgVDUkFTSBACEgsKB0RFRkFVTFQQAxIGCgJGUxAEEgkKBUlNQU'
    'dFEAUSBwoDTE9HEAYSDAoIUlVOX1RFU1QQBxIJCgVTVEFUUxAIEgcKA0RGVRAJIlUKCExvZ0xl'
    'dmVsEgkKBURFQlVHEAASCwoHVkVSQk9TRRABEggKBElORk8QAhIPCgtBUFBMSUNBVElPThADEg'
    'sKB1dBUk5JTkcQBBIJCgVFUlJPUhAF');

@$core.Deprecated('Use protoMessageLiveLogEnabledDescriptor instead')
const ProtoMessageLiveLogEnabled$json = {
  '1': 'ProtoMessageLiveLogEnabled',
  '2': [
    {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    {'1': 'enabled', '3': 2, '4': 1, '5': 8, '10': 'enabled'},
  ],
};

/// Descriptor for `ProtoMessageLiveLogEnabled`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoMessageLiveLogEnabledDescriptor = $convert.base64Decode(
    'ChpQcm90b01lc3NhZ2VMaXZlTG9nRW5hYmxlZBISCgR1dWlkGAEgASgJUgR1dWlkEhgKB2VuYW'
    'JsZWQYAiABKAhSB2VuYWJsZWQ=');

