//
//  Proto+ext.swift
//  mcumgr_flutter
//
//  Created by Mykola Kibysh on 13/12/2020.
//

import Foundation
import CoreBluetooth

extension ProtoProgressUpdateStreamArg {
    init(progressUpdate: ProtoProgressUpdate, peripheral: CBPeripheral) {
        self.uuid = peripheral.identifier.uuidString
        self.progressUpdate = progressUpdate
    }
}

extension ProtoUpdateStateChangesStreamArg {
    init(updateStateChanges: ProtoUpdateStateChanges, peripheral: CBPeripheral) {
        self.uuid = peripheral.identifier.uuidString
        self.updateStateChanges = updateStateChanges
    }
}
