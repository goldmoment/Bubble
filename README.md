# Bubble

[![CI Status](http://img.shields.io/travis/goldmoment/Bubble.svg?style=flat)](https://travis-ci.org/goldmoment/Bubble)
[![Version](https://img.shields.io/cocoapods/v/Bubble.svg?style=flat)](http://cocoapods.org/pods/Bubble)
[![License](https://img.shields.io/cocoapods/l/Bubble.svg?style=flat)](http://cocoapods.org/pods/Bubble)
[![Platform](https://img.shields.io/cocoapods/p/Bubble.svg?style=flat)](http://cocoapods.org/pods/Bubble)

## Example
[![Demo 1](https://media.giphy.com/media/AMPOAkTWG9rA4/giphy.gif)](https://media.giphy.com/media/AMPOAkTWG9rA4/source.mp4)
[![Demo 2](https://media.giphy.com/media/Ydj5Vi19TF076/giphy.gif)](https://media.giphy.com/media/Ydj5Vi19TF076/source.mp4)
[![Demo 3](https://media.giphy.com/media/H0imirCsaJjoI/giphy.gif)](https://media.giphy.com/media/H0imirCsaJjoI/source.mp4)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

XCode 9.0, Swift 4.0

## Installation

Bubble is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Bubble"
```

## Usage

Default

```swift
Bubble.showLogo()
Bubble.hideLogo()
```

Custom

```swift
// Set color of the mask view
Bubble.maskColor = UIColor.black

// Show logo with scale mode and touchable setting
Bubble.showLogo(with: .scaleAspectFill, touchable: false)
```

## Author

goldmoment, nguyenvanvienqn@gmail.com

## License

Bubble is available under the MIT license. See the LICENSE file for more info.
