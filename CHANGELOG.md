## 0.4.0
Read image list (#66):
- Added method to read image list. Based on [Android](https://github.com/NordicSemiconductor/Android-nRF-Connect-Device-Manager/blob/cc947d4fe003b5facd8fd03cb005197774bb3e89/mcumgr-core/src/main/java/io/runtime/mcumgr/managers/ImageManager.java#L228) and [iOS](https://github.com/NordicSemiconductor/IOS-nRF-Connect-Device-Manager/blob/d46c9ff85c87e786e8550fc3f4d633b1bc5c67be/Source/Managers/ImageManager.swift#L81) implementations.

## 0.3.3
Feature/config for single image update (#61)

* Added configuration parameter for single image update to protobuf definition
* Added configuration parameter in ios code
* Added configuration parameter in android
* Added configuration parameter in flutter

## 0.3.0+1
- New Log System
- Method `FirmwareUpdateManager.updateWithImageData` added to update firmware with single image data (Single Core)

## 0.2.0+1
- Direct XIP support added
- `FirmwareUpgradeMode` can be passed as a parameter to `FirmwareUpgradeConfiguration`.
- Upgraded dependencies.

## 0.1.1+1

* First public beta release
* Added library to pub.dev
