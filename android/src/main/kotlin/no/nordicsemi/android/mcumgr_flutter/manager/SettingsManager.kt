package no.nordicsemi.android.mcumgr_flutter.manager

import com.fasterxml.jackson.annotation.JsonCreator
import com.fasterxml.jackson.annotation.JsonProperty
import io.flutter.plugin.common.MethodChannel
import io.runtime.mcumgr.McuMgrCallback
import io.runtime.mcumgr.ble.McuMgrBleTransport
import io.runtime.mcumgr.exception.McuMgrException
import io.runtime.mcumgr.response.McuMgrResponse
import io.runtime.mcumgr.response.settings.McuMgrSettingsReadResponse
import io.runtime.mcumgr.util.CBOR
import java.nio.ByteBuffer
import java.nio.charset.StandardCharsets
import io.runtime.mcumgr.managers.SettingsManager as McuMgrSettingsManager

private const val errorCode = "MCUMGR_ERROR"

class SettingsManager(
    transport: McuMgrBleTransport,
    val padTo4Bytes: Boolean = false,
    val encodeValueToCBOR: Boolean = false,
    val precisionMode: String = "auto",
) {
    var mcuMgrSettingsManager: McuMgrSettingsManager = McuMgrSettingsManager(transport)
    fun fetchSettings(result: MethodChannel.Result) {
        mcuMgrSettingsManager.load(object : McuMgrCallback<McuMgrResponse> {
            override fun onResponse(response: McuMgrResponse) {
                result.success(response.bytes)
            }

            override fun onError(error: McuMgrException) {
                error.printStackTrace()
                result.error(errorCode, error.message, null)
            }
        })
    }

    fun readSettings(key: String, result: MethodChannel.Result) {
        val payloadMap = HashMap<String, Any>()
        payloadMap.put("name", key)

        mcuMgrSettingsManager.send(
            0,
            0,
            payloadMap,
            2500L,
            McuMgrSettingsUniversalResponse::class.java,
            object : McuMgrCallback<McuMgrSettingsUniversalResponse> {
                override fun onResponse(response: McuMgrSettingsUniversalResponse) {
                    try {
                        if (response.isSuccess) {
                            val byteResponse = response.`val`
                            result.success(byteResponse)
                        } else {
                            result.error(
                                errorCode,
                                "Error decoding single setting: ${response.returnCode.value()}",
                                null
                            )
                        }
                    } catch (e: Exception) {
                        e.printStackTrace()
                        result.error(
                            errorCode,
                            "Error decoding single setting: ${e.message}",
                            null
                        )
                    }
                }

                override fun onError(error: McuMgrException) {
                    error.printStackTrace()
                    result.error(errorCode, error.message, null)
                }
            })
    }

    fun writeSetting(key: String, value: Any, result: MethodChannel.Result) {
        // Apply precision mode for Double values
        val processedValue = when {
            value is Double -> {
                when (precisionMode) {
                    "forceFloat32" -> value.toFloat()
                    "forceDouble64" -> value
                    else -> { // "auto"
                        val floatValue = value.toFloat()
                        val canFitInFloat = floatValue.toString() == value.toString() &&
                                           value >= -Float.MAX_VALUE.toDouble() &&
                                           value <= Float.MAX_VALUE.toDouble()

                        if (canFitInFloat) floatValue else value
                    }
                }
            }
            else -> value
        }

        val valueBytes = if (encodeValueToCBOR) CBOR.toBytes(if (processedValue is String && padTo4Bytes) processedValue.padTo4Bytes() else processedValue) else processedValue.toBytes()
        mcuMgrSettingsManager.write(
            key,
            valueBytes,
            object : McuMgrCallback<McuMgrResponse> {
                override fun onResponse(response: McuMgrResponse) {
                    try {
                        if (response.isSuccess) {
                            result.success(response.bytes)
                        } else {
                            result.error(
                                errorCode,
                                "Error decoding write response: ${response.returnCode.value()}",
                                null
                            )
                        }
                    } catch (e: Exception) {
                        result.error(
                            errorCode,
                            "Error decoding write response: ${e.message}",
                            null
                        )
                    }
                }

                override fun onError(error: McuMgrException) {
                    error.printStackTrace()
                    result.error(errorCode, error.message, null)
                }
            })
    }

    private fun String.padTo4Bytes(): String {
        val bytes = this.toByteArray(StandardCharsets.UTF_8)
        val paddingNeeded = (4 - (bytes.size % 4)) % 4
        return if (paddingNeeded == 0) this else this + "\u0000".repeat(paddingNeeded)
    }

    fun Any.toBytes(): ByteArray = when (this) {
        is String -> (if (padTo4Bytes) this.padTo4Bytes() else this).toByteArray(StandardCharsets.UTF_8)
        is Int -> ByteBuffer.allocate(4).putInt(this).array()
        is Float -> ByteBuffer.allocate(4).putFloat(this).array()
        is Double -> ByteBuffer.allocate(8).putDouble(this).array()
        is Boolean -> byteArrayOf(if (this) 1 else 0)
        is ByteArray -> this
        else -> throw IllegalArgumentException("Unsupported type: ${this::class}")
    }
}

@Suppress("PROPERTY_HIDES_JAVA_FIELD")
private class McuMgrSettingsUniversalResponse @JsonCreator constructor(
    @param:JsonProperty("val") var `val`: Object?
) : McuMgrSettingsReadResponse()