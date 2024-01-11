//
//  UpdateLogger.swift
//  mcumgr_flutter
//
//  Created by Nick Kibysh on 29/12/2021.
//

import Foundation
import iOSMcuManagerLibrary

class UpdateLogger {
    let logStreamHandler: StreamHandler
    let identifier: String
    
    private var messages: [ProtoLogMessage] = []
    
    var liveUpdateEnabled = false
    var liveLogLevel: McuMgrLogLevel = .debug
    private var timer: Timer!
    
    init(identifier: String, streamHandler: StreamHandler) {
        self.identifier = identifier
        self.logStreamHandler = streamHandler
    }
    
    func toggleLiveLoggs() -> Bool {
        liveUpdateEnabled = !liveUpdateEnabled
        return liveUpdateEnabled
    }
    
    func readLogs(clearMessages: Bool = false) -> ProtoReadMessagesResponse {
        let response = ProtoReadMessagesResponse(uuid: identifier, messages: messages)
        if clearMessages {
            clearLogs()
        }
        return response
    }
   
    func clearLogs() {
        messages.removeAll()
    }
}

extension UpdateLogger: McuMgrLogDelegate {
    func log(_ msg: String, ofCategory category: McuMgrLogCategory, atLevel level: McuMgrLogLevel) {
        if case .verbose = level {
            return
        }

        let log = ProtoLogMessage(message: msg, category: category.toProto(), level: level.toProto(), timeInterval: Date().timeIntervalSince1970)
        
        messages.append(log)
        
        if liveUpdateEnabled && level.rawValue >= liveLogLevel.rawValue {
            do {
                let container = ProtoLogMessageStreamArg(uuid: identifier, msg: log)
                let data = try container.serializedData()
                logStreamHandler.sink?(FlutterStandardTypedData(bytes: data))
            } catch let e {
                print(e.localizedDescription)
            }
        }
    }
}
