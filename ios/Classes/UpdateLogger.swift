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
    let liveLogEnabledStreamHandler: StreamHandler
    let identifier: String
    
    private var allMessages: [ProtoLogMessage] = []
    private var messages: [ProtoLogMessage] = []
    
    var timeInterval: TimeInterval = 1.0 {
        didSet {
            setTimer(enabled: !liveUpdateEnabled, timeInterval: timeInterval)
        }
    }
    var liveUpdateEnabled = false {
        didSet {
            setTimer(enabled: !liveUpdateEnabled, timeInterval: timeInterval)
            sendLiveUpdateStatus()
        }
    }
    private var timer: Timer!
    
    init(identifier: String, streamHandler: StreamHandler, liveLogEnabledStreamHandler: StreamHandler) {
        self.identifier = identifier
        self.logStreamHandler = streamHandler
        self.liveLogEnabledStreamHandler = liveLogEnabledStreamHandler
        setTimer(enabled: true, timeInterval: 1.0)
        
        sendLiveUpdateStatus()
    }
    
    func toggleLiveLoggs() -> Bool {
        liveUpdateEnabled = !liveUpdateEnabled
        return liveUpdateEnabled
    }
    
    func readLogs() -> ProtoLogMessageStreamArg {
        let logStreamArg = ProtoLogMessageStreamArg(uuid: identifier, logs: messages)
        sendMessages()
        return logStreamArg
    }
    
    func getAllLogs() -> ProtoLogMessageStreamArg {
        return ProtoLogMessageStreamArg(uuid: identifier, logs: allMessages)
    }
    
    func clearLogs() {
        messages.removeAll()
        allMessages.removeAll()
        sendMessages()
    }
}

extension UpdateLogger {
    private func setTimer(enabled: Bool, timeInterval: TimeInterval) {
        if enabled {
            timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] t in
                self?.sendMessages()
                self?.messages.removeAll()
            })
        } else if let t = timer {
            t.invalidate()
        }
    }
    
    private func sendMessages() {
        do {
            let logStreamArg = ProtoLogMessageStreamArg(uuid: identifier, logs: messages)
            logStreamHandler.sink?(FlutterStandardTypedData(bytes: try logStreamArg.serializedData()))
        } catch let e {
            let error = FlutterError(error: e, code: ErrorCode.flutterTypeError)
            logStreamHandler.sink?(error)
        }
    }
    
    private func sendLiveUpdateStatus() {
        do {
            let enabledArgs = ProtoMessageLiveLogEnabled(uuid: identifier, enabled: liveUpdateEnabled)
            liveLogEnabledStreamHandler.sink?(FlutterStandardTypedData(bytes: try enabledArgs.serializedData()))
        } catch let e {
            let error = FlutterError(error: e, code: ErrorCode.flutterTypeError)
            logStreamHandler.sink?(error)
        }
    }
}

extension UpdateLogger: McuMgrLogDelegate {
    func log(_ msg: String, ofCategory category: McuMgrLogCategory, atLevel level: McuMgrLogLevel) {
        if case .verbose = level {
            return
        }

        let log = ProtoLogMessage(message: msg, category: category.toProto(), level: level.toProto(), timeInterval: Date().timeIntervalSince1970)
        
        messages.append(log)
        allMessages.append(log)
    }
}
