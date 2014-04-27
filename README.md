# GraphKit

[![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)](https://github.com/michalkonturek/GraphKit/blob/master/LICENSE)
[![Build Platform](https://cocoapod-badges.herokuapp.com/p/GraphKit/badge.png)](https://github.com/michalkonturek/GraphKit)
[![Build Version](https://cocoapod-badges.herokuapp.com/v/GraphKit/badge.png)](https://github.com/michalkonturek/GraphKit)

A lightweight library of animated charts for iOS.


## License

Source code of this project is available under the standard MIT license. Please see [the license file][LICENSE].

[PODS]:http://cocoapods.org/
[LICENSE]:https://github.com/michalkonturek/GraphKit/blob/master/LICENSE


## Usage

### Bar Graph

![Build Platform](images/bar-graph.png)

Initialize `GKBarGraph` from nib or programmatically:

```
CGRect frame = CGRectMake(0, 40, 320, 200);
self.graphView = [[GKBarGraph alloc] initWithFrame:frame];
```

then set `GKGraphViewDataSource` 

```
self.graphView.dataSource = self;
```

and call `draw` method.

```
[self.graphView draw];
```


Please see [example][BAR].

[BAR]:https://github.com/michalkonturek/GraphKit/blob/master/GraphKit/Example/ExampleBarGraphVC.m


#### `GKBarGraphDataSource` Protocol

```
@required
- (NSInteger)numberOfBars;
- (NSNumber *)valueForBarAtIndex:(NSInteger)index;

@optional
- (UIColor *)colorForBarAtIndex:(NSInteger)index;
- (CFTimeInterval)animationDurationForBarAtIndex:(NSInteger)index;
- (NSString *)titleForBarAtIndex:(NSInteger)index;
```


### Line Graph

![Build Platform](images/line-graph.png)

```
CGRect frame = CGRectMake(0, 40, 320, 200);
self.graphView = [[GKLineGraph alloc] initWithFrame:frame];

self.graph.dataSource = self;
self.graph.lineWidth = 3.0;

[self.graph draw];
```

Please see [example][LINE].

[LINE]:https://github.com/michalkonturek/GraphKit/blob/master/GraphKit/Example/ExampleLineGraph.m


#### `GKLineGraphDataSource` Protocol

```
@required
- (NSInteger)numberOfLines;
- (UIColor *)colorForLineAtIndex:(NSInteger)index;
- (NSArray *)valuesForLineAtIndex:(NSInteger)index;

@optional
- (CFTimeInterval)animationDurationForLineAtIndex:(NSInteger)index;
- (NSString *)titleForLineAtIndex:(NSInteger)index;
```

[@MichalKonturek](https://twitter.com/MichalKonturek)

