//Generated by the protocol buffer compiler. DO NOT EDIT!
// source: lib/proto/flutter_mcu.proto

package no.nordicsemi.android.mcumgr_flutter.gen;

@kotlin.jvm.JvmSynthetic
public inline fun pair(block: no.nordicsemi.android.mcumgr_flutter.gen.PairKt.Dsl.() -> kotlin.Unit): no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.Pair =
  no.nordicsemi.android.mcumgr_flutter.gen.PairKt.Dsl._create(no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.Pair.newBuilder()).apply { block() }._build()
public object PairKt {
  @kotlin.OptIn(com.google.protobuf.kotlin.OnlyForUseByGeneratedProtoCode::class)
  @com.google.protobuf.kotlin.ProtoDslMarker
  public class Dsl private constructor(
    private val _builder: no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.Pair.Builder
  ) {
    public companion object {
      @kotlin.jvm.JvmSynthetic
      @kotlin.PublishedApi
      internal fun _create(builder: no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.Pair.Builder): Dsl = Dsl(builder)
    }

    @kotlin.jvm.JvmSynthetic
    @kotlin.PublishedApi
    internal fun _build(): no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.Pair = _builder.build()

    /**
     * <code>int32 key = 1;</code>
     */
    public var key: kotlin.Int
      @JvmName("getKey")
      get() = _builder.getKey()
      @JvmName("setKey")
      set(value) {
        _builder.setKey(value)
      }
    /**
     * <code>int32 key = 1;</code>
     */
    public fun clearKey() {
      _builder.clearKey()
    }

    /**
     * <code>bytes value = 2;</code>
     */
    public var value: com.google.protobuf.ByteString
      @JvmName("getValue")
      get() = _builder.getValue()
      @JvmName("setValue")
      set(value) {
        _builder.setValue(value)
      }
    /**
     * <code>bytes value = 2;</code>
     */
    public fun clearValue() {
      _builder.clearValue()
    }
  }
}
public inline fun no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.Pair.copy(block: no.nordicsemi.android.mcumgr_flutter.gen.PairKt.Dsl.() -> kotlin.Unit): no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.Pair =
  no.nordicsemi.android.mcumgr_flutter.gen.PairKt.Dsl._create(this.toBuilder()).apply { block() }._build()