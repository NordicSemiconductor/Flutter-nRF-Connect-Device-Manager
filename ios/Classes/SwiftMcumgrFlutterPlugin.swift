import Flutter
import UIKit
import CoreBluetooth
import iOSMcuManagerLibrary

public class SwiftMcumgrFlutterPlugin: NSObject, FlutterPlugin {
    static let namespace = "mcumgr_flutter"
    
    private var updateManagers: [String : UpdateManager] = [:]
    private let centralManager = CBCentralManager()
    
    private let updateStateEventChannel: FlutterEventChannel
    private let updateProgressEventChannel: FlutterEventChannel
    
    // Log channels
    private let logEventChannel: FlutterEventChannel
//    private let liveLogEnabled: FlutterEventChannel
    
    private let updateStateStreamHandler = StreamHandler()
    private let updateProgressStreamHandler = StreamHandler()
    private let logStreamHandler = StreamHandler()
    private let liveLogStreamHandler = StreamHandler()
    
    public init(
        updateStateEventChannel: FlutterEventChannel, 
        updateProgressEventChannel: FlutterEventChannel, 
        logEventChannel: FlutterEventChannel
    // liveLogEnabled: FlutterEventChannel
    ) {
        self.updateStateEventChannel = updateStateEventChannel
        self.updateProgressEventChannel = updateProgressEventChannel
        self.logEventChannel = logEventChannel
        // self.liveLogEnabled = liveLogEnabled
        
        super.init()
        
        updateStateEventChannel.setStreamHandler(updateStateStreamHandler)
        updateProgressEventChannel.setStreamHandler(updateProgressStreamHandler)
        logEventChannel.setStreamHandler(logStreamHandler)
//        liveLogEnabled.setStreamHandler(liveLogStreamHandler)
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: namespace + "/method_channel", binaryMessenger: registrar.messenger())
        
        let updateStateEventChannel = FlutterEventChannel(channel: .updateStateEventChannel, binaryMessenger: registrar.messenger())
        let updateProgressEventChannel = FlutterEventChannel(channel: .updateProgressEventChannel, binaryMessenger: registrar.messenger())
        let logEventChannel = FlutterEventChannel(channel: .logEventChannel, binaryMessenger: registrar.messenger())
        // TBD: It will be implemented in the future
        // let liveLogEnabled = FlutterEventChannel(channel: .liveLogEnabledChannel, binaryMessenger: registrar.messenger())
        
        let instance = SwiftMcumgrFlutterPlugin(
            updateStateEventChannel: updateStateEventChannel,
            updateProgressEventChannel: updateProgressEventChannel,
            logEventChannel: logEventChannel
            // liveLogEnabled: liveLogEnabled
            )
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
            case .toggleLiveLoggs:
                let m = try retrieveManager(call: call)
                result(m.updateLogger.toggleLiveLoggs())
            case .setLiveLoggsEnabled:
                try setLiveLoggEnabled(call: call)
                result(nil)
            case .readLogs:
                result(try readLogs(call: call))
            case .clearLogs:
                try retrieveManager(call: call).updateLogger.clearLogs()
                result(nil)
            case .getAllLogs:
                let arg = try retrieveManager(call: call).updateLogger.getAllLogs()
                let data = FlutterStandardTypedData(bytes: try arg.serializedData())
                result(data)
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
        
        let logger = UpdateLogger(identifier: uuidString, streamHandler: logStreamHandler, liveLogEnabledStreamHandler: liveLogStreamHandler)
        let updateManager = UpdateManager(peripheral: peripheral, progressStreamHandler: updateProgressStreamHandler, stateStreamHandler: updateStateStreamHandler, updateLogger: logger)
        updateManagers[uuidString] = updateManager
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
    
    private func setLiveLoggEnabled(call: FlutterMethodCall) throws {
        guard let data = call.arguments as? FlutterStandardTypedData else {
            throw FlutterError(code: ErrorCode.wrongArguments.rawValue, message: "Can not parse provided arguments", details: call)
        }
        
        let args = try ProtoMessageLiveLogEnabled(serializedData: data.data)
        updateManagers[args.uuid]?.updateLogger.liveUpdateEnabled = args.enabled
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
        let config = args.hasConfiguration ? FirmwareUpgradeConfiguration(proto: args.configuration) : FirmwareUpgradeConfiguration()
        
        try manager.update(images: images, config: config)
    }
    
    private func kill(call: FlutterMethodCall) throws {
        let uuid = try retrieveManager(call: call).peripheral.identifier.uuidString
        updateManagers.removeValue(forKey: uuid)
    }
    
    // MARK: Logs
    private func readLogs(call: FlutterMethodCall) throws -> ProtoLogMessageStreamArg {
        let um = try retrieveManager(call: call)
        return um.updateLogger.readLogs()
    }
}
