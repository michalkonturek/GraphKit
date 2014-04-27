# FrameAccessor

Easy way to access view's frame in iOS and OSX.

## Compatibility

* iOS 4.3 or higher
* OSX 10.6 or higher


## Installation

### CocoaPods

The recommended approach for installating `FrameAccessor` is via the [CocoaPods](http://cocoapods.org/) package manager, as it provides flexible dependency management and dead simple installation.
For best results, it is recommended that you install via CocoaPods >= **0.27.0** using Git >= **1.8.0** installed via Homebrew.

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```

Change to the directory of your Xcode project:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
```

Edit your Podfile and add `FrameAccessor`:

``` bash
pod 'FrameAccessor'
```

Install into your Xcode project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file)

``` bash
$ open MyProject.xcworkspace
```

Please note that if your installation fails, it may be because you are installing with a version of Git lower than CocoaPods is expecting. Please ensure that you are running Git >= **1.8.0** by executing `git --version`. You can get a full picture of the installation details by executing `pod install --verbose`.

### Manual Install

All you need to do is drop `FrameAccessor` files into your project, and add `#include "FrameAccessor.h"` to the top of files that will use it.

## Example Usage

```objective-c
view.x = 15.;
view.width = 167.;
```
instead of
```objective-c
CGRect newFrame = view.frame;
newFrame.origin.x = 15.;
newFrame.size.width = 167.;
view.frame = newFrame;
```

## Available Properties

`UIView/NSView` properties:

Property | Type | Аvailability
--- | --- | ---
`origin` | `CGPoint` | *readwrite*
`size` | `CGSize` | *readwrite*
`x`, `y` | `CGFloat` | *readwrite*
`width`, `height` | `CGFloat` | *readwrite*
`top`, `left`, `bottom`, `right` | `CGFloat` | *readwrite*
`centerX`, `centerY` | `CGFloat` | *readwrite*
`middlePoint` | `CGPoint` | **readonly**
`middleX`, `middleY` | `CGFloat` | **readonly**

`UIScrollView` properties:

Property | Type | Аvailability
--- | --- | ---
`contentOffsetX`, `contentOffsetY` | `CGFloat` | *readwrite*
`contentSizeWidth`, `contentSizeHeight` | `CGFloat` | *readwrite*
`contentInsetTop`, `contentInsetLeft`, <br>`contentInsetBottom`, `contentInsetRight` | `CGFloat` | *readwrite*

## License

FrameAccessor is available under the MIT license.

Copyright (c) 2012 Alexey Denisov

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

