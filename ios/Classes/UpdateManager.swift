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
    private (set) lazy var dfuManager: FirmwareUpgradeManager = FirmwareUpgradeManager(transporter: self.transport, delegate: self)
    
    init(peripheral: CBPeripheral) {
        self.transport = McuMgrBleTransport(peripheral)
    }
    
    func update(data: Data) throws {
        try dfuManager.start(data: data)
    }
}

extension UpdateManager: FirmwareUpgradeDelegate {
    func upgradeDidStart(controller: FirmwareUpgradeController) {
        
    }
    
    func upgradeStateDidChange(from previousState: FirmwareUpgradeState, to newState: FirmwareUpgradeState) {
        
    }
    
    func upgradeDidComplete() {
        
    }
    
    func upgradeDidFail(inState state: FirmwareUpgradeState, with error: Error) {
        
    }
    
    func upgradeDidCancel(state: FirmwareUpgradeState) {
        
    }
    
    func uploadProgressDidChange(bytesSent: Int, imageSize: Int, timestamp: Date) {
        
    }
    
    
}
