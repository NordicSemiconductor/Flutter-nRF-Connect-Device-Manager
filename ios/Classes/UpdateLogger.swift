//
//  UpdateLogger.swift
//  mcumgr_flutter
//
//  Created by Nick Kibysh on 29/12/2021.
//

import Foundation
import McuManager

class UpdateLogger {
    let logStreamHandler: StreamHandler
    let identifier: String
    private var messages: [ProtoLogMessage] = []
    var timeInterval: TimeInterval = 1.0 {
        didSet {
             setTimer(enabled: !liveUpdateEnabled, timeInterval: timeInterval)
        }
    }
    var liveUpdateEnabled = false {
        didSet {
            setTimer(enabled: !liveUpdateEnabled, timeInterval: timeInterval)
        }
    }
    private var timer: Timer!
    
    init(identifier: String, streamHandler: StreamHandler) {
        self.identifier = identifier
        self.logStreamHandler = streamHandler
        setTimer(enabled: true, timeInterval: 1.0)
    }
}

extension UpdateLogger {
    private func setTimer(enabled: Bool, timeInterval: TimeInterval) {
        if enabled {
            timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] t in
                self?.sendMessages()
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
}

extension UpdateLogger: McuMgrLogDelegate {
    func log(_ msg: String, ofCategory category: McuMgrLogCategory, atLevel level: McuMgrLogLevel) {
        let log = ProtoLogMessage(message: msg, category: category.toProto(), level: level.toProto(), timeInterval: Date().timeIntervalSince1970)
        
        messages.append(log)
    }
}
