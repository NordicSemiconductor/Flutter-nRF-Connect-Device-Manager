//Generated by the protocol buffer compiler. DO NOT EDIT!
// source: lib/proto/flutter_mcu.proto

@kotlin.jvm.JvmSynthetic
public inline fun protoUpdateCallArgument(block: ProtoUpdateCallArgumentKt.Dsl.() -> kotlin.Unit): FlutterMcu.ProtoUpdateCallArgument =
  ProtoUpdateCallArgumentKt.Dsl._create(FlutterMcu.ProtoUpdateCallArgument.newBuilder()).apply { block() }._build()
public object ProtoUpdateCallArgumentKt {
  @kotlin.OptIn(com.google.protobuf.kotlin.OnlyForUseByGeneratedProtoCode::class)
  @com.google.protobuf.kotlin.ProtoDslMarker
  public class Dsl private constructor(
    private val _builder: FlutterMcu.ProtoUpdateCallArgument.Builder
  ) {
    public companion object {
      @kotlin.jvm.JvmSynthetic
      @kotlin.PublishedApi
      internal fun _create(builder: FlutterMcu.ProtoUpdateCallArgument.Builder): Dsl = Dsl(builder)
    }

    @kotlin.jvm.JvmSynthetic
    @kotlin.PublishedApi
    internal fun _build(): FlutterMcu.ProtoUpdateCallArgument = _builder.build()

    /**
     * <code>string device_uuid = 1;</code>
     */
    public var deviceUuid: kotlin.String
      @JvmName("getDeviceUuid")
      get() = _builder.getDeviceUuid()
      @JvmName("setDeviceUuid")
      set(value) {
        _builder.setDeviceUuid(value)
      }
    /**
     * <code>string device_uuid = 1;</code>
     */
    public fun clearDeviceUuid() {
      _builder.clearDeviceUuid()
    }

    /**
     * <code>bytes firmware_data = 2;</code>
     */
    public var firmwareData: com.google.protobuf.ByteString
      @JvmName("getFirmwareData")
      get() = _builder.getFirmwareData()
      @JvmName("setFirmwareData")
      set(value) {
        _builder.setFirmwareData(value)
      }
    /**
     * <code>bytes firmware_data = 2;</code>
     */
    public fun clearFirmwareData() {
      _builder.clearFirmwareData()
    }
  }
}
public inline fun FlutterMcu.ProtoUpdateCallArgument.copy(block: ProtoUpdateCallArgumentKt.Dsl.() -> kotlin.Unit): FlutterMcu.ProtoUpdateCallArgument =
  ProtoUpdateCallArgumentKt.Dsl._create(this.toBuilder()).apply { block() }._build()
