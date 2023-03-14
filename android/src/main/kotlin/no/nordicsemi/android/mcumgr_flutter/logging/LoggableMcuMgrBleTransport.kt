package no.nordicsemi.android.mcumgr_flutter.logging

import android.bluetooth.BluetoothDevice
import android.content.Context
import android.os.Handler
import android.os.Looper
import io.flutter.Log
import io.runtime.mcumgr.ble.McuMgrBleTransport
import no.nordicsemi.android.mcumgr_flutter.BuildConfig
import no.nordicsemi.android.mcumgr_flutter.gen.*
import no.nordicsemi.android.mcumgr_flutter.utils.StreamHandler

class LoggableMcuMgrBleTransport(
	context: Context,
	device: BluetoothDevice,
	private val logStreamHandler: StreamHandler
): McuMgrBleTransport(context, device) {
	private val handler: Handler = Handler(Looper.getMainLooper())

	private var allMessages: MutableList<ProtoLogMessage> = mutableListOf()

	fun log(message: String) {
		if (BuildConfig.DEBUG)
			Log.d("McuManager", message)
		val log = ProtoLogMessage(
			message = message,
			logCategory = ProtoLogMessage.LogCategory.DFU,
			logLevel = ProtoLogMessage.LogLevel.APPLICATION,
			logDateTime = System.currentTimeMillis(),
		)
		allMessages.add(log)
	}

	override fun log(priority: Int, message: String) {
		if (BuildConfig.DEBUG)
			Log.d("McuManager", message)

		// Supported since mcumgr-android 0.12.0:
		val applicationLevel = message.startsWith("Sending") || message.startsWith("Received")

		fun Int.toLogLevel(): ProtoLogMessage.LogLevel =
			if (applicationLevel) ProtoLogMessage.LogLevel.APPLICATION
			else when (this) {
				android.util.Log.VERBOSE -> ProtoLogMessage.LogLevel.VERBOSE
				android.util.Log.DEBUG -> ProtoLogMessage.LogLevel.DEBUG
				android.util.Log.INFO -> ProtoLogMessage.LogLevel.INFO
				android.util.Log.WARN -> ProtoLogMessage.LogLevel.WARNING
				else -> ProtoLogMessage.LogLevel.ERROR
			}

		val log = ProtoLogMessage(
			message = message,
			logCategory = ProtoLogMessage.LogCategory.DFU,
			logLevel = priority.toLogLevel(),
			logDateTime = System.currentTimeMillis(),
		)
		allMessages.add(log)
	}

	fun readLogs(): ProtoLogMessageStreamArg {

//		handler.post { logStreamHandler.sink?.success(arg.toByteArray()) }

		return ProtoLogMessageStreamArg(
			uuid = bluetoothDevice.address,
			protoLogMessage = allMessages
		)
	}
}
