import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/no/nordicsemi/android/mcumgr_flutter/Messages.g.kt',
  kotlinOptions: KotlinOptions(
      package: "no.nordicsemi.android.mcumgr_flutter"
  ), // TODO("Add Swift")
  swiftOut: 'ios/Classes/Messages.g.swift',
  swiftOptions: SwiftOptions(),
))

/// Generic class that matches all possible events from the native DownloadCallback interface.
sealed class DownloadCallbackEvent {}

class OnDownloadProgressChangedEvent extends DownloadCallbackEvent {
  final int current;
  final int total;
  final int timestamp;
  final String remoteId;
  final String path;
  OnDownloadProgressChangedEvent({required this.current, required this.total, required this.timestamp, required this.remoteId, required this.path});
}

class OnDownloadFailedEvent extends DownloadCallbackEvent {
  final String? cause;
  final String remoteId;
  final String path;
  OnDownloadFailedEvent({required this.cause, required this.remoteId, required this.path});
}

class OnDownloadCancelledEvent extends DownloadCallbackEvent {
  final String remoteId;
  /// Needed to track the event source coming through a single stream.
  final String path;

  OnDownloadCancelledEvent({required this.remoteId, required this.path});
}

class OnDownloadCompletedEvent extends DownloadCallbackEvent {
  final String remoteId;
  /// Needed to track the event source coming through a single stream.
  final String path;
  /// The raw bytes of the file.
  final Uint8List bytes;

  OnDownloadCompletedEvent(this.bytes, {required this.remoteId, required this.path});
}

@EventChannelApi()
abstract class FsManagerEvents {
  /// Get a stream of all file download events.
  DownloadCallbackEvent getFileDownloadEvents();
}

@HostApi()
abstract class FsManagerApi {
  /// Starts the download of a single file with a specific device.
  /// Additional calls to a device that has an ongoing download causes a [PlatformException]
  /// to be thrown.
  void download(String remoteId, String path);

  /// Pause an ongoing download
  void pauseTransfer(String remoteId);

  /// Resume an ongoing download
  void continueTransfer(String remoteId);

  /// Cancel an ongoing download
  void cancelTransfer(String remoteId);

  @async
  int status(String remoteId, String path);

  /// Kill the FsManager instance on the native platform.
  void kill(String remoteId);
}