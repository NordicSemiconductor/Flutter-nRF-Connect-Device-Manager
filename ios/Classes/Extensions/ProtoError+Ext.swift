//
//  ProtoError+Ext.swift
//  mcumgr_flutter
//
//  Created by Mykola Kibysh on 13/12/2020.
//

import Foundation

extension ProtoError: Error {
    init(localizedDescription: String) {
        self.localizedDescription = localizedDescription
    }
}
