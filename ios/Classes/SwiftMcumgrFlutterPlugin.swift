import Flutter
import UIKit
import CoreBluetooth

public class SwiftMcumgrFlutterPlugin: NSObject, FlutterPlugin {
    private var updateManagers: [String : UpdateManager] = [:]
    private let centralManager = CBCentralManager()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "mcumgr_flutter", binaryMessenger: registrar.messenger())
        let instance = SwiftMcumgrFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        guard let method = FlutterMethod(rawValue: call.method) else {
            let error = FlutterMethodNotImplemented
            result(error)
            return
        }
        
        do {
            switch method {
            case .update:
                try update(call: call)
                result(nil)
            case .initializeUpdateManager:
                try initializeUpdateManager(call: call)
                result(nil)
            }
        } catch let e {
            if e is FlutterError {
                result(e)
            } else {
                result(FlutterError(error: e, call: call))
            }
        }
        
        result("iOS " + UIDevice.current.systemVersion)
    }
    
    private func initializeUpdateManager(call: FlutterMethodCall) throws {
        guard let uuidString = call.arguments as? String, let uuid = UUID(uuidString: uuidString) else {
            throw FlutterError(code: ErrorCode.wrongArguments.rawValue, message: "Can not create UUID from provided arguments", details: call)
        }
        
        guard let peripheral = centralManager.retrievePeripherals(withIdentifiers: [uuid]).first else {
            throw FlutterError(code: ErrorCode.wrongArguments.rawValue, message: "Can't retreive preipheral with provided UUID", details: call)
        }
        
        guard case .none = updateManagers[uuidString] else {
            throw FlutterError(code: ErrorCode.updateManagerExists.rawValue, message: "Updated manager for provided peripheral already exists", details: call)
        }
        
        let um = UpdateManager(peripheral: peripheral)
        updateManagers[uuidString] = um
    }
    
    private func update(call: FlutterMethodCall) throws {
        guard let data = call.arguments as? FlutterStandardTypedData else {
            throw FlutterError(code: ErrorCode.wrongArguments.rawValue, message: "Can not parse provided arguments", details: call)
        }
        
        let args = try UpdateCallArgument(serializedData: data.data)
        
        guard let manager = updateManagers[args.deviceUuid] else {
            throw FlutterError(code: ErrorCode.updateManagerExists.rawValue, message: "Update manager does not exist", details: call)
        }
        
        try manager.update(data: args.firmwareData)
    }
}
