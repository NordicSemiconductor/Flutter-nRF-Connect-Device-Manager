//Generated by the protocol buffer compiler. DO NOT EDIT!
// source: lib/proto/flutter_mcu.proto

package no.nordicsemi.android.mcumgr_flutter.gen;

@kotlin.jvm.JvmSynthetic
public inline fun protoMessageLiveLogEnabled(block: no.nordicsemi.android.mcumgr_flutter.gen.ProtoMessageLiveLogEnabledKt.Dsl.() -> kotlin.Unit): no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.ProtoMessageLiveLogEnabled =
  no.nordicsemi.android.mcumgr_flutter.gen.ProtoMessageLiveLogEnabledKt.Dsl._create(no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.ProtoMessageLiveLogEnabled.newBuilder()).apply { block() }._build()
public object ProtoMessageLiveLogEnabledKt {
  @kotlin.OptIn(com.google.protobuf.kotlin.OnlyForUseByGeneratedProtoCode::class)
  @com.google.protobuf.kotlin.ProtoDslMarker
  public class Dsl private constructor(
    private val _builder: no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.ProtoMessageLiveLogEnabled.Builder
  ) {
    public companion object {
      @kotlin.jvm.JvmSynthetic
      @kotlin.PublishedApi
      internal fun _create(builder: no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.ProtoMessageLiveLogEnabled.Builder): Dsl = Dsl(builder)
    }

    @kotlin.jvm.JvmSynthetic
    @kotlin.PublishedApi
    internal fun _build(): no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.ProtoMessageLiveLogEnabled = _builder.build()

    /**
     * <code>string uuid = 1;</code>
     */
    public var uuid: kotlin.String
      @JvmName("getUuid")
      get() = _builder.getUuid()
      @JvmName("setUuid")
      set(value) {
        _builder.setUuid(value)
      }
    /**
     * <code>string uuid = 1;</code>
     */
    public fun clearUuid() {
      _builder.clearUuid()
    }

    /**
     * <code>bool enabled = 2;</code>
     */
    public var enabled: kotlin.Boolean
      @JvmName("getEnabled")
      get() = _builder.getEnabled()
      @JvmName("setEnabled")
      set(value) {
        _builder.setEnabled(value)
      }
    /**
     * <code>bool enabled = 2;</code>
     */
    public fun clearEnabled() {
      _builder.clearEnabled()
    }
  }
}
public inline fun no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.ProtoMessageLiveLogEnabled.copy(block: no.nordicsemi.android.mcumgr_flutter.gen.ProtoMessageLiveLogEnabledKt.Dsl.() -> kotlin.Unit): no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.ProtoMessageLiveLogEnabled =
  no.nordicsemi.android.mcumgr_flutter.gen.ProtoMessageLiveLogEnabledKt.Dsl._create(this.toBuilder()).apply { block() }._build()