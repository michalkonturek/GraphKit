# BButton [![Build Status](https://secure.travis-ci.org/jessesquires/BButton.png)](http://travis-ci.org/jessesquires/BButton) [![Version Status](https://cocoapod-badges.herokuapp.com/v/BButton/badge.png)][docsLink]

[Twitter Bootstrap](http://getbootstrap.com) buttons for iOS.

`BButton` is a subclass of `UIButton` that is styled like the Twitter Bootstrap buttons, and is drawn entirely with `CoreGraphics`.

![BButton Screenshot 1][img1] &nbsp;&nbsp;&nbsp;&nbsp; ![BButton Screenshot 2][img2]

## Features

* Works just like `UIButton`, but sexier
* Bootstrap [version 2](http://getbootstrap.com/2.3.2/) or [version 3](http://getbootstrap.com) styles
* Highly customizable
* Includes [@leberwurstsaft / FontAwesome-for-iOS](https://github.com/leberwurstsaft/FontAwesome-for-iOS), fixed for iOS from the original [FontAwesome](http://fortawesome.github.com/Font-Awesome/)

## Requirements

* iOS 6.0+ 
* ARC

## Installation

#### From [CocoaPods](http://www.cocoapods.org)

`pod 'BButton'`

#### From source

* Drag the `BButton/` folder to your project.
* Add the `Fonts provided by application` key to `Info.plist` and include `FontAwesome.ttf`

![plist][img3]

#### Too cool for [ARC](https://developer.apple.com/library/mac/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html)?

* Add the `-fobjc-arc` compiler flag to all source files in your project in Target Settings > Build Phases > Compile Sources.

## Getting Started

1. Create programmatically via one of the `init` methods
2. Create via Storyboards
  * Drag a `UIButton` to your view
  * Set its class to `BButton`
3. Be a badass [programming-motherfucker](http://programming-motherfucker.com) and read the fucking documentation. (Yes, there's documentation! [Seriously](http://www.nrcc.org/wp-content/uploads/2013/05/Moonwalk.gif)!)
4. See the included demo project: `BButtonDemo.xcodeproj`
5. See `FontAwesomeIcons.html` for list of icons

## Documentation

Documentation is [available here][docsLink] via [CocoaDocs](http://cocoadocs.org). Thanks [@CocoaDocs](https://twitter.com/CocoaDocs)!

## Customization

* Set corner radius for all buttons via `UIAppearance`

````objective-c
[[BButton appearance] setButtonCornerRadius:[NSNumber numberWithFloat:0.0f]];
````

![BButton Screenshot 3][img4] &nbsp;&nbsp;&nbsp;&nbsp; ![BButton Screenshot 4][img5]

* *More tips coming soon!*

## How To Contribute

1. [Find an issue](https://github.com/jessesquires/BButton/issues?sort=created&state=open) to work on, or create a new one.
2. Fork me.
3. Create a new branch with a sweet fucking name: `git checkout -b issue_<##>_<featureOrFix>`.
4. Do some motherfucking programming
5. Write Unit Tests, if you can
6. Keep your code nice and clean by adhering to Google's [Objective-C Style Guide](http://google-styleguide.googlecode.com/svn/trunk/objcguide.xml) and Apple's [Coding Guidelines for Cocoa](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CodingGuidelines/CodingGuidelines.html).
7. Don't break shit, especially `master`.
8. Update the documentation header comments.
9. Update the pod spec and project version numbers, adhering to the [semantic versioning](http://semver.org) specification.
10. Submit a pull request.
11. See step 1.

## Credits

Created by [@Mathieu Bolard](https://twitter.com/mattlawer) (Original project here: [@mattlawer / BButton](https://github.com/mattlawer/BButton)).

Forked, refactored, updated, maintained by [@Jesse Squires](https://twitter.com/jesse_squires), a [programming-motherfucker](http://programming-motherfucker.com).

FontAwesome-for-iOS by Pit Garbe, [@leberwurstsaft / FontAwesome-for-iOS](https://github.com/leberwurstsaft/FontAwesome-for-iOS).

Many thanks to [the contributors](https://github.com/jessesquires/BButton/graphs/contributors) of this project.

## Apps Using This Control

[Gitty for GitHub](https://itunes.apple.com/us/app/gitty-for-github/id645696309?mt=8)

[Hemoglobe](http://bit.ly/hemoglobeapp)

[iPaint uPaint](http://bit.ly/ipupappstr)

[Audiotrip](https://itunes.apple.com/us/app/audiotrip/id569634193?mt=8)

[iExplorer for DeviantART](https://itunes.apple.com/us/app/iexplorer-for-deviantart/id657212778?mt=8)

*[Contact me](mailto:jesse.squires.developer@gmail.com) to have your app listed here.*

## [MIT License](http://opensource.org/licenses/MIT)

Copyright &copy; 2012, Mathieu Bolard, Jesse Squires. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

##[FontAwesome](https://github.com/FortAwesome/Font-Awesome) License

* The Font Awesome font is licensed under the [SIL Open Font License](http://scripts.sil.org/OFL)
* Font Awesome CSS, LESS, and SASS files are licensed under the [MIT License](http://opensource.org/licenses/mit-license.html)
* The Font Awesome pictograms are licensed under the [CC BY 3.0 License](http://creativecommons.org/licenses/by/3.0)
* Attribution is no longer required in Font Awesome 3.0, but much appreciated:
	* *"Font Awesome by Dave Gandy - http://fortawesome.github.com/Font-Awesome"*

[docsLink]:http://cocoadocs.org/docsets/BButton/3.2.3

[img1]:https://raw.github.com/jessesquires/BButton/master/Screenshots/screenshot-0.png
[img2]:https://raw.github.com/jessesquires/BButton/master/Screenshots/screenshot-2.png
[img3]:https://raw.github.com/jessesquires/BButton/master/Screenshots/plist.png
[img4]:https://raw.github.com/jessesquires/BButton/master/Screenshots/screenshot-4.png
[img5]:https://raw.github.com/jessesquires/BButton/master/Screenshots/screenshot-5.png
