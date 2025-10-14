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
    private let transport: McuMgrBleTransport
    private let mcuMgrSettingsManager: iOSMcuManagerLibrary.SettingsManager
    private let padTo4Bytes: Bool
    private let encodeValueToCBOR: Bool
    private let precisionMode: String
    private let logStreamHandler: StreamHandler?

    private static let errorCode = "MCU_MGR_SETTINGS_MANAGER"

    init(transport: McuMgrBleTransport, padTo4Bytes: Bool = false, encodeValueToCBOR: Bool = false, precisionMode: String = "auto", logStreamHandler: StreamHandler? = nil) {
        self.transport = transport
        self.mcuMgrSettingsManager = iOSMcuManagerLibrary.SettingsManager(transport: transport)
        self.padTo4Bytes = padTo4Bytes
        self.encodeValueToCBOR = encodeValueToCBOR
        self.precisionMode = precisionMode
        self.logStreamHandler = logStreamHandler
    }

    private func sendLogToDart(_ message: String) {
        guard let logStreamHandler = logStreamHandler else {
            return
        }

        guard let sink = logStreamHandler.sink else {
            return
        }

        do {
            let logMessage = "SETTINGS: \(message)"

            let protoLog = ProtoLogMessage(
                message: logMessage,
                category: .default,
                level: .info,
                timeInterval: Date().timeIntervalSince1970
            )

            let container = ProtoLogMessageStreamArg(uuid: transport.identifier.uuidString, msg: protoLog)
            let data = try container.serializedData()
            sink(FlutterStandardTypedData(bytes: data))
        } catch {
            print("Failed to send log to Dart: \(error.localizedDescription)")
        }
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
        mcuMgrSettingsManager.read(name: key) { [weak self] response, error in
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
                self?.sendLogToDart("Payload response: \(payload), type: \(flutterValue)")
                result(flutterValue)
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
                sendLogToDart("VARIABLE TYPE: \(value), type: \(type(of: value))")
                if let value = value as? String, padTo4Bytes {
                    valueBytes = try CBOR.encodeAny(padStringTo4Bytes(value))
                } else {
                    // Use CFGetTypeID to distinguish between true Boolean and Number types
                    let cfObject = value as CFTypeRef
                    let typeID = CFGetTypeID(cfObject)

                    if typeID == CFBooleanGetTypeID() {
                        let boolValue = value as! Bool
                        sendLogToDart("DETECTED: True Boolean - \(boolValue)")
                        valueBytes = CBOR.encodeBool(boolValue)
                    } else if typeID == CFNumberGetTypeID() {
                        let nsNumber = value as! NSNumber
                        let numberType = CFNumberGetType(nsNumber as CFNumber)

                        switch numberType {
                        case .floatType, .float32Type, .doubleType, .float64Type:
                            switch precisionMode {
                            case "forceFloat32":
                                let floatValue = nsNumber.floatValue
                                sendLogToDart("DETECTED: Forced Float32 - \(floatValue)")
                                valueBytes = try CBOR.encodeAny(floatValue)

                            case "forceDouble64":
                                let doubleValue = nsNumber.doubleValue
                                sendLogToDart("DETECTED: Forced Double64 - \(doubleValue)")
                                valueBytes = try CBOR.encodeAny(doubleValue)

                            default:
                                let floatValue = nsNumber.floatValue
                                let doubleValue = nsNumber.doubleValue

                                let canFitInFloat32 = floatValue.description == doubleValue.description &&
                                doubleValue >= -Double(Float.greatestFiniteMagnitude) && doubleValue <= Double(Float.greatestFiniteMagnitude)

                                if canFitInFloat32 {
                                    sendLogToDart("DETECTED: Auto Float32 - \(floatValue)")
                                    valueBytes = try CBOR.encodeAny(floatValue)
                                } else {
                                    sendLogToDart("DETECTED: Auto Double64 - \(doubleValue)")
                                    valueBytes = try CBOR.encodeAny(doubleValue)
                                }
                            }
                        default:
                            let intValue = nsNumber.intValue
                            sendLogToDart("DETECTED: Integer - \(intValue)")
                            valueBytes = try CBOR.encodeAny(intValue)
                        }
                    } else {
                        sendLogToDart("DETECTED: Other type - \(type(of: value)), value: \(value)")
                        valueBytes = try CBOR.encodeAny(value)
                    }
                }
            } else {
                valueBytes = try toBytes(value: value)
            }

            sendLogToDart("Key and value to write: \(key), value: \(valueBytes)")
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
        case .float(let f):
            return f
        case .double(let d):
            return d
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
            // If the dictionary only contains a "val" key, return just the value
            if dict.count == 1, let value = dict["val"] {
                return value
            }
            return dict
        default:
            return "\(self)"
        }
    }
}
