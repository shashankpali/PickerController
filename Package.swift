// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PickerController",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PickerController",
            targets: ["PickerController"]),
    ],
    targets: [
        .target(
            name: "PickerController",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "PickerControllerTests",
            dependencies: ["PickerController"]),
    ]
)
