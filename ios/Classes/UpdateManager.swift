//
//  UpdateManager.swift
//  mcumgr_flutter
//
//  Created by Mykola Kibysh on 11/12/2020.
//

import Foundation
import iOSMcuManagerLibrary
import CoreBluetooth

protocol UpdateManagerDelegate: AnyObject {
    func updateCompleted(manager: UpdateManager)
}

class UpdateManager {
    let transport: McuMgrBleTransport
    let progressStreamHandler: StreamHandler
    let stateStreamHandler: StreamHandler
    let peripheral: CBPeripheral
    let updateLogger: UpdateLogger
    
    private (set) lazy var dfuManager: FirmwareUpgradeManager = FirmwareUpgradeManager(transporter: self.transport, delegate: self)
    
    init(peripheral: CBPeripheral, progressStreamHandler: StreamHandler, stateStreamHandler: StreamHandler, updateLogger: UpdateLogger) {
        self.peripheral = peripheral
        self.transport = McuMgrBleTransport(peripheral)
        self.progressStreamHandler = progressStreamHandler
        self.stateStreamHandler = stateStreamHandler
        self.updateLogger = updateLogger
    }
    
    func update(data: Data) throws {
        dfuManager.logDelegate = updateLogger
        try dfuManager.start(data: data)
    }
    
    func update(images: [(Int, Data)], config: FirmwareUpgradeConfiguration) throws {
        dfuManager.mode = .confirmOnly
        dfuManager.logDelegate = updateLogger
        try dfuManager.start(images: images, using: config)
    }
    
    func pause() {
        if dfuManager.isInProgress() {
            dfuManager.pause()
        }
    }
    
    func resume() {
        if dfuManager.isPaused() {
            dfuManager.resume()
        }
    }

    func cancel() {
        dfuManager.cancel()
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
        
        var logArg = ProtoLogMessageStreamArg(uuid: peripheral.identifier.uuidString, logs: [])
        logArg.done = true
        
        do {
            let statusData = try stateChangesArg.serializedData()
            stateStreamHandler.sink?(FlutterStandardTypedData(bytes: statusData))
            
            let progressData = try progressArg.serializedData()
            progressStreamHandler.sink?(FlutterStandardTypedData(bytes: progressData))
            
            let logData = try logArg.serializedData()
//            logStreamHandler.sink?(FlutterStandardTypedData(bytes: logData))
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
            let data = try arg.serializedData()
            let flutterData = FlutterStandardTypedData(bytes: data)
            progressStreamHandler.sink?(flutterData)
        } catch let e {
            let error = FlutterError(error: e, code: ErrorCode.flutterTypeError)
            progressStreamHandler.sink?(error)
        }
    }
}
