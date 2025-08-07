// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
//  Generated file. Do not edit.
//

import PackageDescription

let package = Package(
    name: "FlutterGeneratedPluginSwiftPackage",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "FlutterGeneratedPluginSwiftPackage", type: .static, targets: ["FlutterGeneratedPluginSwiftPackage"])
    ],
    dependencies: [
        .package(name: "file_picker", path: "/Users/krmob/.pub-cache/hosted/pub.dev/file_picker-10.2.1/ios/file_picker"),
        .package(name: "flutter_blue_plus_darwin", path: "/Users/krmob/.pub-cache/hosted/pub.dev/flutter_blue_plus_darwin-4.0.1/darwin/flutter_blue_plus_darwin"),
        .package(name: "path_provider_foundation", path: "/Users/krmob/.pub-cache/hosted/pub.dev/path_provider_foundation-2.4.1/darwin/path_provider_foundation")
    ],
    targets: [
        .target(
            name: "FlutterGeneratedPluginSwiftPackage",
            dependencies: [
                .product(name: "file-picker", package: "file_picker"),
                .product(name: "flutter-blue-plus-darwin", package: "flutter_blue_plus_darwin"),
                .product(name: "path-provider-foundation", package: "path_provider_foundation")
            ]
        )
    ]
)
