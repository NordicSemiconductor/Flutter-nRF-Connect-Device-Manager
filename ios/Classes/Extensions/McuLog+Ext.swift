//
//  McuLog+Ext.swift
//  mcumgr_flutter
//
//  Created by Mykola Kibysh on 14/12/2020.
//

import Foundation
import iOSMcuManagerLibrary

extension McuMgrLogLevel {
    func toProto() -> ProtoLogMessage.LogLevel {
        switch self {
        case .application: return .application
        case .debug: return .debug
        case .error: return .error
        case .info: return .info
        case .verbose: return .verbose
        case .warning: return .warning
        }
    }
}

extension McuMgrLogCategory {
    func toProto() -> ProtoLogMessage.LogCategory {
        switch self {
        case .transport: return .transport
        case .config: return .config
        case .crash: return .crash
        case .`default`: return .`default`
        case .fs: return .fs
        case .image: return .image
        case .log: return .log
        case .runTest: return .runTest
        case .stats: return .stats
        case .dfu: return .dfu
        case .basic:
            return .`default`
        }
    }
}

extension ProtoLogMessageStreamArg {
    init(uuid: String, logs: [ProtoLogMessage]) {
        self.uuid = uuid
        self.protoLogMessage = logs
    }
}

extension ProtoLogMessage {
    init(message: String, category: ProtoLogMessage.LogCategory, level: ProtoLogMessage.LogLevel, timeInterval: TimeInterval) {
        self.message = message
        self.logCategory = category
        self.logLevel = level
        self.logDateTime = Int64(timeInterval * 1000)
    }
}
