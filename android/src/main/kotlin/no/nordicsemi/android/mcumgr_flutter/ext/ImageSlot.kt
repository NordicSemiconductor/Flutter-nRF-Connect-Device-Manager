package no.nordicsemi.android.mcumgr_flutter.ext

import com.google.protobuf.kotlin.toByteString
import io.runtime.mcumgr.response.McuMgrResponse
import io.runtime.mcumgr.response.img.McuMgrImageStateResponse
import no.nordicsemi.android.mcumgr_flutter.gen.ProtoImageSlot
import okio.ByteString

fun McuMgrImageStateResponse.ImageSlot.toProto(): ProtoImageSlot {
    return ProtoImageSlot(
        slot = this.slot.toLong(),
        version = version,
        hash = ByteString.of(hash),
        bootable = bootable,
        pending = pending,
        confirmed = confirmed,
        active = active,
        permanent = permanent
    )
}