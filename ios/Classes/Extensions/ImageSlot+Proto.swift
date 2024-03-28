//
//  ImageSlot+Proto.swift
//  mcumgr_flutter
//
//  Created by Nick Kibysh on 27/03/2024.
//

import Foundation
import iOSMcuManagerLibrary

extension McuMgrImageStateResponse.ImageSlot {
    func toProto() -> ProtoImageSlot {
        var proto = ProtoImageSlot()
        proto.image = image
        proto.slot = slot
        version.map { proto.version = $0 }
        proto.hash = Data(hash)
        proto.bootable = bootable
        proto.pending = pending
        proto.confirmed = confirmed
        proto.active = active
        proto.permanent = permanent
        return proto
    }
}
