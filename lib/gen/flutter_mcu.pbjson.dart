///
//  Generated code. Do not modify.
//  source: flutter_mcu.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const ProtoUpdateCallArgument$json = const {
  '1': 'ProtoUpdateCallArgument',
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

const ProtoUpdateStateChangesStreamArg$json = const {
  '1': 'ProtoUpdateStateChangesStreamArg',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'updateStateChanges', '3': 2, '4': 1, '5': 11, '6': '.ProtoUpdateStateChanges', '10': 'updateStateChanges'},
  ],
};

const ProtoUpdateStateChanges$json = const {
  '1': 'ProtoUpdateStateChanges',
  '2': const [
    const {'1': 'oldState', '3': 1, '4': 1, '5': 14, '6': '.ProtoUpdateStateChanges.FirmwareUpgradeState', '10': 'oldState'},
    const {'1': 'newState', '3': 2, '4': 1, '5': 14, '6': '.ProtoUpdateStateChanges.FirmwareUpgradeState', '10': 'newState'},
    const {'1': 'canceled', '3': 3, '4': 1, '5': 8, '10': 'canceled'},
    const {'1': 'hasError', '3': 4, '4': 1, '5': 8, '10': 'hasError'},
    const {'1': 'protoError', '3': 5, '4': 1, '5': 11, '6': '.ProtoError', '10': 'protoError'},
    const {'1': 'completed', '3': 6, '4': 1, '5': 8, '10': 'completed'},
  ],
  '4': const [ProtoUpdateStateChanges_FirmwareUpgradeState$json],
};

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

const ProtoProgressUpdateStreamArg$json = const {
  '1': 'ProtoProgressUpdateStreamArg',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'progressUpdate', '3': 2, '4': 1, '5': 11, '6': '.ProtoProgressUpdate', '10': 'progressUpdate'},
  ],
};

const ProtoProgressUpdate$json = const {
  '1': 'ProtoProgressUpdate',
  '2': const [
    const {'1': 'bytesSent', '3': 1, '4': 1, '5': 4, '10': 'bytesSent'},
    const {'1': 'imageSize', '3': 2, '4': 1, '5': 4, '10': 'imageSize'},
    const {'1': 'timestamp', '3': 3, '4': 1, '5': 1, '10': 'timestamp'},
  ],
};

const ProtoLogMessageStreamArg$json = const {
  '1': 'ProtoLogMessageStreamArg',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'protoLogMessage', '3': 2, '4': 1, '5': 11, '6': '.ProtoLogMessage', '10': 'protoLogMessage'},
  ],
};

const ProtoLogMessage$json = const {
  '1': 'ProtoLogMessage',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'logCategory', '3': 2, '4': 1, '5': 14, '6': '.ProtoLogMessage.LogCategory', '10': 'logCategory'},
    const {'1': 'logLevel', '3': 3, '4': 1, '5': 14, '6': '.ProtoLogMessage.LogLevel', '10': 'logLevel'},
  ],
  '4': const [ProtoLogMessage_LogCategory$json, ProtoLogMessage_LogLevel$json],
};

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

