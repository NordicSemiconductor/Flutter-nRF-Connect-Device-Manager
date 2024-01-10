//
//  Proto+ext.swift
//  mcumgr_flutter
//
//  Created by Mykola Kibysh on 13/12/2020.
//

import Foundation
import CoreBluetooth
import iOSMcuManagerLibrary

extension ProtoProgressUpdateStreamArg {
    init(progressUpdate: ProtoProgressUpdate?, peripheral: CBPeripheral) {
        self.uuid = peripheral.identifier.uuidString
        if let pu = progressUpdate {
            self.progressUpdate = pu
        }
    }
}

extension ProtoUpdateStateChangesStreamArg {
    init(updateStateChanges: ProtoUpdateStateChanges?, peripheral: CBPeripheral) {
        self.uuid = peripheral.identifier.uuidString
        if let pu = updateStateChanges {
            self.updateStateChanges = pu
        }
    }
}

extension ProtoLiveLogConfiguration {
    init(uuid: String, enabled: Bool, logLevel: McuMgrLogLevel) {
        self.uuid = uuid
        self.enabled = enabled
        self.logLevel = logLevel.toProto()
    }
}

extension ProtoLogMessage.LogLevel {
    func toModel() -> McuMgrLogLevel {
        switch self {
        case .debug:
            return .debug
        case .verbose:
            return .verbose
        case .info:
            return .info
        case .application:
            return .application
        case .warning:
            return .warning
        case .error:
            return .error
        case .UNRECOGNIZED(_):
            fatalError("Unrecognized Log Level")
        }
    }
}

extension ProtoReadMessagesResponse {
    init(uuid: String, messages: [ProtoLogMessage]) {
        self.uuid = uuid
        self.protoLogMessage = messages
    }
}
