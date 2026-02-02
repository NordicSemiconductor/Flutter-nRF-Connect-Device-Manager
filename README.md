# nRF Connect Device Manager

nRF Connect Device Manager library is a Flutter plugin (aka "wrapper") around the existing [Android](https://github.com/NordicSemiconductor/Android-nRF-Connect-Device-Manager) and [iOS](https://github.com/NordicSemiconductor/IOS-nRF-Connect-Device-Manager) nRF Connect Device Manager libraries. For more concrete documentation, you may also try reaching out into those for specific details.

![Platforms](https://img.shields.io/badge/Platforms-Android%20|%20iOS%20|%20macOS-333333.svg)
[![License](https://img.shields.io/github/license/NordicSemiconductor/Flutter-nRF-Connect-Device-Manager)](https://github.com/NordicSemiconductor/Flutter-nRF-Connect-Device-Manager/blob/main/LICENSE)
[![Release](https://img.shields.io/github/release/NordicSemiconductor/Flutter-nRF-Connect-Device-Manager.svg)](https://github.com/NordicSemiconductor/Flutter-nRF-Connect-Device-Manager/releases)
[![GitHub stars](https://img.shields.io/github/stars/NordicSemiconductor/Flutter-nRF-Connect-Device-Manager)](https://github.com/NordicSemiconductor/Flutter-nRF-Connect-Device-Manager/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/NordicSemiconductor/Flutter-nRF-Connect-Device-Manager)](https://github.com/NordicSemiconductor/Flutter-nRF-Connect-Device-Manager/members)
[![GitHub contributors](https://img.shields.io/github/contributors/NordicSemiconductor/Flutter-nRF-Connect-Device-Manager)](https://github.com/NordicSemiconductor/Flutter-nRF-Connect-Device-Manager/graphs/contributors)

___
## Supported Platforms
- Android: `minSdkVersion 19`
- iOS: `13.0`
- MacOS: `10.15`

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
// `firmware` is a List of Image objects
List<Image> firmwareImages = [];
for (final file in manifest.files) {
  final image = Image(
    image: file.image,
    data: firmwareFileData,
  );
  firmwareImages.add(image);
}

final configuration = const FirmwareUpgradeConfiguration(
      estimatedSwapTime: const Duration(seconds: 0),
      byteAlignment: ImageUploadAlignment.fourByte,
      eraseAppSettings: true,
      pipelineDepth: 1,
    );
// `configuration` is an optional parameter. If not provided, default values will be used.
updateManager.update(firmwareImages, configuration: configuration);
```

Alternatively, you can use `updateWithImageData` to update the device with a single image data:

```dart
await updateManager.updateWithImageData(image: fwImage!);
```

> [!TIP]
> `update` and `updateWithImageData` methods are asynchronous, however, they do not return a result of the update process. They only start the update process. To listen for updates, subscribe to the `updateStream` and `progressStream`. See also [Issue #63](https://github.com/NordicSemiconductor/Flutter-nRF-Connect-Device-Manager/issues/63) for more information.

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
To listen for logs, subscribe to the `logger.logMessageStream`:

```dart
updateManager.logger.logMessageStream
        .where((log) => log.level.rawValue > 1) // filter out debug messages
        .listen((log) {
      print(log.message);
    });
```

To read logs from the device, use `readLog` method:

```dart
List<McuLogMessage> logs =
        await updateManager.logger.readLogs(clearLogs: false);
```
