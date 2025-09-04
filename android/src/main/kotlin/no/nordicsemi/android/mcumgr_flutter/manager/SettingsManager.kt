package no.nordicsemi.android.mcumgr_flutter.manager

import android.util.Log
import com.fasterxml.jackson.annotation.JsonCreator
import com.fasterxml.jackson.annotation.JsonProperty
import io.flutter.plugin.common.MethodChannel
import io.runtime.mcumgr.McuMgrCallback
import io.runtime.mcumgr.ble.McuMgrBleTransport
import io.runtime.mcumgr.exception.McuMgrException
import io.runtime.mcumgr.response.McuMgrResponse
import io.runtime.mcumgr.response.settings.McuMgrSettingsReadResponse
import io.runtime.mcumgr.util.CBOR
import io.runtime.mcumgr.managers.SettingsManager as McuMgrSettingsManager

class SettingsManager(transport: McuMgrBleTransport) {
    var mcuMgrSettingsManager: McuMgrSettingsManager = McuMgrSettingsManager(transport)
    fun fetchSettings(result: MethodChannel.Result) {
        mcuMgrSettingsManager.load(object : McuMgrCallback<McuMgrResponse> {
            override fun onResponse(response: McuMgrResponse) {
                result.success(response.toString())
            }

            override fun onError(error: McuMgrException) {
                Log.e("[FETCH_SETTINGS] error", error.toString())
                result.error("MCUMGR_ERROR", error.message, null)
            }
        })
    }

    fun readSettings(key: String, result: MethodChannel.Result) {
        val payloadMap = HashMap<String?, Any?>()
        payloadMap.put("name", key)

        mcuMgrSettingsManager.send(
            0,
            0,
            payloadMap,
            2500L,
            McuMgrSettingsTestResponse::class.java,
            object : McuMgrCallback<McuMgrSettingsTestResponse> {
                override fun onResponse(response: McuMgrSettingsTestResponse) {
                    try {
                        Log.e("[READ_SINGLE]", "readSettings: ${response}")
                        val byteResponse = response.`val`
                        result.success(byteResponse)
                    } catch (e: Exception) {
                        Log.e("[READ_SINGLE]", "Error decoding single setting: ${e.message}")
                        result.error(
                            "CBOR_ERROR",
                            "Error decoding single setting: ${e.message}",
                            null
                        )
                    }
                }

                override fun onError(error: McuMgrException) {
                    Log.e("[READ_SINGLE] error", error.message.toString())
                    Log.e("READ_SINGLE", "StackTrace: ${Log.getStackTraceString(error)}")
                    result.error("MCUMGR_ERROR", error.message, null)
                }
            })
    }


    fun writeSetting(key: String, value: ByteArray, result: MethodChannel.Result) {

        Log.e("[WRITE_SINGLE]", "writeSettings: key: $key, value: ${value.asList()}")

        val map = HashMap<String, Any?>()
        map["name"] = key
        map["val"] = value

        Log.e("[WRITE_SINGLE]", "CBOR: key: ${
            CBOR.toBytes({
                map
            }).toString(Charsets.UTF_8)
        }")

        mcuMgrSettingsManager.write(key, value, object : McuMgrCallback<McuMgrResponse> {
            override fun onResponse(response: McuMgrResponse) {
                try {
                    result.success(response.bytes)
                    Log.e("[READ_SINGLE]", "readSettings: ${response}")
                } catch (e: Exception) {
                    result.error(
                        "[WRITE_DECODE]",
                        "Error decoding write response: ${e.message}",
                        null
                    )
                }
            }

            override fun onError(error: McuMgrException) {
                Log.e("[WRITE] error", error.message.toString())
                result.error("MCUMGR_ERROR", error.message, null)
            }
        })
    }


}

class McuMgrSettingsTestResponse @JsonCreator constructor(
    @param:JsonProperty("val")
    var `val`: Object?
) : McuMgrSettingsReadResponse()