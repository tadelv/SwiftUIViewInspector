# SwiftUIViewInspector

SwiftUIViewInspector is a library that makes it easier to inspect SwiftUI views in Xcode, providing a set of tools for debugging and testing your user interface. It's an incredibly useful add-on for Xcode previews. No more guessing or debugging - just easy, direct access to the data you need to fine-tune your user interface.

<br/>
<img src="https://user-images.githubusercontent.com/15943419/218100654-ad08710c-e04d-4b7b-89ca-b46925d097d5.png" width="300">

## Requirements

- iOS 13 or higher

## Installation

SwiftUIViewInspector can be installed using Swift Package Manager by adding the following line to your `Package.swift` file:

```.package(url: "https://github.com/tadelv/SwiftUIViewInspector.git", from: "0.1.0")```

## Usage

To use SwiftUIViewInspector, you need to add the following line of code to your `SceneDelegate.swift` file:

```Swift
import SwiftUIViewInspector
```

Then, in your `Scene` function, add the following line to inspect the view hierarchy of your SwiftUI app:

```Swift
let contentView = ContentView().inspectable()
```

Now, you can interact with the view hierarchy in Xcode, inspect the properties of each view, and see the layout and presentation details.

## License

SwiftUIViewInspector is available under the MIT license. See the LICENSE file for more information.
