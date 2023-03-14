package no.nordicsemi.android.mcumgr_flutter.ext

import io.runtime.mcumgr.dfu.FirmwareUpgradeManager.State
import io.runtime.mcumgr.dfu.FirmwareUpgradeManager.State.*
import no.nordicsemi.android.mcumgr_flutter.gen.ProtoUpdateStateChanges.FirmwareUpgradeState as Proto

fun State.toProto(): Proto = when (this) {
	NONE     -> Proto.NONE
	VALIDATE -> Proto.VALIDATE
	UPLOAD   -> Proto.UPLOAD
	TEST     -> Proto.TEST
	RESET    -> Proto.RESET
	CONFIRM  -> Proto.CONFIRM
}

fun State.shouldLog(): Boolean = when (this) {
	UPLOAD   -> false
	else     -> true
}