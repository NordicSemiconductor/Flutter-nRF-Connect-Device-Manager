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
    let peripheral: CBPeripheral
    
    init(peripheral: CBPeripheral) {
        self.peripheral = peripheral
    }
}
