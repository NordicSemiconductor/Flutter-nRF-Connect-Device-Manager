package no.nordicsemi.android.mcumgr_flutter

import android.bluetooth.BluetoothAdapter
import android.content.Context
import android.os.Handler
import io.flutter.plugin.common.BinaryMessenger
import io.runtime.mcumgr.McuMgrCallback
import io.runtime.mcumgr.exception.McuMgrException
import io.runtime.mcumgr.managers.FsManager
import io.runtime.mcumgr.response.fs.McuMgrFsStatusResponse
import io.runtime.mcumgr.transfer.DownloadCallback
import io.runtime.mcumgr.transfer.TransferController
import no.nordicsemi.android.mcumgr_flutter.logging.LoggableMcuMgrBleTransport
import no.nordicsemi.android.mcumgr_flutter.utils.StreamHandler
import no.nordicsemi.android.mcumgr_flutter.utils.FsDownloadStreamHandler

class FsManagerPlugin(
    private val context: Context,
    private val logStreamHandler: StreamHandler,
    binaryMessenger: BinaryMessenger,
    private val mainHandler: Handler,
) : FsManagerApi {

    private val fsDownloadStreamHandler = FsDownloadStreamHandler()
    private var fsManagers: MutableMap<String, FsManager> = mutableMapOf()
    private var controllers = mutableMapOf<String, TransferController>()

    init {
        GetFileDownloadEventsStreamHandler.register(binaryMessenger, fsDownloadStreamHandler)
        FsManagerApi.setUp(
            binaryMessenger,
            this
        )
    }

    private fun getFsManager(remoteId: String): FsManager {
        synchronized(this) {
            return fsManagers[remoteId]
                ?: run {
                    val device = BluetoothAdapter.getDefaultAdapter().getRemoteDevice(remoteId)
                    val transport = LoggableMcuMgrBleTransport(context, device, logStreamHandler)
                        .apply { setLoggingEnabled(true) }
                    val mgr = FsManager(transport)
                    fsManagers[remoteId] = mgr
                    mgr
                }
        }
    }

    override fun download(remoteId: String, path: String) {
        if (controllers[remoteId] != null) {
            throw FlutterError("TODO code", "A transfer is already ongoing for $remoteId.")
        }
        val mgr = getFsManager(remoteId)
        mgr.fileDownload(
            path,
            object : DownloadCallback {
                override fun onDownloadProgressChanged(current: Int, total: Int, timestamp: Long) {
                    mainHandler.post {
                        fsDownloadStreamHandler.onEvent(
                            OnDownloadProgressChangedEvent(current.toLong(), total.toLong(), timestamp, remoteId, path)
                        )
                    }
                }

                override fun onDownloadFailed(p0: McuMgrException) {
                    controllers.remove(remoteId)
                    mainHandler.post {
                        fsDownloadStreamHandler.onEvent(
                            OnDownloadFailedEvent(p0.message, remoteId, path)
                        )
                    }
                }

                override fun onDownloadCanceled() {
                    controllers.remove(remoteId)
                    mainHandler.post {
                        fsDownloadStreamHandler.onEvent(
                            OnDownloadCancelledEvent(remoteId, path)
                        )
                    }
                }

                override fun onDownloadCompleted(p0: ByteArray) {
                    controllers.remove(remoteId)
                    mainHandler.post {
                        fsDownloadStreamHandler.onEvent(
                            OnDownloadCompletedEvent(remoteId, path, p0)
                        )
                    }
                }
            }
        )
    }

    override fun pauseTransfer(remoteId: String) {
        fsManagers[remoteId]?.pauseTransfer()
    }

    override fun continueTransfer(remoteId: String) {
        fsManagers[remoteId]?.continueTransfer()
    }

    override fun cancelTransfer(remoteId: String) {
        fsManagers[remoteId]?.cancelTransfer()
    }

    override fun status(remoteId: String, path: String, callback: (Result<Long>) -> Unit) {
        val mgr = getFsManager(remoteId)
        mgr.status(
            path,
            object : McuMgrCallback<McuMgrFsStatusResponse> {
                override fun onResponse(p0: McuMgrFsStatusResponse) {
                    callback(Result.success(p0.len.toLong()))
                }

                override fun onError(p0: McuMgrException) {
                    callback(Result.failure(p0))
                }
            }
        )
    }

    override fun kill(remoteId: String) {
        fsManagers.remove(remoteId)?.transporter?.release()
    }
}