///
//  Generated code. Do not modify.
//  source: lib/proto/flutter_mcu.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use protoUpdateCallArgumentDescriptor instead')
const ProtoUpdateCallArgument$json = const {
  '1': 'ProtoUpdateCallArgument',
  '2': const [
    const {'1': 'device_uuid', '3': 1, '4': 1, '5': 9, '10': 'deviceUuid'},
    const {'1': 'firmware_data', '3': 2, '4': 1, '5': 12, '10': 'firmwareData'},
  ],
};

/// Descriptor for `ProtoUpdateCallArgument`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoUpdateCallArgumentDescriptor = $convert.base64Decode('ChdQcm90b1VwZGF0ZUNhbGxBcmd1bWVudBIfCgtkZXZpY2VfdXVpZBgBIAEoCVIKZGV2aWNlVXVpZBIjCg1maXJtd2FyZV9kYXRhGAIgASgMUgxmaXJtd2FyZURhdGE=');
@$core.Deprecated('Use protoErrorDescriptor instead')
const ProtoError$json = const {
  '1': 'ProtoError',
  '2': const [
    const {'1': 'localizedDescription', '3': 1, '4': 1, '5': 9, '10': 'localizedDescription'},
  ],
};

/// Descriptor for `ProtoError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoErrorDescriptor = $convert.base64Decode('CgpQcm90b0Vycm9yEjIKFGxvY2FsaXplZERlc2NyaXB0aW9uGAEgASgJUhRsb2NhbGl6ZWREZXNjcmlwdGlvbg==');
@$core.Deprecated('Use pairDescriptor instead')
const Pair$json = const {
  '1': 'Pair',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `Pair`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pairDescriptor = $convert.base64Decode('CgRQYWlyEhAKA2tleRgBIAEoBVIDa2V5EhQKBXZhbHVlGAIgASgMUgV2YWx1ZQ==');
@$core.Deprecated('Use protoUpdateWithImageCallArgumentsDescriptor instead')
const ProtoUpdateWithImageCallArguments$json = const {
  '1': 'ProtoUpdateWithImageCallArguments',
  '2': const [
    const {'1': 'device_uuid', '3': 1, '4': 1, '5': 9, '10': 'deviceUuid'},
    const {'1': 'images', '3': 2, '4': 3, '5': 11, '6': '.no.nordicsemi.android.mcumgr_flutter.gen.Pair', '10': 'images'},
  ],
};

/// Descriptor for `ProtoUpdateWithImageCallArguments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoUpdateWithImageCallArgumentsDescriptor = $convert.base64Decode('CiFQcm90b1VwZGF0ZVdpdGhJbWFnZUNhbGxBcmd1bWVudHMSHwoLZGV2aWNlX3V1aWQYASABKAlSCmRldmljZVV1aWQSRgoGaW1hZ2VzGAIgAygLMi4ubm8ubm9yZGljc2VtaS5hbmRyb2lkLm1jdW1ncl9mbHV0dGVyLmdlbi5QYWlyUgZpbWFnZXM=');
@$core.Deprecated('Use protoUpdateStateChangesStreamArgDescriptor instead')
const ProtoUpdateStateChangesStreamArg$json = const {
  '1': 'ProtoUpdateStateChangesStreamArg',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'done', '3': 2, '4': 1, '5': 8, '10': 'done'},
    const {'1': 'error', '3': 3, '4': 1, '5': 11, '6': '.no.nordicsemi.android.mcumgr_flutter.gen.ProtoError', '10': 'error'},
    const {'1': 'updateStateChanges', '3': 4, '4': 1, '5': 11, '6': '.no.nordicsemi.android.mcumgr_flutter.gen.ProtoUpdateStateChanges', '10': 'updateStateChanges'},
  ],
};

/// Descriptor for `ProtoUpdateStateChangesStreamArg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoUpdateStateChangesStreamArgDescriptor = $convert.base64Decode('CiBQcm90b1VwZGF0ZVN0YXRlQ2hhbmdlc1N0cmVhbUFyZxISCgR1dWlkGAEgASgJUgR1dWlkEhIKBGRvbmUYAiABKAhSBGRvbmUSSgoFZXJyb3IYAyABKAsyNC5uby5ub3JkaWNzZW1pLmFuZHJvaWQubWN1bWdyX2ZsdXR0ZXIuZ2VuLlByb3RvRXJyb3JSBWVycm9yEnEKEnVwZGF0ZVN0YXRlQ2hhbmdlcxgEIAEoCzJBLm5vLm5vcmRpY3NlbWkuYW5kcm9pZC5tY3VtZ3JfZmx1dHRlci5nZW4uUHJvdG9VcGRhdGVTdGF0ZUNoYW5nZXNSEnVwZGF0ZVN0YXRlQ2hhbmdlcw==');
@$core.Deprecated('Use protoUpdateStateChangesDescriptor instead')
const ProtoUpdateStateChanges$json = const {
  '1': 'ProtoUpdateStateChanges',
  '2': const [
    const {'1': 'oldState', '3': 1, '4': 1, '5': 14, '6': '.no.nordicsemi.android.mcumgr_flutter.gen.ProtoUpdateStateChanges.FirmwareUpgradeState', '10': 'oldState'},
    const {'1': 'newState', '3': 2, '4': 1, '5': 14, '6': '.no.nordicsemi.android.mcumgr_flutter.gen.ProtoUpdateStateChanges.FirmwareUpgradeState', '10': 'newState'},
    const {'1': 'canceled', '3': 3, '4': 1, '5': 8, '10': 'canceled'},
  ],
  '4': const [ProtoUpdateStateChanges_FirmwareUpgradeState$json],
};

@$core.Deprecated('Use protoUpdateStateChangesDescriptor instead')
const ProtoUpdateStateChanges_FirmwareUpgradeState$json = const {
  '1': 'FirmwareUpgradeState',
  '2': const [
    const {'1': 'NONE', '2': 0},
    const {'1': 'VALIDATE', '2': 1},
    const {'1': 'UPLOAD', '2': 2},
    const {'1': 'TEST', '2': 3},
    const {'1': 'RESET', '2': 4},
    const {'1': 'CONFIRM', '2': 5},
    const {'1': 'SUCCESS', '2': 6},
  ],
};

/// Descriptor for `ProtoUpdateStateChanges`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoUpdateStateChangesDescriptor = $convert.base64Decode('ChdQcm90b1VwZGF0ZVN0YXRlQ2hhbmdlcxJyCghvbGRTdGF0ZRgBIAEoDjJWLm5vLm5vcmRpY3NlbWkuYW5kcm9pZC5tY3VtZ3JfZmx1dHRlci5nZW4uUHJvdG9VcGRhdGVTdGF0ZUNoYW5nZXMuRmlybXdhcmVVcGdyYWRlU3RhdGVSCG9sZFN0YXRlEnIKCG5ld1N0YXRlGAIgASgOMlYubm8ubm9yZGljc2VtaS5hbmRyb2lkLm1jdW1ncl9mbHV0dGVyLmdlbi5Qcm90b1VwZGF0ZVN0YXRlQ2hhbmdlcy5GaXJtd2FyZVVwZ3JhZGVTdGF0ZVIIbmV3U3RhdGUSGgoIY2FuY2VsZWQYAyABKAhSCGNhbmNlbGVkImkKFEZpcm13YXJlVXBncmFkZVN0YXRlEggKBE5PTkUQABIMCghWQUxJREFURRABEgoKBlVQTE9BRBACEggKBFRFU1QQAxIJCgVSRVNFVBAEEgsKB0NPTkZJUk0QBRILCgdTVUNDRVNTEAY=');
@$core.Deprecated('Use protoProgressUpdateStreamArgDescriptor instead')
const ProtoProgressUpdateStreamArg$json = const {
  '1': 'ProtoProgressUpdateStreamArg',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'done', '3': 2, '4': 1, '5': 8, '10': 'done'},
    const {'1': 'error', '3': 3, '4': 1, '5': 11, '6': '.no.nordicsemi.android.mcumgr_flutter.gen.ProtoError', '10': 'error'},
    const {'1': 'progressUpdate', '3': 4, '4': 1, '5': 11, '6': '.no.nordicsemi.android.mcumgr_flutter.gen.ProtoProgressUpdate', '10': 'progressUpdate'},
  ],
};

/// Descriptor for `ProtoProgressUpdateStreamArg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoProgressUpdateStreamArgDescriptor = $convert.base64Decode('ChxQcm90b1Byb2dyZXNzVXBkYXRlU3RyZWFtQXJnEhIKBHV1aWQYASABKAlSBHV1aWQSEgoEZG9uZRgCIAEoCFIEZG9uZRJKCgVlcnJvchgDIAEoCzI0Lm5vLm5vcmRpY3NlbWkuYW5kcm9pZC5tY3VtZ3JfZmx1dHRlci5nZW4uUHJvdG9FcnJvclIFZXJyb3ISZQoOcHJvZ3Jlc3NVcGRhdGUYBCABKAsyPS5uby5ub3JkaWNzZW1pLmFuZHJvaWQubWN1bWdyX2ZsdXR0ZXIuZ2VuLlByb3RvUHJvZ3Jlc3NVcGRhdGVSDnByb2dyZXNzVXBkYXRl');
@$core.Deprecated('Use protoProgressUpdateDescriptor instead')
const ProtoProgressUpdate$json = const {
  '1': 'ProtoProgressUpdate',
  '2': const [
    const {'1': 'bytesSent', '3': 1, '4': 1, '5': 4, '10': 'bytesSent'},
    const {'1': 'imageSize', '3': 2, '4': 1, '5': 4, '10': 'imageSize'},
    const {'1': 'timestamp', '3': 3, '4': 1, '5': 1, '10': 'timestamp'},
  ],
};

/// Descriptor for `ProtoProgressUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoProgressUpdateDescriptor = $convert.base64Decode('ChNQcm90b1Byb2dyZXNzVXBkYXRlEhwKCWJ5dGVzU2VudBgBIAEoBFIJYnl0ZXNTZW50EhwKCWltYWdlU2l6ZRgCIAEoBFIJaW1hZ2VTaXplEhwKCXRpbWVzdGFtcBgDIAEoAVIJdGltZXN0YW1w');
@$core.Deprecated('Use protoLogMessageStreamArgDescriptor instead')
const ProtoLogMessageStreamArg$json = const {
  '1': 'ProtoLogMessageStreamArg',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'done', '3': 2, '4': 1, '5': 8, '10': 'done'},
    const {'1': 'error', '3': 3, '4': 1, '5': 11, '6': '.no.nordicsemi.android.mcumgr_flutter.gen.ProtoError', '10': 'error'},
    const {'1': 'protoLogMessage', '3': 4, '4': 3, '5': 11, '6': '.no.nordicsemi.android.mcumgr_flutter.gen.ProtoLogMessage', '10': 'protoLogMessage'},
  ],
};

/// Descriptor for `ProtoLogMessageStreamArg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoLogMessageStreamArgDescriptor = $convert.base64Decode('ChhQcm90b0xvZ01lc3NhZ2VTdHJlYW1BcmcSEgoEdXVpZBgBIAEoCVIEdXVpZBISCgRkb25lGAIgASgIUgRkb25lEkoKBWVycm9yGAMgASgLMjQubm8ubm9yZGljc2VtaS5hbmRyb2lkLm1jdW1ncl9mbHV0dGVyLmdlbi5Qcm90b0Vycm9yUgVlcnJvchJjCg9wcm90b0xvZ01lc3NhZ2UYBCADKAsyOS5uby5ub3JkaWNzZW1pLmFuZHJvaWQubWN1bWdyX2ZsdXR0ZXIuZ2VuLlByb3RvTG9nTWVzc2FnZVIPcHJvdG9Mb2dNZXNzYWdl');
@$core.Deprecated('Use protoLogMessageDescriptor instead')
const ProtoLogMessage$json = const {
  '1': 'ProtoLogMessage',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'logCategory', '3': 2, '4': 1, '5': 14, '6': '.no.nordicsemi.android.mcumgr_flutter.gen.ProtoLogMessage.LogCategory', '10': 'logCategory'},
    const {'1': 'logLevel', '3': 3, '4': 1, '5': 14, '6': '.no.nordicsemi.android.mcumgr_flutter.gen.ProtoLogMessage.LogLevel', '10': 'logLevel'},
    const {'1': 'logDateTime', '3': 4, '4': 1, '5': 3, '10': 'logDateTime'},
  ],
  '4': const [ProtoLogMessage_LogCategory$json, ProtoLogMessage_LogLevel$json],
};

@$core.Deprecated('Use protoLogMessageDescriptor instead')
const ProtoLogMessage_LogCategory$json = const {
  '1': 'LogCategory',
  '2': const [
    const {'1': 'TRANSPORT', '2': 0},
    const {'1': 'CONFIG', '2': 1},
    const {'1': 'CRASH', '2': 2},
    const {'1': 'DEFAULT', '2': 3},
    const {'1': 'FS', '2': 4},
    const {'1': 'IMAGE', '2': 5},
    const {'1': 'LOG', '2': 6},
    const {'1': 'RUN_TEST', '2': 7},
    const {'1': 'STATS', '2': 8},
    const {'1': 'DFU', '2': 9},
  ],
};

@$core.Deprecated('Use protoLogMessageDescriptor instead')
const ProtoLogMessage_LogLevel$json = const {
  '1': 'LogLevel',
  '2': const [
    const {'1': 'DEBUG', '2': 0},
    const {'1': 'VERBOSE', '2': 1},
    const {'1': 'INFO', '2': 2},
    const {'1': 'APPLICATION', '2': 3},
    const {'1': 'WARNING', '2': 4},
    const {'1': 'ERROR', '2': 5},
  ],
};

/// Descriptor for `ProtoLogMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoLogMessageDescriptor = $convert.base64Decode('Cg9Qcm90b0xvZ01lc3NhZ2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZRJnCgtsb2dDYXRlZ29yeRgCIAEoDjJFLm5vLm5vcmRpY3NlbWkuYW5kcm9pZC5tY3VtZ3JfZmx1dHRlci5nZW4uUHJvdG9Mb2dNZXNzYWdlLkxvZ0NhdGVnb3J5Ugtsb2dDYXRlZ29yeRJeCghsb2dMZXZlbBgDIAEoDjJCLm5vLm5vcmRpY3NlbWkuYW5kcm9pZC5tY3VtZ3JfZmx1dHRlci5nZW4uUHJvdG9Mb2dNZXNzYWdlLkxvZ0xldmVsUghsb2dMZXZlbBIgCgtsb2dEYXRlVGltZRgEIAEoA1ILbG9nRGF0ZVRpbWUifgoLTG9nQ2F0ZWdvcnkSDQoJVFJBTlNQT1JUEAASCgoGQ09ORklHEAESCQoFQ1JBU0gQAhILCgdERUZBVUxUEAMSBgoCRlMQBBIJCgVJTUFHRRAFEgcKA0xPRxAGEgwKCFJVTl9URVNUEAcSCQoFU1RBVFMQCBIHCgNERlUQCSJVCghMb2dMZXZlbBIJCgVERUJVRxAAEgsKB1ZFUkJPU0UQARIICgRJTkZPEAISDwoLQVBQTElDQVRJT04QAxILCgdXQVJOSU5HEAQSCQoFRVJST1IQBQ==');
@$core.Deprecated('Use protoMessageLiveLogEnabledDescriptor instead')
const ProtoMessageLiveLogEnabled$json = const {
  '1': 'ProtoMessageLiveLogEnabled',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'enabled', '3': 2, '4': 1, '5': 8, '10': 'enabled'},
  ],
};

/// Descriptor for `ProtoMessageLiveLogEnabled`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protoMessageLiveLogEnabledDescriptor = $convert.base64Decode('ChpQcm90b01lc3NhZ2VMaXZlTG9nRW5hYmxlZBISCgR1dWlkGAEgASgJUgR1dWlkEhgKB2VuYWJsZWQYAiABKAhSB2VuYWJsZWQ=');
