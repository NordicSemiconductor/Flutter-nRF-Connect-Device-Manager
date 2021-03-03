package no.nordicsemi.android.mcumgr_flutter.utils

import java.lang.IllegalArgumentException

@Suppress("EnumEntryName")
enum class FlutterMethod {
	update,
	initializeUpdateManager,
	pause,
	resume,
	isPaused,
	isInProgress;

	companion object {
		fun valueOfOrNull(string: String) = try {
			valueOf(string)
		} catch (e: IllegalArgumentException) {
			null
		}
	}
}

@Suppress("EnumEntryName")
enum class PlatformMethod {
	log;

	companion object {
		fun valueOfOrNull(string: String) = try {
			valueOf(string)
		} catch (e: IllegalArgumentException) {
			null
		}
	}
}