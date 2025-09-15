package no.nordicsemi.android.mcumgr_flutter.utils

import no.nordicsemi.android.mcumgr_flutter.DownloadCallbackEvent
import no.nordicsemi.android.mcumgr_flutter.GetFileDownloadEventsStreamHandler
import no.nordicsemi.android.mcumgr_flutter.PigeonEventSink

class FsDownloadStreamHandler : GetFileDownloadEventsStreamHandler() {
    private var sink: PigeonEventSink<DownloadCallbackEvent>? = null

    override fun onListen(
        p0: Any?,
        sink: PigeonEventSink<DownloadCallbackEvent>
    ) {
        this.sink = sink;
    }

    override fun onCancel(p0: Any?) {
        this.sink = null;
    }

    fun onEvent(event: DownloadCallbackEvent) {
        sink?.success(event);
    }
}