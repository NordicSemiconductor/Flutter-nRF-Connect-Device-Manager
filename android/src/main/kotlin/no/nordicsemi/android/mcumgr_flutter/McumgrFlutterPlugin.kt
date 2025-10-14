package no.nordicsemi.android.mcumgr_flutter

import android.bluetooth.BluetoothManager
import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Pair
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.runtime.mcumgr.McuMgrCallback
import io.runtime.mcumgr.dfu.mcuboot.FirmwareUpgradeManager
import io.runtime.mcumgr.exception.McuMgrException
import io.runtime.mcumgr.response.img.McuMgrImageStateResponse
import no.nordicsemi.android.mcumgr_flutter.ext.toProto
import no.nordicsemi.android.mcumgr_flutter.gen.ProtoFirmwareUpgradeConfiguration
import no.nordicsemi.android.mcumgr_flutter.gen.ProtoListImagesResponse
import no.nordicsemi.android.mcumgr_flutter.gen.ProtoReadLogCallArguments
import no.nordicsemi.android.mcumgr_flutter.gen.ProtoUpdateCallArgument
import no.nordicsemi.android.mcumgr_flutter.gen.ProtoUpdateWithImageCallArguments
import no.nordicsemi.android.mcumgr_flutter.logging.LoggableMcuMgrBleTransport
import no.nordicsemi.android.mcumgr_flutter.manager.FirmwareUpgradeConfiguration
import no.nordicsemi.android.mcumgr_flutter.manager.SettingsManager
import no.nordicsemi.android.mcumgr_flutter.manager.UpdateManager
import no.nordicsemi.android.mcumgr_flutter.utils.FlutterError
import no.nordicsemi.android.mcumgr_flutter.utils.FlutterMethod
import no.nordicsemi.android.mcumgr_flutter.utils.StreamHandler
import no.nordicsemi.android.mcumgr_flutter.utils.UpdateManagerDoesNotExist
import no.nordicsemi.android.mcumgr_flutter.utils.UpdateManagerExists
import no.nordicsemi.android.mcumgr_flutter.utils.WrongArguments
import no.nordicsemi.android.mcumgr_flutter.utils.guard

private const val settingsManagerErrorCode = "MCU_MGR_SETTINGS_MANAGER"

/** McumgrFlutterPlugin */
class McumgrFlutterPlugin : FlutterPlugin, MethodCallHandler {
	private val namespace = "mcumgr_flutter"

	/// The MethodChannel that will the communication between Flutter and native Android
	///
	/// This local reference serves to register the plugin with the Flutter Engine and unregister it
	/// when the Flutter Engine is detached from the Activity
	private lateinit var methodChannel: MethodChannel

	private lateinit var mainHandler: Handler

	private lateinit var updateStateEventChannel: EventChannel
	private lateinit var updateProgressEventChannel: EventChannel
	private lateinit var logEventChannel: EventChannel

	private var updateStateStreamHandler = StreamHandler()
	private var updateProgressStreamHandler = StreamHandler()
	private var logStreamHandler = StreamHandler()

	private lateinit var context: Context

	private var managers: MutableMap<String, UpdateManager> = mutableMapOf()
	private lateinit var fsManagerPlugin: FsManagerPlugin

	private lateinit var settingsManager: SettingsManager

	override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
		context = flutterPluginBinding.applicationContext
		mainHandler = Handler(Looper.getMainLooper())

		methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "$namespace/method_channel")
		methodChannel.setMethodCallHandler(this)

		updateStateEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "$namespace/update_state_event_channel")
		updateStateEventChannel.setStreamHandler(updateStateStreamHandler)
		updateProgressEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "$namespace/update_progress_event_channel")
		updateProgressEventChannel.setStreamHandler(updateProgressStreamHandler)
		logEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "$namespace/log_event_channel")
		logEventChannel.setStreamHandler(logStreamHandler)

		fsManagerPlugin = FsManagerPlugin(
			context,
			logStreamHandler,
			flutterPluginBinding.binaryMessenger,
			mainHandler
		)
	}

	override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
		methodChannel.setMethodCallHandler(null)
	}

	override fun onMethodCall(call: MethodCall, result: Result) {
		val method = FlutterMethod.valueOfOrNull(call.method).guard {
			result.notImplemented()
			return
		}
		try {
			when (method) {
				FlutterMethod.initializeUpdateManager -> {
					initializeUpdateManager(call)
					result.success(null)
				}

				FlutterMethod.update -> {
					update(call)
					result.success(null)
				}

				FlutterMethod.updateSingleImage -> {
					updateSingleImage(call)
					result.success(null)
				}

				FlutterMethod.pause -> {
					retrieveManager(call).pause()
					result.success(null)
				}

				FlutterMethod.resume -> {
					retrieveManager(call).resume()
					result.success(null)
				}

				FlutterMethod.cancel -> {
					retrieveManager(call).cancel()
					result.success(null)
				}

				FlutterMethod.isPaused -> {
					val isPaused = retrieveManager(call).isPaused
					result.success(isPaused)
				}

				FlutterMethod.isInProgress -> {
					val isPaused = retrieveManager(call).isInProgress
					result.success(isPaused)
				}

				FlutterMethod.readLogs -> {
					result.success(readLogs(call))
				}

				FlutterMethod.clearLogs -> {
					retrieveManager(call).clearLogs()
					result.success(null)
				}

				FlutterMethod.kill -> {
					kill(call)
					result.success(null)
				}

				FlutterMethod.readImageList -> {
					imageList(call, result)
				}

				FlutterMethod.initSettings -> {
					initSettingsManager(call, result)
				}
				FlutterMethod.fetchSettings -> {

					if (::settingsManager.isInitialized) {
						settingsManager.fetchSettings(result)
					} else {
						return result.error(settingsManagerErrorCode, "Settings manager is not initialized", null)
					}
				}
				FlutterMethod.readSetting -> {
					if (::settingsManager.isInitialized) {
						val key = call.arguments as? String
							?: return result.error(settingsManagerErrorCode, "BAD_ARGS", "Expected key")
						settingsManager.readSettings(key, result)

					} else {
						return result.error(
                            settingsManagerErrorCode,
							"Settings manager is not initialized",
							null
						)
					}
				}

				FlutterMethod.writeSetting -> {
					if (::settingsManager.isInitialized) {
						val args = call.arguments as? Map<*, *>
							?: return result.error(settingsManagerErrorCode, "BAD_ARGS", "Expected key-value map")
						val key = args["key"] as? String
							?: return result.error(settingsManagerErrorCode, "BAD_ARGS", "Expected key in map")
						val value = args["value"]
							?: return result.error(settingsManagerErrorCode, "BAD_ARGS", "Expected value in map")
						settingsManager.writeSetting(key, value, result)

					} else {
						return result.error(
                            settingsManagerErrorCode,
							"Settings manager is not initialized",
							null
						)
					}
				}

			}
		} catch (e: FlutterError) {
			result.error(e.code, e.message, null)
		}
	}

	@Throws(FlutterError::class)
	private fun initializeUpdateManager(call: MethodCall) {
		val address = (call.arguments as? String).guard {
			throw WrongArguments("Device address expected")
		}
		if (managers.containsKey(address)) {
			throw UpdateManagerExists("Updated manager for provided peripheral already exists")
		}
		val bluetoothManager = context.getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager

		val device = bluetoothManager.adapter.getRemoteDevice(address)
		val transport = LoggableMcuMgrBleTransport(context, device , logStreamHandler)
		val updateManager = UpdateManager(
			transport,
			updateStateStreamHandler,
			updateProgressStreamHandler,
			logStreamHandler
		)

		managers[address] = updateManager
	}

	@Throws(FlutterError::class)
	private fun initSettingsManager(call: MethodCall, result: Result) {
		val args = (call.arguments as? Map<*, *>).guard {
			result.error(settingsManagerErrorCode, "WrongArguments", "Expected map with deviceAddress, padTo4Bytes, and encodeValueToCBOR")
			throw WrongArguments("Expected map with deviceAddress, padTo4Bytes, and encodeValueToCBOR")
		}

		val address = (args["deviceAddress"] as? String).guard {
			result.error(settingsManagerErrorCode, "WrongArguments", "Device address expected in map")
			throw WrongArguments("Device address expected in map")
		}

		val padTo4Bytes = args["padTo4Bytes"] as? Boolean ?: false
		val encodeValueToCBOR = args["encodeValueToCBOR"] as? Boolean ?: false
		val precisionMode = args["precisionMode"] as? String ?: "auto"

		val bluetoothManager = context.getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager

		val device = bluetoothManager.adapter.getRemoteDevice(address)
		val transport = LoggableMcuMgrBleTransport(context, device, logStreamHandler)
		settingsManager = SettingsManager(transport, padTo4Bytes, encodeValueToCBOR, precisionMode)

		transport.connect(device)
			.done {
				transport.setLoggingEnabled(true)
				settingsManager = SettingsManager(transport, padTo4Bytes, encodeValueToCBOR)
				result.success(null)
			}
			.fail { _, errorCode ->
				result.error(settingsManagerErrorCode, "CONNECT_FAILED", "Could not connect to device, code=$errorCode")
			}
			.enqueue()


	}

	@Throws(FlutterError::class)
	private fun update(call: MethodCall) {
		val bytes = (call.arguments as? ByteArray).guard {
			throw WrongArguments("Can not parse provided arguments: ${call.arguments.javaClass}")
		}
		val arg = ProtoUpdateWithImageCallArguments.ADAPTER.decode(bytes)
		val updateManager = managers[arg.device_uuid].guard {
			throw UpdateManagerDoesNotExist("Update manager does not exist")
		}

		val config = arg.configuration?.let { config ->
			return@let FirmwareUpgradeConfiguration(
				config.estimatedSwapTimeMs,
				config.eraseAppSettings,
				config.pipelineDepth.toInt(),
				when (config.byteAlignment) {
					ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment.TWO_BYTE -> 2
					ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment.FOUR_BYTE -> 4
					ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment.EIGHT_BYTE -> 8
					ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment.SIXTEEN_BYTE -> 16
					ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment.DISABLED -> 0
				},
				config.reassemblyBufferSize,
				when (config.firmwareUpgradeMode) {
					ProtoFirmwareUpgradeConfiguration.FirmwareUpgradeMode.TEST_ONLY -> FirmwareUpgradeManager.Mode.TEST_ONLY
					ProtoFirmwareUpgradeConfiguration.FirmwareUpgradeMode.TEST_AND_CONFIRM -> FirmwareUpgradeManager.Mode.TEST_AND_CONFIRM
					ProtoFirmwareUpgradeConfiguration.FirmwareUpgradeMode.CONFIRM_ONLY -> FirmwareUpgradeManager.Mode.CONFIRM_ONLY
					ProtoFirmwareUpgradeConfiguration.FirmwareUpgradeMode.UPLOAD_ONLY -> FirmwareUpgradeManager.Mode.NONE
				}
			)
		}

		val images = arg.images.map { Pair.create(it.image, it.data_.toByteArray()) }
		updateManager.start(images, config)
	}

	@Throws(FlutterError::class)
	private fun updateSingleImage(call: MethodCall) {
		val bytes = (call.arguments as? ByteArray).guard {
			throw WrongArguments("Can not parse provided arguments: ${call.arguments.javaClass}")
		}
		val args = ProtoUpdateCallArgument.ADAPTER.decode(bytes)
		val updateManager = managers[args.device_uuid].guard {
			throw UpdateManagerDoesNotExist("Update manager does not exist")
		}
		val imageData = args.firmware_data.toByteArray()

		val config = args.configuration?.let { config ->
			return@let FirmwareUpgradeConfiguration(
				config.estimatedSwapTimeMs,
				config.eraseAppSettings,
				config.pipelineDepth.toInt(),
				when (config.byteAlignment) {
					ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment.TWO_BYTE -> 2
					ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment.FOUR_BYTE -> 4
					ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment.EIGHT_BYTE -> 8
					ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment.SIXTEEN_BYTE -> 16
					ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment.DISABLED -> 0
				},
				config.reassemblyBufferSize,
				when (config.firmwareUpgradeMode) {
					ProtoFirmwareUpgradeConfiguration.FirmwareUpgradeMode.TEST_ONLY -> FirmwareUpgradeManager.Mode.TEST_ONLY
					ProtoFirmwareUpgradeConfiguration.FirmwareUpgradeMode.TEST_AND_CONFIRM -> FirmwareUpgradeManager.Mode.TEST_AND_CONFIRM
					ProtoFirmwareUpgradeConfiguration.FirmwareUpgradeMode.CONFIRM_ONLY -> FirmwareUpgradeManager.Mode.CONFIRM_ONLY
					ProtoFirmwareUpgradeConfiguration.FirmwareUpgradeMode.UPLOAD_ONLY -> FirmwareUpgradeManager.Mode.NONE
				}
			)
		}

		updateManager.start(imageData, config)
	}

	@Throws(FlutterError::class)
	private fun retrieveManager(call: MethodCall): UpdateManager {
		val address = (call.arguments as? String).guard {
			throw WrongArguments("Device address expected")
		}
		return managers[address].guard {
			throw UpdateManagerDoesNotExist("Update manager does not exist")
		}
	}

	@Throws(FlutterError::class)
	private fun readLogs(call: MethodCall): ByteArray {
		val data = (call.arguments as? ByteArray).guard {
			throw WrongArguments("Device address expected")
		}
		val arg = ProtoReadLogCallArguments.ADAPTER.decode(data)
		val address = arg.uuid
		val clearLogs = arg.clearLogs
		val updateManager = managers[address].guard {
			throw UpdateManagerDoesNotExist("Update manager does not exist")
		}

		return updateManager.readAllLogs(clearLogs).encode()
	}

	private fun kill(call: MethodCall) {
		val address = (call.arguments as? String).guard {
			throw WrongArguments("Device Address expected")
		}
		if (managers.containsKey(address)) {
			managers[address]!!.releaseTransport();
		}
		managers.remove(address)
	}

	/** Image Manager */
	private fun imageList(call: MethodCall, result: Result) {
		val address = (call.arguments as? String).guard {
			throw WrongArguments("Device address expected")
		}
		val updateManager = managers[address].guard {
			throw UpdateManagerDoesNotExist("Update manager does not exist")
		}

		val callback = object : McuMgrCallback<McuMgrImageStateResponse> {
			override fun onResponse(response: McuMgrImageStateResponse) {
				var protoResponse: ProtoListImagesResponse
				if (response.images != null) {
					val images = response.images.map { it.toProto() }
					protoResponse = ProtoListImagesResponse(
						uuid = address,
						images = images,
						existing = true
					)
				} else {
					protoResponse = ProtoListImagesResponse(
						uuid = address,
						existing = false
					)
				}
				result.success(protoResponse.encode())
			}

			override fun onError(exception: McuMgrException) {
				result.error("mcumgr_error", exception.message, null)
			}
		}

		updateManager.imageManager.list(callback)
	}
}
