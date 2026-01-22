// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "candle-swift-service-lifecycle",
    products: [
        .library(
            name: "CandleServiceLifecycle",
            targets: ["CandleServiceLifecycle"]
        ),
        .library(
            name: "ServiceLifecycleTestKit",
            targets: ["ServiceLifecycleTestKit"]
        ),
        .library(
            name: "CandleUnixSignals",
            targets: ["CandleUnixSignals"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/candlefinance/swift-log.git",
            branch: "fix-candle-1.6.3"
        ),
        .package(
            url: "https://github.com/candlefinance/swift-async-algorithms.git",
            branch: "fix-candle-1.0.4"
        ),
    ],
    targets: [
        .target(
            name: "CandleServiceLifecycle",
            dependencies: [
                .product(
                    name: "CandleLogging",
                    package: "swift-log"
                ),
                .product(
                    name: "CandleAsyncAlgorithms",
                    package: "swift-async-algorithms"
                ),
                .target(name: "CandleUnixSignals"),
                .target(name: "CandleConcurrencyHelpers"),
            ]
        ),
        .target(
            name: "ServiceLifecycleTestKit",
            dependencies: [
                .target(name: "CandleServiceLifecycle")
            ]
        ),
        .target(
            name: "CandleUnixSignals",
            dependencies: [
                .target(name: "CandleConcurrencyHelpers")
            ]
        ),
        .target(
            name: "CandleConcurrencyHelpers"
        ),
        .testTarget(
            name: "ServiceLifecycleTests",
            dependencies: [
                .target(name: "CandleServiceLifecycle"),
                .target(name: "ServiceLifecycleTestKit"),
            ]
        ),
        .testTarget(
            name: "UnixSignalsTests",
            dependencies: [
                .target(name: "CandleUnixSignals")
            ]
        ),
    ]
)

for target in package.targets {
    target.swiftSettings?.append(.enableUpcomingFeature("StrictConcurrency"))
}
