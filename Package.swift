// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MacsIslandStarter",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "MacsIslandStarter", targets: ["MacsIslandStarter"])],
    targets: [.executableTarget(name: "MacsIslandStarter")]
)
