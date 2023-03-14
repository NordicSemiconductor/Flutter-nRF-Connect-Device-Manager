//
//  Proto+ext.swift
//  mcumgr_flutter
//
//  Created by Mykola Kibysh on 13/12/2020.
//

import Foundation
import CoreBluetooth

extension ProtoProgressUpdateStreamArg {
    init(progressUpdate: ProtoProgressUpdate?, peripheral: CBPeripheral) {
        self.uuid = peripheral.identifier.uuidString
        if let pu = progressUpdate {
            self.progressUpdate = pu
        }
    }
}

extension ProtoUpdateStateChangesStreamArg {
    init(updateStateChanges: ProtoUpdateStateChanges?, peripheral: CBPeripheral) {
        self.uuid = peripheral.identifier.uuidString
        if let pu = updateStateChanges {
            self.updateStateChanges = pu
        }
    }
}

extension ProtoMessageLiveLogEnabled {
    init(uuid: String, enabled: Bool) {
        self.uuid = uuid
        self.enabled = enabled
    }
}
