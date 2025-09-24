//
//  SettingsManager.swift
//  Pods
//
//  Created by Slawomir Krol on 20/09/2025.
//

import iOSMcuManagerLibrary
import SwiftCBOR
import Foundation

final class SettingsManager {
    private let transport: McuMgrTransport
    private let mcuMgrSettingsManager: iOSMcuManagerLibrary.SettingsManager
    private let padTo4Bytes: Bool
    private let encodeValueToCBOR: Bool

    private static let errorCode = "MCU_MGR_SETTINGS_MANAGER"

    init(transport: McuMgrTransport, padTo4Bytes: Bool = false, encodeValueToCBOR: Bool = false) {
        self.transport = transport
        self.mcuMgrSettingsManager = iOSMcuManagerLibrary.SettingsManager(transport: transport)
        self.padTo4Bytes = padTo4Bytes
        self.encodeValueToCBOR = encodeValueToCBOR
    }

    func fetchSettings(result: @escaping FlutterResult) {
        mcuMgrSettingsManager.load { response, error in
            if let error = error {
                result(FlutterError(code: Self.errorCode,
                                    message: error.localizedDescription,
                                    details: nil))
                return
            }

            guard let response = response else {
                result(FlutterError(code: Self.errorCode,
                                    message: "No response data",
                                    details: nil))
                return
            }

            result(FlutterStandardTypedData(bytes: response.rawData ?? Data()))
        }
    }

    func readSettings(key: String, result: @escaping FlutterResult) {
        mcuMgrSettingsManager.read(name: key) { response, error in
            print("RESPONSE?", response, error, response?.val, response?.rawData)
            if let error = error {
                result(FlutterError(code: Self.errorCode,
                                    message: error.localizedDescription,
                                    details: nil))
                return
            }

            guard let response = response else {
                result(FlutterError(code: Self.errorCode,
                                    message: "No response data",
                                    details: nil))
                return
            }

            if let payload = response.payload {
                let flutterValue = payload.convertCBORToFlutter()
                print("FLUTTERVALUE?", flutterValue)
                result(flutterValue)

              //  result(FlutterStandardTypedData(bytes: value))
            } else {
                result(FlutterError(code: Self.errorCode,
                                    message: "No value in response",
                                    details: nil))
            }

        }
    }

    func writeSetting(key: String, value: Any, result: @escaping FlutterResult) {
        do {
            let valueBytes: [UInt8]

            if encodeValueToCBOR {
                if let value = value as? String, padTo4Bytes {
                    valueBytes = try CBOR.encodeAny(padStringTo4Bytes(value))
                } else {
                    if let value = value as? Bool {
                        // Needs to do separate method for boolean because __NSCFBoolean is recognized as Int and wrong encoded
                        valueBytes = CBOR.encodeBool(value)
                    } else {
                        valueBytes = try CBOR.encodeAny(value)
                    }
                }
            } else {
                valueBytes = try toBytes(value: value)
            }

            print("WTF?", encodeValueToCBOR, value is Bool, type(of: value), valueBytes)
            mcuMgrSettingsManager.write(name: key, value: valueBytes) { response, error in
                if let error = error {
                    result(FlutterError(code: Self.errorCode,
                                        message: error.localizedDescription,
                                        details: nil))
                    return
                }

                guard let response = response else {
                    result(FlutterError(code: Self.errorCode,
                                        message: "No response data",
                                        details: nil))
                    return
                }

                switch response.result {
                case .success:
                    result(FlutterStandardTypedData(bytes: response.rawData ?? Data()))
                    break
                case .failure(let error):
                    result(FlutterError(code: Self.errorCode,
                                        message: "Error decoding write response: \(error.localizedDescription)",
                                        details: nil))
                }
            }
        } catch {
            result(FlutterError(code: Self.errorCode,
                                message: "Error encoding value: \(error.localizedDescription)",
                                details: nil))
        }
    }

    private func padStringTo4Bytes(_ string: String) -> String {
        guard padTo4Bytes else { return string }

        let bytes = string.utf8
        let paddingNeeded = (4 - (bytes.count % 4)) % 4

        if paddingNeeded == 0 {
            return string
        } else {
            return string + String(repeating: "\0", count: paddingNeeded)
        }
    }

    private func toBytes(value: Any) throws -> [UInt8] {
        switch value {
        case let string as String:
            let paddedString = padTo4Bytes ? padStringTo4Bytes(string) : string
            return Array(paddedString.utf8)

        case let int as Int:
            var value = Int32(int)
            return withUnsafeBytes(of: &value) { Array($0) }

        case let float as Float:
            var value = float
            return withUnsafeBytes(of: &value) { Array($0) }

        case let double as Double:
            var value = double
            return withUnsafeBytes(of: &value) { Array($0) }

        case let bool as Bool:
            return [bool ? 1 : 0]

        case let data as FlutterStandardTypedData:
            return Array(data.data)

        case let data as Data:
            return Array(data)

        case let bytes as [UInt8]:
            return bytes

        default:
            throw SettingsManagerError.unsupportedType("\(type(of: value))")
        }
    }
}

private enum SettingsManagerError: LocalizedError {
    case unsupportedType(String)

    var errorDescription: String? {
        switch self {
        case .unsupportedType(let type):
            return "Unsupported type: \(type)"
        }
    }
}

private extension CBOR {
    func convertCBORToFlutter() -> Any {
        switch self {
        case .unsignedInt(let v):
            return Int(v)
        case .negativeInt(let v):
            return Int(-1 - Int64(v))
        case .utf8String(let s):
            return s
        case .boolean(let b):
            return b
        case .null:
            return NSNull()
        case .array(let arr):
            return arr.map { $0.convertCBORToFlutter() }
        case .map(let map):
            var dict: [String: Any] = [:]
            for (k, v) in map {
                if case let .utf8String(key) = k {
                    dict[key] = v.convertCBORToFlutter()
                }
            }
            return dict
        default:
            return "\(self)" // fallback jako string
        }
    }
}
