# Keyboard

[![Version](https://img.shields.io/cocoapods/v/Keyboard.svg?style=flat)](https://cocoapods.org/pods/Keyboard)
[![License](https://img.shields.io/cocoapods/l/Keyboard.svg?style=flat)](https://cocoapods.org/pods/Keyboard)
[![Platform](https://img.shields.io/cocoapods/p/Keyboard.svg?style=flat)](https://cocoapods.org/pods/Keyboard)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* Xcode 9.0+
* iOS 8.0+

## Installation

Keyboard is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Keyboard'
```

## Usage

You can use Keyboard in UIViewController or any UIView with inputAccessoryView (UITextField, UISearchBar, UITextView). Simply call 'keyboard' and configure it with the items you want. An example:

```swift
let cancelItem = KeyboardItem.barButton(title: "Cancel", style: .plain) { _ in
    self.textView.endEditing(true)
}

let countLabel = UILabel()
countLabel.text = "0"
let labelItem = KeyboardItem.custom(view: countLabel)

let doneItem = KeyboardItem.barButton(title: "Done", style: .done) { _ in
    self.textView.endEditing(true)
}

textView.keyboard.with(items: cancelItem, .flexibleSpace, labelItem, .flexibleSpace, doneItem)
```

![alt text](https://github.com/adboco/Keyboard/blob/master/Assets/keyboard1.png "Keyboard")

### KeyboardItem

```swift
/// Default bar button item
case barButton(title: String, style: UIBarButtonItemStyle, action: UIBarButtonItemTargetClosure?)

/// System bar button item
case systemBarButton(system: UIBarButtonSystemItem, action: UIBarButtonItemTargetClosure?)

/// Flexible space
case flexibleSpace

/// Fixed space
case fixedSpace(width: CGFloat)

/// Custom view
case custom(view: UIView)
```

### Customize

You can customize the accessoryView made by Keyboard calling 'customize' method:

```swift
textView.keyboard.customize { (toolbar, items) in
    toolbar.isTranslucent = false
    toolbar.tintColor = .purple
}
```

### Keyboard Events

Only available in ``UIViewController``:

```swift
case willShow
case willHide
case didShow
case didHide
```

Example:

```swift
override func viewDidLoad() {
	super.viewDidLoad()

	// Subscribe
	self.keyboard.subscribe(to: .willShow) { sender in
	    // TODO: something to do when keyboard will be shown
	}

	// ...

	// Unsubscribe
	self.keyboard.unsubscribe()
}
```

## Author

adboco@telefonica.net, Adrián Bouza Correa

## License

Keyboard is available under the MIT license. See the LICENSE file for more info.
