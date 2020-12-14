import Flutter
import UIKit
import CoreBluetooth

public class SwiftMcumgrFlutterPlugin: NSObject, FlutterPlugin {
    static let namespace = "mcumgr_flutter"
    
    private var updateManagers: [String : UpdateManager] = [:]
    private let centralManager = CBCentralManager()
    
    private let updateStateEventChannel: FlutterEventChannel
    private let updateProgressEventChannel: FlutterEventChannel
    private let logEventChannel: FlutterEventChannel
    
    private let updateStateStreamHandler = StreamHandler()
    private let updateProgressStreamHandler = StreamHandler()
    private let logStreamHandler = StreamHandler()
    
    public init(updateStateEventChannel: FlutterEventChannel, updateProgressEventChannel: FlutterEventChannel, logEventChannel: FlutterEventChannel) {
        self.updateStateEventChannel = updateStateEventChannel
        self.updateProgressEventChannel = updateProgressEventChannel
        self.logEventChannel = logEventChannel
        
        super.init()
        
        updateStateEventChannel.setStreamHandler(updateStateStreamHandler)
        updateProgressEventChannel.setStreamHandler(updateProgressStreamHandler)
        logEventChannel.setStreamHandler(logStreamHandler)
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: namespace + "/method_chonnel", binaryMessenger: registrar.messenger())
        
        let updateStateEventChannel = FlutterEventChannel(name: namespace + "/update_state_event_channel", binaryMessenger: registrar.messenger())
        let updateProgressEventChannel = FlutterEventChannel(name: namespace + "/update_progress_event_channel", binaryMessenger: registrar.messenger())
        let logEventChannel = FlutterEventChannel(name: namespace + "/log_event_channel", binaryMessenger: registrar.messenger())
        
        let instance = SwiftMcumgrFlutterPlugin(updateStateEventChannel: updateStateEventChannel, updateProgressEventChannel: updateProgressEventChannel, logEventChannel: logEventChannel)
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
        
        let um = UpdateManager(peripheral: peripheral, progressStreamHandler: updateProgressStreamHandler, stateStreamHandler: updateStateStreamHandler, logStreamhandler: logStreamHandler)
        updateManagers[uuidString] = um
    }
    
    private func update(call: FlutterMethodCall) throws {
        guard let data = call.arguments as? FlutterStandardTypedData else {
            throw FlutterError(code: ErrorCode.wrongArguments.rawValue, message: "Can not parse provided arguments", details: call)
        }
        
        let args = try ProtoUpdateCallArgument(serializedData: data.data)
        
        guard let manager = updateManagers[args.deviceUuid] else {
            throw FlutterError(code: ErrorCode.updateManagerExists.rawValue, message: "Update manager does not exist", details: call)
        }
        
        try manager.update(data: args.firmwareData)
    }
}
