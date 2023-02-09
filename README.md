# SwiftUIViewInspector

SwiftUIViewInspector is a library that makes it easier to inspect SwiftUI views in Xcode, providing a set of tools for debugging and testing your user interface.

## Requirements

- Xcode 12 or later
- Swift 5.3 or later

## Installation

SwiftUIViewInspector can be installed using Swift Package Manager by adding the following line to your `Package.swift` file:

```.package(url: "https://github.com/tadelv/SwiftUIViewInspector.git", from: "0.1.0")```

## Usage

To use SwiftUIViewInspector, you need to add the following line of code to your `SceneDelegate.swift` file:

```import SwiftUIViewInspector```

Then, in your `Scene` function, add the following line to inspect the view hierarchy of your SwiftUI app:

```let contentView = ContentView().inspect()```

Now, you can interact with the view hierarchy in Xcode, inspect the properties of each view, and see the layout and presentation details.

## License

SwiftUIViewInspector is available under the MIT license. See the LICENSE file for more information.
