// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FieldInputNavigationToolbar",
	platforms: [.iOS(.v26)],
    products: [.library(name: "FieldInputNavigationToolbar", targets: ["FieldInputNavigationToolbar"])],
    targets: [.target(name: "FieldInputNavigationToolbar", dependencies: [])]
)
