# AudioManager

Simple wrapper for AVAudioSession.

# Getting Started

## Installing

### Swift Package Manager

To include AudioManager into a Swift Package Manger package add the `dependencies` value in your `Package.swift`:

```
dependencies: [
    .package(url: "https://github.com/robinlieb/AudioManager.git", from: "0.0.2")
]
```

### CocoaPods

To include AudioManager into your CocoaPods project add it into your `Podfile`:

```
pod 'AudioManager', '~> 0.0.2'
```

## Usage

You can use AudioManager over a singleton instance. 

```swift
AudioManager.shared.playAudio(audioFileName: "testAudio")
AudioManager.shared.playAudio(audioFileName: "testAudio", volume: 0.2, audioFileType: "mp3")
```

# Requirements

*  iOS 10.0+
*  Xcode 10.2+
*  Swift 5+

Before using AudioManager ensure you have included the `AVFoundation.framework` in your project.

# License

Licensed under MIT license, see [LICENSE](License.md).
