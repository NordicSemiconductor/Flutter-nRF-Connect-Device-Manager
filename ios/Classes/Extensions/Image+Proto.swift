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
        let hash = proto.hash
        let data = proto.data
        
        if proto.hasSlot {
            self.init(image: image, slot: slot, hash: hash, data: data)
        } else {
            self.init(image: image, hash: hash, data: data)
        }
        
    }
}
