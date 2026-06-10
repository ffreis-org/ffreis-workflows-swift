// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "hello",
    targets: [
        .target(name: "hello"),
        .testTarget(name: "helloTests", dependencies: ["hello"]),
    ]
)
