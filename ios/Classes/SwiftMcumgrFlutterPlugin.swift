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
        let channel = FlutterMethodChannel(name: namespace + "/method_channel", binaryMessenger: registrar.messenger())
        
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
            case .pause:
                try pause(call: call)
                result(nil)
            case .resume:
                try resume(call: call)
                result(nil)
            case .isPaused:
                result(try isPaused(call: call))
            case .isInProgress:
                result(try isInProgress(call: call))
            case .cancel:
                try cancel(call: call)
                result(nil)
            case .kill:
                try kill(call: call)
                result(nil)
                
            }
        } catch let e {
            if e is FlutterError {
                result(e)
            } else {
                result(FlutterError(error: e, call: call))
            }
        }
        
    }
    
    private func initializeUpdateManager(call: FlutterMethodCall) throws {
        guard let uuidString = call.arguments as? String, let uuid = UUID(uuidString: uuidString) else {
            throw FlutterError(code: ErrorCode.wrongArguments.rawValue, message: "Can not create UUID from provided arguments", details: call)
        }
        
        guard let peripheral = centralManager.retrievePeripherals(withIdentifiers: [uuid]).first else {
            throw FlutterError(code: ErrorCode.wrongArguments.rawValue, message: "Can't retrieve peripheral with provided UUID", details: call)
        }
        
        guard case .none = updateManagers[uuidString] else {
            throw FlutterError(code: ErrorCode.updateManagerExists.rawValue, message: "Updated manager for provided peripheral already exists", details: call)
        }
    }
    
    private func retrieveManager(call: FlutterMethodCall) throws -> UpdateManager {
        guard let uuid = call.arguments as? String else {
            throw FlutterError(code: ErrorCode.wrongArguments.rawValue, message: "Can't retrieve UUID of the device", details: call)
        }

        guard let manager = updateManagers[uuid] else {
            throw FlutterError(code: ErrorCode.updateManagerDoesNotExist.rawValue, message: "Update manager does not exist", details: call)
        }

        return manager;
    }

    private func pause(call: FlutterMethodCall) throws {
        try retrieveManager(call: call).pause()
    }

    private func resume(call: FlutterMethodCall) throws {
        try retrieveManager(call: call).resume()
    }

    private func isPaused(call: FlutterMethodCall) throws -> Bool {
        try retrieveManager(call: call).dfuManager.isPaused()
    }

    private func isInProgress(call: FlutterMethodCall) throws -> Bool {
        try retrieveManager(call: call).dfuManager.isInProgress()
    }
    
    private func cancel(call: FlutterMethodCall) throws {
        try retrieveManager(call: call).cancel()
    }
    
    private func update(call: FlutterMethodCall) throws {
        guard let data = call.arguments as? FlutterStandardTypedData else {
            throw FlutterError(code: ErrorCode.wrongArguments.rawValue, message: "Can not parse provided arguments", details: call)
        }
        
        let args = try ProtoUpdateWithImageCallArguments(serializedData: data.data)
        guard let manager = updateManagers[args.deviceUuid] else {
            throw FlutterError(code: ErrorCode.updateManagerDoesNotExist.rawValue, message: "Update manager does not exist", details: call)
        }
        
        let images = args.images.map { (Int($0.key), $0.value) }
        try manager.update(images: images)
    }
    
    private func kill(call: FlutterMethodCall) throws {
        let uuid = try retrieveManager(call: call).peripheral.identifier.uuidString
        updateManagers.removeValue(forKey: uuid)
    }
}
