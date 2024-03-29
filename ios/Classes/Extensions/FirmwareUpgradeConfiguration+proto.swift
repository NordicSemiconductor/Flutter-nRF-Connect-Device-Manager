//
//  FirmwareUpgradeConfiguration+proto.swift
//  mcumgr_flutter
//
//  Created by Nick Kibysh on 08/03/2023.
//

import Foundation
import iOSMcuManagerLibrary

extension ImageUploadAlignment {
    init(proto: ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment) {
        switch proto {
        case .disabled:
            self = .disabled
        case .twoByte:
            self = .twoByte
        case .fourByte:
            self = .fourByte
        case .eightByte:
            self = .eightByte
        case .sixteenByte:
            self = .sixteenByte
        case .UNRECOGNIZED(let int):
            fatalError("Unsupported value \(int)")
        }
    }
}

extension FirmwareUpgradeMode {
    init(proto: ProtoFirmwareUpgradeConfiguration.FirmwareUpgradeMode) {
        switch proto {
        case .testAndConfirm:
            self = .testAndConfirm
        case .testOnly:
            self = .testOnly
        case .confirmOnly:
            self = .confirmOnly
        case .uploadOnly:
            self = .uploadOnly
        case .UNRECOGNIZED(let int):
            fatalError("Unsupported value \(int)")
        }
    }
}

extension FirmwareUpgradeConfiguration {
    init(proto: ProtoFirmwareUpgradeConfiguration) {
        let estimatedSwapTime: TimeInterval = Double(proto.estimatedSwapTimeMs) / 1000
        let eraseAppSettings = proto.eraseAppSettings
        let pipelineDepth = Int(proto.pipelineDepth)
        let byteAlignment = ImageUploadAlignment(proto: proto.byteAlignment)
        let mode = FirmwareUpgradeMode(proto: proto.firmwareUpgradeMode)
        
        self.init(
            estimatedSwapTime: estimatedSwapTime,
            eraseAppSettings: eraseAppSettings,
            pipelineDepth: pipelineDepth,
            byteAlignment: byteAlignment,
            upgradeMode: mode
        )
    }
}
