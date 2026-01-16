//
//  FlutterEventChannel+ext.swift
//  mcumgr_flutter
//
//  Created by Nick Kibysh on 11/01/2022.
//

#if os(iOS)
import Flutter
import UIKit
#elseif os(macOS)
import FlutterMacOS
import AppKit
#endif

extension FlutterEventChannel {
    convenience init(channel: Channel, binaryMessenger: FlutterBinaryMessenger) {
        self.init(name: channel.rawValue, binaryMessenger: binaryMessenger)
    }
}
