//
//  StreamHandler.swift
//  mcumgr_flutter
//
//  Created by Mykola Kibysh on 13/12/2020.
//

import Foundation
import Flutter

class StreamHandler: NSObject, FlutterStreamHandler {
    private (set) var sink: FlutterEventSink?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.sink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.sink = nil
        return nil
    }
    
    
}
