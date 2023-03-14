//
//  FlutterEventChannel+ext.swift
//  mcumgr_flutter
//
//  Created by Nick Kibysh on 11/01/2022.
//

import Foundation
import Flutter

extension FlutterEventChannel {
    convenience init(channel: Channel, binaryMessenger: FlutterBinaryMessenger) {
        self.init(name: channel.rawValue, binaryMessenger: binaryMessenger)
    }
}
