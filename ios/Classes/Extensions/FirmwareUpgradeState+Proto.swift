//
//  FirmwareUpgradeState+Proto.swift
//  mcumgr_flutter
//
//  Created by Mykola Kibysh on 13/12/2020.
//

import Foundation
import iOSMcuManagerLibrary
import Flutter

extension FirmwareUpgradeState {
    func toProto() -> ProtoUpdateStateChanges.FirmwareUpgradeState {
        switch self {
        case .confirm: return .confirm
        case .none: return .none
        case .reset: return .reset
        case .success: return .success
        case .test: return .test
        case .upload: return .upload
        case .validate: return .validate
        case .requestMcuMgrParameters:
            // TODO: new state.
            return .validate
        case .eraseAppSettings:
            return .eraseAppSettings
        }
    }
}
