//
//  Channels.swift
//  mcumgr_flutter
//
//  Created by Nick Kibysh on 11/01/2022.
//

import Foundation

struct Channel {
    private let namespace = "mcumgr_flutter"
    
    private (set) var rawValue: String
    
    private init(name: String) {
        rawValue = namespace + name
    }
    
    static let updateProgressEventChannel = Channel(name:  "/update_progress_event_channel")
    static let updateStateEventChannel = Channel(name:  "/update_state_event_channel")
    static let updateInProgressChannel = Channel(name:  "/update_in_progress_channel")
    static let logEventChannel = Channel(name:  "/log_event_channel")
    // TBD: It will be implemented in the future
    // static let liveLogEnabledChannel = Channel(name:  "/live_log_enabled_channel")
}
