///
//  Generated code. Do not modify.
//  source: flutter_mcu.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const UpdateCallArgument$json = const {
  '1': 'UpdateCallArgument',
  '2': const [
    const {'1': 'device_uuid', '3': 1, '4': 1, '5': 9, '10': 'deviceUuid'},
    const {'1': 'firmware_data', '3': 2, '4': 1, '5': 12, '10': 'firmwareData'},
  ],
};

const ProtoError$json = const {
  '1': 'ProtoError',
  '2': const [
    const {'1': 'localizedDescription', '3': 1, '4': 1, '5': 9, '10': 'localizedDescription'},
  ],
};

const UpdateStateChanges$json = const {
  '1': 'UpdateStateChanges',
  '2': const [
    const {'1': 'oldState', '3': 1, '4': 1, '5': 14, '6': '.UpdateStateChanges.FirmwareUpgradeState', '10': 'oldState'},
    const {'1': 'newState', '3': 2, '4': 1, '5': 14, '6': '.UpdateStateChanges.FirmwareUpgradeState', '10': 'newState'},
    const {'1': 'canceled', '3': 3, '4': 1, '5': 8, '10': 'canceled'},
    const {'1': 'hasError', '3': 4, '4': 1, '5': 8, '10': 'hasError'},
    const {'1': 'error', '3': 5, '4': 1, '5': 11, '6': '.ProtoError', '10': 'error'},
    const {'1': 'completed', '3': 6, '4': 1, '5': 8, '10': 'completed'},
  ],
  '4': const [UpdateStateChanges_FirmwareUpgradeState$json],
};

const UpdateStateChanges_FirmwareUpgradeState$json = const {
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

const ProgressUpdate$json = const {
  '1': 'ProgressUpdate',
  '2': const [
    const {'1': 'bytesSent', '3': 1, '4': 1, '5': 4, '10': 'bytesSent'},
    const {'1': 'imageSize', '3': 2, '4': 1, '5': 4, '10': 'imageSize'},
    const {'1': 'timestamp', '3': 3, '4': 1, '5': 1, '10': 'timestamp'},
  ],
};

