package no.nordicsemi.android.mcumgr_flutter.ext

import io.runtime.mcumgr.response.McuMgrResponse
import io.runtime.mcumgr.response.img.McuMgrImageStateResponse
import no.nordicsemi.android.mcumgr_flutter.gen.ProtoImageSlot
import okio.ByteString
import okio.ByteString.Companion.toByteString

fun McuMgrImageStateResponse.ImageSlot.toProto(): ProtoImageSlot {
    return ProtoImageSlot(
        slot = this.slot.toLong(),
        version = version,
        hash = hash.toByteString(),
        bootable = bootable,
        pending = pending,
        confirmed = confirmed,
        active = active,
        permanent = permanent
    )
}