package no.nordicsemi.android.mcumgr_flutter

import android.bluetooth.BluetoothAdapter
import android.content.Context
import android.util.Pair
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import no.nordicsemi.android.mcumgr_flutter.logging.LoggableMcuMgrBleTransport
import no.nordicsemi.android.mcumgr_flutter.utils.*
import no.nordicsemi.android.mcumgr_flutter.gen.*

/** McumgrFlutterPlugin */
class McumgrFlutterPlugin : FlutterPlugin, MethodCallHandler {
	private val namespace = "mcumgr_flutter"

	/// The MethodChannel that will the communication between Flutter and native Android
	///
	/// This local reference serves to register the plugin with the Flutter Engine and unregister it
	/// when the Flutter Engine is detached from the Activity
	private lateinit var methodChannel: MethodChannel

	private lateinit var updateStateEventChannel: EventChannel
	private lateinit var updateProgressEventChannel: EventChannel
	private lateinit var logEventChannel: EventChannel

	private var updateStateStreamHandler = StreamHandler()
	private var updateProgressStreamHandler = StreamHandler()
	private var logStreamHandler = StreamHandler()

	private lateinit var context: Context

	private var managers: MutableMap<String, UpdateManager> = mutableMapOf()

	override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
		context = flutterPluginBinding.applicationContext

		methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "$namespace/method_channel")
		methodChannel.setMethodCallHandler(this)

		updateStateEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "$namespace/update_state_event_channel")
		updateStateEventChannel.setStreamHandler(updateStateStreamHandler)
		updateProgressEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "$namespace/update_progress_event_channel")
		updateProgressEventChannel.setStreamHandler(updateProgressStreamHandler)
		logEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "$namespace/log_event_channel")
		logEventChannel.setStreamHandler(logStreamHandler)
	}

	override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
		methodChannel.setMethodCallHandler(null)
	}

	override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
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
				FlutterMethod.getAllLogs -> {
					result.success(retrieveManager(call).readAllLogs().encode())
				}
				FlutterMethod.kill -> {
					kill(call)
					result.success(null)
				}
			}
		} catch (e: FlutterError) {
			result.error(e.code, e.message, null)
		}
	}

	@Throws(FlutterError::class)
	private fun initializeUpdateManager(@NonNull call: MethodCall) {
		val address = (call.arguments as? String).guard {
			throw WrongArguments("Device address expected")
		}
		if (managers.containsKey(address)) {
			throw UpdateManagerExists("Updated manager for provided peripheral already exists")
		}
		val device = BluetoothAdapter.getDefaultAdapter().getRemoteDevice(address)
		val transport = LoggableMcuMgrBleTransport(context, device , logStreamHandler)
		val updateManager = UpdateManager(transport,
			updateStateStreamHandler,
			updateProgressStreamHandler,
			logStreamHandler)

		managers[address] = updateManager
	}

	@Throws(FlutterError::class)
	private fun update(@NonNull call: MethodCall) {
		val bytes = (call.arguments as? ByteArray).guard {
			throw WrongArguments("Can not parse provided arguments: ${call.arguments.javaClass}")
		}
		val arg = ProtoUpdateWithImageCallArguments.ADAPTER.decode(bytes)
		val updateManager = managers[arg.device_uuid].guard {
			throw UpdateManagerDoesNotExist("Update manager does not exist")
		}

		val config = arg.configuration?.let {
			return@let FirmwareUpgradeConfiguration(
				it.estimatedSwapTimeMs ?: 0,
				it.eraseAppSettings ?: true,
				(it.pipelineDepth ?: 1).toInt(),
				when (it.byteAlignment) {
					ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment.TWO_BYTE -> 2
					ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment.FOUR_BYTE -> 4
					ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment.EIGHT_BYTE -> 8
					ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment.SIXTEEN_BYTE -> 16
					ProtoFirmwareUpgradeConfiguration.ImageUploadAlignment.DISABLED -> 0
					else -> 4
				},
				it.reassemblyBufferSize ?: 0
			)
		}

		updateManager.start(arg.images.map { Pair.create(it.key, it.value_.toByteArray()) }, config)
	}

	@Throws(FlutterError::class)
	private fun retrieveManager(@NonNull call: MethodCall): UpdateManager {
		val address = (call.arguments as? String).guard {
			throw WrongArguments("Device address expected")
		}
		return managers[address].guard {
			throw UpdateManagerDoesNotExist("Update manager does not exist")
		}
	}

	private fun kill(@NonNull call: MethodCall) {
		val address = (call.arguments as? String).guard {
			throw WrongArguments("Device Address expected")
		}
		managers.remove(address)
	}
}
