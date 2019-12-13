// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Marshal",
    products: [
        .library(name: "Marshal", targets: ["Marshal"]),
    ],
    targets: [
        .target(
            name: "Marshal",
	    dependencies: [],
	    path: "Sources"
        )
    ]
)

