//
//  Proto+ext.swift
//  mcumgr_flutter
//
//  Created by Mykola Kibysh on 13/12/2020.
//

import Foundation
import CoreBluetooth

extension ProgressUpdateStreamArg {
    init(progressUpdate: ProgressUpdate, peripheral: CBPeripheral) {
        self.uuid = peripheral.identifier.uuidString
        self.progressUpdate = progressUpdate
    }
}

extension UpdateStateChangesStreamArg {
    init(updateStateChanges: UpdateStateChanges, peripheral: CBPeripheral) {
        self.uuid = peripheral.identifier.uuidString
        self.updateStateChanges = updateStateChanges
    }
}
