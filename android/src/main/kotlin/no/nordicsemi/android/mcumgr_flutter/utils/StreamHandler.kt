package no.nordicsemi.android.mcumgr_flutter.utils

import io.flutter.plugin.common.EventChannel

class StreamHandler: EventChannel.StreamHandler {
	var sink: EventChannel.EventSink? = null
		private set

	override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
		sink = events
	}

	override fun onCancel(arguments: Any?) {
		sink = null
	}
}