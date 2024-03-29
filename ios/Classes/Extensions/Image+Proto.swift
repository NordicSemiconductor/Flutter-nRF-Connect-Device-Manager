//
//  Image+Proto.swift
//  mcumgr_flutter
//
//  Created by Nick Kibysh on 18/03/2024.
//

import Foundation
import iOSMcuManagerLibrary

extension ImageManager.Image {
    init(proto: ProtoImage) {
        let image = Int(proto.image)
        let slot = Int(proto.slot)
        let data = proto.data
        
        let hash: Data
        if proto.hasHash {
            hash = proto.hash
        } else {
            hash = try! McuMgrImage(data: data).hash
        }
        
        
        if proto.hasSlot {
            self.init(image: image, slot: slot, hash: hash, data: data)
        } else {
            self.init(image: image, hash: hash, data: data)
        }
        
    }
}
