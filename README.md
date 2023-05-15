# nRF Connect Device Manager

nRF Connect Device Manager library is a Flutter plugin based on [Android](https://github.com/NordicSemiconductor/Android-nRF-Connect-Device-Manager) and [iOS](https://github.com/NordicSemiconductor/IOS-nRF-Connect-Device-Manager) nRF Connect Device Manager libraries.

> **BETA 🧪:** This library is still in beta. We are working on improving it and adding more features. If you have any suggestions or find any bugs, please create an issue or a pull request. Also future versions of this library may introduce breaking changes.

___
## Supported Platforms
- Android: `minSdkVersion 19`
- iOS: `13.0`

## Getting Started
### Creating a manager
Use `UpdateManagerFactory` to create an instance of `FirmwareUpdateManager`:

```dart
final managerFactory: UpdateManagerFactory = FirmwareUpdateManagerFactory()
// `deviceId` is a String with the device's MAC address (on Android) or UUID (on iOS)
final updateManager = await managerFactory.getUpdateManager(deviceId);
// call `setup` before using the manager
final updateStream = updateManager.setup();
```

### Updating the device
To update the device, call `update` method on the `FirmwareUpdateManager` instance:

```dart
// `firmware` is a List of data and index pairs
final List<Tuple2<int, Uint8List>> firmwareScheme = ...;
final configuration = const FirmwareUpgradeConfiguration(
      estimatedSwapTime: const Duration(seconds: 0),
      byteAlignment: ImageUploadAlignment.fourByte,
      eraseAppSettings: true,
      pipelineDepth: 1,
    );
// `configuration` is an optional parameter. If not provided, default values will be used.
updateManager.update(firmware.firmwareScheme, configuration: configuration);
```

### Listening for updates
To listen for updates, subscribe to the `updateStream` and `progressStream`:

```dart
updateManager.updateStateStream?.listen((event) {
    if (event == FirmwareUpgradeState.success) {
        print("Update Success");
    } else {
        print(event);
    }
});

updateManager.progressStream.listen((event) {
    print("${event.bytesSent} / ${event.imageSize}} bytes sent");
});
```

### Controlling the update
To control the update, use `FirmwareUpdateManager` methods:

```dart
  /// Pause the update process.
  Future<void> pause();

  /// Resume the update process.
  Future<void> resume();

  /// Cancel update.
  Future<void> cancel();

  /// Check if the progress is in process.
  Future<bool> inProgress();

  /// Check if the progress is paused.
  Future<bool> isPaused();
```

### Killing the manager
After the update is finished, call `kill` to kill the manager, otherwise it will lead to memory leaks and other issues:

```dart
updateManager.kill();
```

## Reading logs
To read logs from the device, use `FirmwareUpdateLogger`:

```dart
final logger = updateManager.logger;
logger.logMessageStream.listen((event) {
    for (var msg in event) {
        print("${msg.level.shortName} ${msg.message}");
    }
});
```