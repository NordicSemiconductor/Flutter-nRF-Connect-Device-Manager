//Generated by the protocol buffer compiler. DO NOT EDIT!
// source: lib/proto/flutter_mcu.proto

package no.nordicsemi.android.mcumgr_flutter.gen;

@kotlin.jvm.JvmSynthetic
public inline fun protoProgressUpdateStreamArg(block: no.nordicsemi.android.mcumgr_flutter.gen.ProtoProgressUpdateStreamArgKt.Dsl.() -> kotlin.Unit): no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.ProtoProgressUpdateStreamArg =
  no.nordicsemi.android.mcumgr_flutter.gen.ProtoProgressUpdateStreamArgKt.Dsl._create(no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.ProtoProgressUpdateStreamArg.newBuilder()).apply { block() }._build()
public object ProtoProgressUpdateStreamArgKt {
  @kotlin.OptIn(com.google.protobuf.kotlin.OnlyForUseByGeneratedProtoCode::class)
  @com.google.protobuf.kotlin.ProtoDslMarker
  public class Dsl private constructor(
    private val _builder: no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.ProtoProgressUpdateStreamArg.Builder
  ) {
    public companion object {
      @kotlin.jvm.JvmSynthetic
      @kotlin.PublishedApi
      internal fun _create(builder: no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.ProtoProgressUpdateStreamArg.Builder): Dsl = Dsl(builder)
    }

    @kotlin.jvm.JvmSynthetic
    @kotlin.PublishedApi
    internal fun _build(): no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.ProtoProgressUpdateStreamArg = _builder.build()

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
     * <code>bool done = 2;</code>
     */
    public var done: kotlin.Boolean
      @JvmName("getDone")
      get() = _builder.getDone()
      @JvmName("setDone")
      set(value) {
        _builder.setDone(value)
      }
    /**
     * <code>bool done = 2;</code>
     */
    public fun clearDone() {
      _builder.clearDone()
    }

    /**
     * <code>.no.nordicsemi.android.mcumgr_flutter.gen.ProtoError error = 3;</code>
     */
    public var error: no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.ProtoError
      @JvmName("getError")
      get() = _builder.getError()
      @JvmName("setError")
      set(value) {
        _builder.setError(value)
      }
    /**
     * <code>.no.nordicsemi.android.mcumgr_flutter.gen.ProtoError error = 3;</code>
     */
    public fun clearError() {
      _builder.clearError()
    }
    /**
     * <code>.no.nordicsemi.android.mcumgr_flutter.gen.ProtoError error = 3;</code>
     * @return Whether the error field is set.
     */
    public fun hasError(): kotlin.Boolean {
      return _builder.hasError()
    }

    /**
     * <code>.no.nordicsemi.android.mcumgr_flutter.gen.ProtoProgressUpdate progressUpdate = 4;</code>
     */
    public var progressUpdate: no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.ProtoProgressUpdate
      @JvmName("getProgressUpdate")
      get() = _builder.getProgressUpdate()
      @JvmName("setProgressUpdate")
      set(value) {
        _builder.setProgressUpdate(value)
      }
    /**
     * <code>.no.nordicsemi.android.mcumgr_flutter.gen.ProtoProgressUpdate progressUpdate = 4;</code>
     */
    public fun clearProgressUpdate() {
      _builder.clearProgressUpdate()
    }
    /**
     * <code>.no.nordicsemi.android.mcumgr_flutter.gen.ProtoProgressUpdate progressUpdate = 4;</code>
     * @return Whether the progressUpdate field is set.
     */
    public fun hasProgressUpdate(): kotlin.Boolean {
      return _builder.hasProgressUpdate()
    }
  }
}
public inline fun no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.ProtoProgressUpdateStreamArg.copy(block: no.nordicsemi.android.mcumgr_flutter.gen.ProtoProgressUpdateStreamArgKt.Dsl.() -> kotlin.Unit): no.nordicsemi.android.mcumgr_flutter.gen.FlutterMcu.ProtoProgressUpdateStreamArg =
  no.nordicsemi.android.mcumgr_flutter.gen.ProtoProgressUpdateStreamArgKt.Dsl._create(this.toBuilder()).apply { block() }._build()