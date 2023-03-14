package no.nordicsemi.android.mcumgr_flutter

import android.util.Log
import android.util.Pair
import io.runtime.mcumgr.ble.McuMgrBleTransport
import io.runtime.mcumgr.dfu.FirmwareUpgradeCallback
import io.runtime.mcumgr.dfu.FirmwareUpgradeController
import io.runtime.mcumgr.dfu.FirmwareUpgradeManager
import io.runtime.mcumgr.exception.McuMgrException
import no.nordicsemi.android.mcumgr_flutter.ext.shouldLog
import no.nordicsemi.android.mcumgr_flutter.ext.toProto
import no.nordicsemi.android.mcumgr_flutter.gen.*
import no.nordicsemi.android.mcumgr_flutter.logging.LoggableMcuMgrBleTransport
import no.nordicsemi.android.mcumgr_flutter.utils.StreamHandler
import java.security.MessageDigest


// Extensions of ByteArray to get sha1 hash
val ByteArray.sha1: String
	get() {
		val bytes = MessageDigest.getInstance("SHA-1").digest(this)
		return bytes.joinToString("") {
			"%02x".format(it)
		}
	}

data class FirmwareUpgradeConfiguration(
	val estimatedSwapTime: Long = 0,
	val eraseAppSettings: Boolean = true,
	val pipelineDepth: Int = 1,
	val byteAlignment: Int = 4,
	val reassemblyBufferSize: Long = 0
)

class UpdateManager(
		transport: McuMgrBleTransport,
		private val updateStateStreamHandler: StreamHandler,
		private val updateProgressStreamHandler: StreamHandler,
		private val logStreamHandler: StreamHandler
): FirmwareUpgradeCallback {
	private val manager: FirmwareUpgradeManager = FirmwareUpgradeManager(transport, this)
	private val address: String = transport.bluetoothDevice.address
	private val transport: LoggableMcuMgrBleTransport = transport as LoggableMcuMgrBleTransport

	init {
		manager.setMemoryAlignment(4)
		manager.setEstimatedSwapTime(5000)
		manager.setWindowUploadCapacity(3)
		manager.setMode(FirmwareUpgradeManager.Mode.CONFIRM_ONLY)
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

	private val TAG: String? = "MyActivity"

	fun start(images: List<Pair<Int, ByteArray>>, config: FirmwareUpgradeConfiguration?) {
		if (config != null) {
			manager.setMemoryAlignment(config.byteAlignment)
			manager.setEstimatedSwapTime(config.estimatedSwapTime.toInt())
			manager.setWindowUploadCapacity(config.pipelineDepth)
		}
		// print images to log
		images.forEach {
			val imageNumber = it.first
			val image = it.second
			// Get sha1 hash of image
			val sha1 = image.sha1

			// Log image and sha1
			Log.d(TAG, "Image $imageNumber: ${image.size} bytes, sha1: $sha1")
		}
		manager.start(images, config?.eraseAppSettings ?: true)
	}
	/** Pause the firmware upgrade. */
	fun pause() {
		if (!isPaused) {
			transport.setLoggingEnabled(true)
			manager.pause()
		}
	}
	/** Resume a paused firmware upgrade. */
	fun resume() {
		if (isPaused) {
			manager.resume()
			transport.setLoggingEnabled(false)
		}
	}
	/** Cancel the transfer. */
	fun cancel() = manager.cancel()
	/** True if the firmware upgrade is paused, false otherwise. */
	var isPaused = manager.isPaused
	/**	True if the firmware upgrade is in progress, false otherwise. */
	var isInProgress = manager.isInProgress
	/** Read all logs */
	fun readAllLogs() : ProtoLogMessageStreamArg {
		return (manager.transporter as? LoggableMcuMgrBleTransport)!!.readLogs()
	}

	override fun onUpgradeStarted(controller: FirmwareUpgradeController?) {
		transport.setLoggingEnabled(true)
	}

	override fun onStateChanged(prevState: FirmwareUpgradeManager.State?, newState: FirmwareUpgradeManager.State?) {
		transport.setLoggingEnabled(newState!!.shouldLog())
		transport.log("State changed: $prevState -> $newState")

		val changes = ProtoUpdateStateChanges(
			oldState = prevState!!.toProto(),
			newState = newState!!.toProto(),
		)
		val stateChangesArg = ProtoUpdateStateChangesStreamArg(
			uuid = address,
			updateStateChanges = changes,
		)
		updateStateStreamHandler.sink?.success(stateChangesArg.encode())
	}

	override fun onUpgradeCompleted() {
		transport.setLoggingEnabled(true)
		transport.log("Upgrade completed")

		val changes = ProtoUpdateStateChanges(
			newState = ProtoUpdateStateChanges.FirmwareUpgradeState.SUCCESS,
		)
		val successStateChanges = ProtoUpdateStateChangesStreamArg(
			uuid = address,
			updateStateChanges = changes,
		)
		updateStateStreamHandler.sink?.success(successStateChanges.encode())

		val stateChangesArg = ProtoUpdateStateChangesStreamArg(
			uuid = address,
			done = true,
		)
		updateStateStreamHandler.sink?.success(stateChangesArg.encode())

		val progressArg = ProtoProgressUpdateStreamArg(
			uuid = address,
			done = true,
		)
		updateProgressStreamHandler.sink?.success(progressArg.encode())

		val logArg = ProtoLogMessageStreamArg(
			uuid = address,
			done = true,
		)
		logStreamHandler.sink?.success(logArg.encode())
	}

	override fun onUpgradeFailed(state: FirmwareUpgradeManager.State?, error: McuMgrException?) {
		transport.setLoggingEnabled(true)
		transport.log("Upgrade failed")

		val changes = ProtoUpdateStateChanges(
			oldState = state!!.toProto(),
			newState = state.toProto(),
		)
		val stateChangesArg = ProtoUpdateStateChangesStreamArg(
			uuid = address,
			updateStateChanges = changes,
			error = ProtoError(
				localizedDescription = error?.message ?: "Unknown error",
			),
		)
		updateStateStreamHandler.sink?.success(stateChangesArg.encode())
	}

	override fun onUpgradeCanceled(state: FirmwareUpgradeManager.State?) {
		transport.setLoggingEnabled(true)
		transport.log("Upgrade canceled")

		val changes = ProtoUpdateStateChanges(
			oldState = state!!.toProto(),
			newState = state.toProto(),
			canceled = true,
		)
		val stateChangesArg = ProtoUpdateStateChangesStreamArg(
			uuid = address,
			updateStateChanges = changes,
		)
		updateStateStreamHandler.sink?.success(stateChangesArg.encode())
	}

	override fun onUploadProgressChanged(bytesSent: Int, imageSize: Int, timestamp: Long) {
		val progress = ProtoProgressUpdate(
			bytesSent = bytesSent.toLong(),
			imageSize = imageSize.toLong(),
			timestamp = timestamp.toDouble(), // convert to seconds
		)
		val arg = ProtoProgressUpdateStreamArg(
			uuid = address,
			progressUpdate = progress,
		)
		updateProgressStreamHandler.sink?.success(arg.encode())
	}
}