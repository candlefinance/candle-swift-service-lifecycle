// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "swift-service-lifecycle",
    products: [
        .library(
            name: "CandleServiceLifecycle",
            targets: ["CandleServiceLifecycle"]
        ),
        .library(
            name: "CandleUnixSignals",
            targets: ["CandleUnixSignals"]
        ),
    ],
    dependencies: [
        .package(name: "candle-swift-log", url: "https://github.com/candlefinance/candle-swift-log.git",
            branch: "fix-candle-1.6.3"
        ),
        .package(name: "candle-swift-async-algorithms", url: "https://github.com/candlefinance/candle-swift-async-algorithms.git",
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
            name: "CandleUnixSignals",
            dependencies: [
                .target(name: "CandleConcurrencyHelpers")
            ]
        ),
        .target(
            name: "CandleConcurrencyHelpers"
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
