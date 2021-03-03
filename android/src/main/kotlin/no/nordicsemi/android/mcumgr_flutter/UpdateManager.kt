package no.nordicsemi.android.mcumgr_flutter

import io.runtime.mcumgr.ble.McuMgrBleTransport
import io.runtime.mcumgr.dfu.FirmwareUpgradeCallback
import io.runtime.mcumgr.dfu.FirmwareUpgradeController
import io.runtime.mcumgr.dfu.FirmwareUpgradeManager
import io.runtime.mcumgr.exception.McuMgrException
import no.nordicsemi.android.mcumgr_flutter.ext.toProto
import no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu
import no.nordicsemi.android.mcumgr_flutter.utils.StreamHandler

class UpdateManager(
		transport: McuMgrBleTransport,
		private val updateStateStreamHandler: StreamHandler,
		private val updateProgressStreamHandler: StreamHandler,
		private val logStreamHandler: StreamHandler,
): FirmwareUpgradeCallback {
	private val manager: FirmwareUpgradeManager
	private val address: String

	init {
		transport.setLoggingEnabled(true)
		address = transport.bluetoothDevice.address
		manager = FirmwareUpgradeManager(transport, this)
	}

	/**
	 * Start the upgrade.
	 *
	 * The specified image file will be sent to the target using the
	 * given transport, then verified using test command. If test successful, the reset
	 * command will be sent. The device should boot with the new firmware.
	 * The manager will try to connect to the SMP server on the new firmware and confirm
	 * the upload.
	 *
	 * @param firmware The firmware to be sent.
	 */
	fun start(firmware: ByteArray) = manager.start(firmware)
	/** Pause the firmware upgrade. */
	fun pause() = manager.pause()
	/** Resume a paused firmware upgrade. */
	fun resume() = manager.resume()
	/** Cancel the transfer. */
	fun cancel() = manager.cancel()
	/** True if the firmware upgrade is paused, false otherwise. */
	var isPaused = manager.isPaused
	/**	True if the firmware upgrade is in progress, false otherwise. */
	var isInProgress = manager.isInProgress

	override fun onUpgradeStarted(controller: FirmwareUpgradeController?) {
	}

	override fun onStateChanged(prevState: FirmwareUpgradeManager.State?, newState: FirmwareUpgradeManager.State?) {
		val changes = FlutterMcu.ProtoUpdateStateChanges
				.newBuilder()
				.setOldState(prevState!!.toProto())
				.setNewState(newState!!.toProto())
				.build()
		val stateChangesArg = FlutterMcu.ProtoUpdateStateChangesStreamArg
				.newBuilder()
				.setUuid(address)
				.setUpdateStateChanges(changes)
				.build()
		updateStateStreamHandler.sink?.success(stateChangesArg.toByteArray())
	}

	override fun onUpgradeCompleted() {
		val stateChangesArg = FlutterMcu.ProtoUpdateStateChangesStreamArg
				.newBuilder()
				.setUuid(address)
				.setDone(true)
				.build()
		updateStateStreamHandler.sink?.success(stateChangesArg.toByteArray())

		val progressArg = FlutterMcu.ProtoProgressUpdateStreamArg
				.newBuilder()
				.setUuid(address)
				.setDone(true)
				.build()
		updateProgressStreamHandler.sink?.success(progressArg.toByteArray())

		val logArg = FlutterMcu.ProtoLogMessageStreamArg
				.newBuilder()
				.setUuid(address)
				.setDone(true)
				.build()
		logStreamHandler.sink?.success(logArg.toByteArray())
	}

	override fun onUpgradeFailed(state: FirmwareUpgradeManager.State?, error: McuMgrException?) {
		val changes = FlutterMcu.ProtoUpdateStateChanges
				.newBuilder()
				.setOldState(state!!.toProto())
				.setNewState(state.toProto())
				.build()
		val stateChangesArg = FlutterMcu.ProtoUpdateStateChangesStreamArg
				.newBuilder()
				.setUuid(address)
				.setUpdateStateChanges(changes)
				.setError(FlutterMcu.ProtoError
						.newBuilder()
						.setLocalizedDescription(error?.message ?: "Unknown error")
						.build())
				.build()
		updateStateStreamHandler.sink?.success(stateChangesArg.toByteArray())
	}

	override fun onUpgradeCanceled(state: FirmwareUpgradeManager.State?) {
		val changes = FlutterMcu.ProtoUpdateStateChanges
				.newBuilder()
				.setCanceled(true)
				.setOldState(state!!.toProto())
				.setNewState(state.toProto())
				.build()
		val stateChangesArg = FlutterMcu.ProtoUpdateStateChangesStreamArg
				.newBuilder()
				.setUuid(address)
				.setUpdateStateChanges(changes)
				.build()
		updateStateStreamHandler.sink?.success(stateChangesArg.toByteArray())
	}

	override fun onUploadProgressChanged(bytesSent: Int, imageSize: Int, timestamp: Long) {
		val progress = FlutterMcu.ProtoProgressUpdate
				.newBuilder()
				.setImageSize(imageSize.toLong())
				.setBytesSent(bytesSent.toLong())
				.setTimestamp(timestamp.toDouble() / 1000.0) // convert to seconds
				.build()
		val arg = FlutterMcu.ProtoProgressUpdateStreamArg
				.newBuilder()
				.setUuid(address)
				.setProgressUpdate(progress)
				.build()
		updateProgressStreamHandler.sink?.success(arg.toByteArray())
	}
}