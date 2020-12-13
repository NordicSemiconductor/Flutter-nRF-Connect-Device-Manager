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
    
    private (set) lazy var dfuManager: FirmwareUpgradeManager = FirmwareUpgradeManager(transporter: self.transport, delegate: self)
    
    init(peripheral: CBPeripheral, progressStreamHandler: StreamHandler, stateStreamHandler: StreamHandler, logStreamhandler: StreamHandler) {
        self.transport = McuMgrBleTransport(peripheral)
        self.progressStreamHandler = progressStreamHandler
        self.stateStreamHandler = stateStreamHandler
        self.logStreamhandler = logStreamhandler
    }
    
    func update(data: Data) throws {
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
            var changes = UpdateStateChanges()
            changes.oldState = oldProtoState
            changes.newState = newProtoState
            let data = try changes.serializedData()
            stateStreamHandler.sink?(FlutterStandardTypedData(bytes: data))
        } catch let e {
            let error = FlutterError(error: e, code: ErrorCode.flutterTypeError)
            stateStreamHandler.sink?(error)
        }
    }
    
    func upgradeDidComplete() {
        do {
            var changes = UpdateStateChanges()
            changes.completed = true
            let data = try changes.serializedData()
            stateStreamHandler.sink?(FlutterStandardTypedData(bytes: data))
        } catch let e {
            let error = FlutterError(error: e, code: ErrorCode.flutterTypeError)
            stateStreamHandler.sink?(error)
        }
    }
    
    func upgradeDidFail(inState state: FirmwareUpgradeState, with error: Error) {
        do {
            var changes = UpdateStateChanges()
            let protoError = ProtoError(localizedDescription: error.localizedDescription)
            changes.error = protoError
            changes.oldState = state.toProto()
            stateStreamHandler.sink?(FlutterStandardTypedData(bytes: try changes.serializedData()))
        } catch let e {
            let error = FlutterError(error: e, code: ErrorCode.flutterTypeError)
            stateStreamHandler.sink?(error)
        }
    }
    
    func upgradeDidCancel(state: FirmwareUpgradeState) {
        do {
            var changes = UpdateStateChanges()
            changes.canceled = true
            changes.oldState = state.toProto()
            stateStreamHandler.sink?(FlutterStandardTypedData(bytes: try changes.serializedData()))
        } catch let e {
            let error = FlutterError(error: e, code: ErrorCode.flutterTypeError)
            stateStreamHandler.sink?(error)
        }
        
    }
    
    func uploadProgressDidChange(bytesSent: Int, imageSize: Int, timestamp: Date) {
        
    }
    
    
}
