// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "freecustomemail",
    platforms: [
        .macOS(.v12), .iOS(.v15)
    ],
    products: [
        .library(name: "freecustomemail", targets: ["freecustomemail"]),
    ],
    targets: [
        .target(
            name: "freecustomemail",
            path: "src"
        ),
    ]
)
