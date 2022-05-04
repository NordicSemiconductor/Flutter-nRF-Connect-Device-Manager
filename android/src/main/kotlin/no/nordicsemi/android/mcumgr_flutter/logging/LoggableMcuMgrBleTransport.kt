package no.nordicsemi.android.mcumgr_flutter.logging

import android.bluetooth.BluetoothDevice
import android.content.Context
import android.os.Handler
import android.os.Looper
import io.flutter.Log
import io.runtime.mcumgr.ble.McuMgrBleTransport
import no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu
import no.nordicsemi.android.mcumgr_flutter.utils.StreamHandler

class LoggableMcuMgrBleTransport(
	context: Context,
	device: BluetoothDevice,
	private val logStreamHandler: StreamHandler
): McuMgrBleTransport(context, device) {
	private val handler: Handler = Handler(Looper.getMainLooper())

	private var allMessages: MutableList<FlutterMcu.ProtoLogMessage> = mutableListOf()

	override fun log(priority: Int, message: String) {
		if (Build.DEBUG)
			Log.d("McuManager", message)

		// Supported since mcumgr-android 0.12.0:
		val applicationLevel = message.startsWith("Sending") || message.startsWith("Received")

		fun Int.toLogLevel(): FlutterMcu.ProtoLogMessage.LogLevel =
			if (applicationLevel) FlutterMcu.ProtoLogMessage.LogLevel.APPLICATION
			else when (this) {
				android.util.Log.VERBOSE -> FlutterMcu.ProtoLogMessage.LogLevel.VERBOSE
				android.util.Log.DEBUG -> FlutterMcu.ProtoLogMessage.LogLevel.DEBUG
				android.util.Log.INFO -> FlutterMcu.ProtoLogMessage.LogLevel.INFO
				android.util.Log.WARN -> FlutterMcu.ProtoLogMessage.LogLevel.WARNING
				else -> FlutterMcu.ProtoLogMessage.LogLevel.ERROR
			}

		val log = FlutterMcu.ProtoLogMessage
			.newBuilder()
			.setLogCategory(FlutterMcu.ProtoLogMessage.LogCategory.DFU)
			.setLogLevel(priority.toLogLevel())
			.setLogDateTime(System.currentTimeMillis())
			.setMessage(message)
			.build()

		allMessages.add(log)
	}

	fun readLogs(): FlutterMcu.ProtoLogMessageStreamArg {

//		handler.post { logStreamHandler.sink?.success(arg.toByteArray()) }

		return FlutterMcu.ProtoLogMessageStreamArg
			.newBuilder()
			.setUuid(bluetoothDevice.address)
			.addAllProtoLogMessage(allMessages)
			.build()
	}
}
