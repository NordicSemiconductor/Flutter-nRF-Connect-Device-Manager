//
//  UpdateManager.swift
//  mcumgr_flutter
//
//  Created by Mykola Kibysh on 11/12/2020.
//

import Foundation
import McuManager
import CoreBluetooth

class UpdateManager {
    let transport: McuMgrBleTransport
    let progressStreamHandler: StreamHandler
    let stateStreamHandler: StreamHandler
    let logStreamhandler: StreamHandler
    let peripheral: CBPeripheral
    
    private (set) lazy var dfuManager: FirmwareUpgradeManager = FirmwareUpgradeManager(transporter: self.transport, delegate: self)
    
    init(peripheral: CBPeripheral, progressStreamHandler: StreamHandler, stateStreamHandler: StreamHandler, logStreamhandler: StreamHandler) {
        self.peripheral = peripheral
        self.transport = McuMgrBleTransport(peripheral)
        self.progressStreamHandler = progressStreamHandler
        self.stateStreamHandler = stateStreamHandler
        self.logStreamhandler = logStreamhandler
    }
    
    func update(data: Data) throws {
        dfuManager.logDelegate = self
        try dfuManager.start(data: data)
    }
}

extension UpdateManager: FirmwareUpgradeDelegate {
    func upgradeDidStart(controller: FirmwareUpgradeController) {
        
    }
    
    func upgradeStateDidChange(from previousState: FirmwareUpgradeState, to newState: FirmwareUpgradeState) {
        do {
            let oldProtoState = previousState.toProto()
            let newProtoState = newState.toProto()
            var changes = ProtoUpdateStateChanges()
            changes.oldState = oldProtoState
            changes.newState = newProtoState
            
            let arg = ProtoUpdateStateChangesStreamArg(updateStateChanges: changes, peripheral: peripheral)
            let data = try arg.serializedData()
            stateStreamHandler.sink?(FlutterStandardTypedData(bytes: data))
        } catch let e {
            let error = FlutterError(error: e, code: ErrorCode.flutterTypeError)
            stateStreamHandler.sink?(error)
        }
    }
    
    func upgradeDidComplete() {
        var stateChangesArg = ProtoUpdateStateChangesStreamArg(updateStateChanges: nil, peripheral: peripheral)
        stateChangesArg.done = true
        
        var progressArg = ProtoProgressUpdateStreamArg(progressUpdate: nil, peripheral: peripheral)
        progressArg.done = true
        
        var logArg = ProtoLogMessageStreamArg(uuid: peripheral.identifier.uuidString, log: ProtoLogMessage())
        logArg.done = true
        
        
        do {
            let statusData = try stateChangesArg.serializedData()
            stateStreamHandler.sink?(FlutterStandardTypedData(bytes: statusData))
            
            let progressData = try progressArg.serializedData()
            progressStreamHandler.sink?(FlutterStandardTypedData(bytes: progressData))
            
            let logData = try logArg.serializedData()
            logStreamhandler.sink?(FlutterStandardTypedData(bytes: logData))
        } catch let e {
            let error = FlutterError(error: e, code: ErrorCode.flutterTypeError)
            stateStreamHandler.sink?(error)
        }
    }
    
    func upgradeDidFail(inState state: FirmwareUpgradeState, with error: Error) {
        var changes = ProtoUpdateStateChanges()
        changes.oldState = state.toProto()
        changes.newState = state.toProto()
        
        var arg = ProtoUpdateStateChangesStreamArg(updateStateChanges: changes, peripheral: peripheral)
        arg.error = ProtoError(localizedDescription: error.localizedDescription)

        do {
            let data = try arg.serializedData()
            stateStreamHandler.sink?(FlutterStandardTypedData(bytes: data))
        } catch let e {
            let error = FlutterError(error: e, code: ErrorCode.flutterTypeError)
            stateStreamHandler.sink?(error)
        }
    }
    
    func upgradeDidCancel(state: FirmwareUpgradeState) {
        do {
            var changes = ProtoUpdateStateChanges()
            changes.canceled = true
            changes.oldState = state.toProto()
            changes.newState = state.toProto()
            
            let arg = ProtoUpdateStateChangesStreamArg(updateStateChanges: changes, peripheral: peripheral)
            stateStreamHandler.sink?(FlutterStandardTypedData(bytes: try arg.serializedData()))
        } catch let e {
            let error = FlutterError(error: e, code: ErrorCode.flutterTypeError)
            stateStreamHandler.sink?(error)
        }
        
    }
    
    func uploadProgressDidChange(bytesSent: Int, imageSize: Int, timestamp: Date) {
        do {
            var progressUpdate = ProtoProgressUpdate()
            progressUpdate.bytesSent = UInt64(Int64(bytesSent))
            progressUpdate.imageSize = UInt64(Int64(imageSize))
            progressUpdate.timestamp = timestamp.timeIntervalSince1970
            
            let arg = ProtoProgressUpdateStreamArg(progressUpdate: progressUpdate, peripheral: peripheral)
            stateStreamHandler.sink?(FlutterStandardTypedData(bytes: try arg.serializedData()))
        } catch let e {
            let error = FlutterError(error: e, code: ErrorCode.flutterTypeError)
            stateStreamHandler.sink?(error)
        }
    }
}

extension UpdateManager: McuMgrLogDelegate {
    func log(_ msg: String, ofCategory category: McuMgrLogCategory, atLevel level: McuMgrLogLevel) {
        let log = ProtoLogMessage(message: msg, category: category.toProto(), level: level.toProto())
        let logStremArg = ProtoLogMessageStreamArg(uuid: peripheral.identifier.uuidString, log: log)
        
        do {
            logStreamhandler.sink?(FlutterStandardTypedData(bytes: try logStremArg.serializedData()))
        } catch let e {
            let error = FlutterError(error: e, code: ErrorCode.flutterTypeError)
            stateStreamHandler.sink?(error)
        }
    }
    
    
}
