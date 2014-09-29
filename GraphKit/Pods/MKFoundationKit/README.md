# MKFoundationKit

[![Twitter](https://img.shields.io/badge/contact-@MichalKonturek-blue.svg?style=flat)](http://twitter.com/michalkonturek)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/michalkonturek/MKFoundationKit/blob/master/LICENSE)
[![CocoaPods](https://img.shields.io/cocoapods/v/MKFoundationKit.svg?style=flat)](https://github.com/michalkonturek/MKFoundationKit)
[![Build Status](http://img.shields.io/travis/michalkonturek/MKFoundationKit.svg?style=flat)](https://travis-ci.org/michalkonturek/MKFoundationKit)

<!--[![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)](https://github.com/michalkonturek/MKFoundationKit/blob/master/LICENSE)
[![Build Platform](https://cocoapod-badges.herokuapp.com/p/MKFoundationKit/badge.png)](https://github.com/michalkonturek/MKFoundationKit)
[![Build Version](https://cocoapod-badges.herokuapp.com/v/MKFoundationKit/badge.png)](https://github.com/michalkonturek/MKFoundationKit)
[![Build Status](https://travis-ci.org/michalkonturek/MKFoundationKit.png?branch=master)](https://travis-ci.org/michalkonturek/MKFoundationKit)
-->

MKFoundationKit is a collection of categories for `NSFoundation` classes to accelerate development. 

This library is available through [CocoaPods][PODS].

## License

Source code of this project is available under the standard MIT license. Please see [the license file][LICENSE].

[PODS]:http://cocoapods.org/
[LICENSE]:https://github.com/michalkonturek/MKFoundation/blob/master/LICENSE


# API

* [NSArray](#nsarray-additions)
* [NSBundle](#nsbundle-additions)
* [NSData](#nsdata-additions)
* [NSDate](#nsdata-additions)
* [NSDictionary](#nsdictionary-additions)
* [NSNumber](#nsnumber-additions)
* [NSObject](#nsobject-additions)
* [NSSet](#nsset-additions)
* [NSString](#nsstring-additions)


## NSArray Additions

#### NSArray+MK_Block

```objc
- (void)mk_apply:(void (^)(id item))block;

- (void)mk_each:(void (^)(id item))block;

- (instancetype)mk_map:(id (^)(id item))block;

- (id)mk_match:(BOOL (^)(id item))block;

- (id)mk_reduce:(id (^)(id item, id aggregate))block;
- (id)mk_reduce:(id)initial withBlock:(id (^)(id item, id aggregate))block;

- (instancetype)mk_reject:(BOOL (^)(id item))block;

- (instancetype)mk_select:(BOOL (^)(id item))block;

- (BOOL)mk_all:(BOOL (^)(id item))block;

- (BOOL)mk_any:(BOOL (^)(id item))block;

- (BOOL)mk_none:(BOOL (^)(id item))block;
```

#### NSArray+MK_Misc

```objc
- (id)mk_firstObject;

- (id)mk_max;

- (id)mk_min;

- (instancetype)mk_reverse;

- (BOOL)mk_isEmpty;
```

#### NSMutableArray+MK_Misc

```objc
- (void)mk_safeAddObject:(id)object;
```

#### NSMutableArray+MK_Queue

```objc
- (void)mk_enqueueObject:(id)object;
- (id)mk_dequeueObject;
```

#### NSMutableArray+MK_Stack

```objc
- (void)mk_pushObject:(id)object;
- (id)mk_pullObject;
```

## NSBundle Additions

```objc
- (NSString *)mk_build;

- (NSString *)mk_name;

- (NSString *)mk_version;

- (NSString *)mk_infoForKey:(id)key;
```

## NSData Additions

### NSData+MK_Base64

```objc
+ (NSData *)mk_dataWithBase64EncodedString:(NSString *)string;

- (NSString *)mk_base64DecodedString;
- (NSString *)mk_base64EncodedString;
```

## NSDate Additions

#### NSDate+MK_Comparison

```objc
- (BOOL)mk_isToday;
- (BOOL)mk_isTomorrow;
- (BOOL)mk_isYesterday;

- (BOOL)mk_isThisWeek;
- (BOOL)mk_isNextWeek;
- (BOOL)mk_isLastWeek;
- (BOOL)mk_isSameWeekAsDate:(NSDate *)other;

- (BOOL)mk_isThisYear;
- (BOOL)mk_isNextYear;
- (BOOL)mk_isLastYear;
- (BOOL)mk_isSameYearAsDate:(NSDate *)other;

- (BOOL)mk_isEarlierThanDate:(NSDate *)other;
- (BOOL)mk_isLaterThanDate:(NSDate *)other;

- (BOOL)mk_isEqualToDateIgnoringTime:(NSDate *)other;
```

#### NSDate+MK_Components

```objc
- (NSInteger)mk_year;
- (NSInteger)mk_month;
- (NSInteger)mk_week;
- (NSInteger)mk_weekday;
- (NSInteger)mk_nthWeekday;
- (NSInteger)mk_day;
- (NSInteger)mk_hour;
- (NSInteger)mk_minutes;
- (NSInteger)mk_seconds;

- (NSDateComponents *)mk_components;
```

#### NSDate+MK_Creation

```objc
+ (NSDate *)mk_dateTomorrow;
+ (NSDate *)mk_dateYesterday;

+ (NSDate *)mk_dateWithoutTime;
+ (NSDate *)mk_dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)mk_dateFromString:(NSString *)string;
+ (NSDate *)mk_dateFromString:(NSString *)string withFormat:(NSString *)format;

- (NSDate *)mk_dateWithoutTime;
```

#### NSDate+MK_Formatting

```objc
+ (NSString *)mk_dateFormatCCCCDDMMMYYYY;
+ (NSString *)mk_dateFormatCCCCDDMMMMYYYY;

+ (NSString *)mk_dateFormatDDMMMYYYY;
+ (NSString *)mk_dateFormatDDMMYYYYDashed;
+ (NSString *)mk_dateFormatDDMMYYYYSlashed;

+ (NSString *)mk_dateFormatDDMMMYYYYSlashed;
+ (NSString *)mk_dateFormatMMMDDYYYY;
+ (NSString *)mk_dateFormatYYYYMMDDDashed;

- (NSString *)mk_formattedString;
- (NSString *)mk_formattedStringUsingFormat:(NSString *)dateFormat;
```

#### NSDate+MK_Manipulation

```objc
- (NSDate *)mk_dateByAddingDays:(NSInteger)days;
- (NSDate *)mk_dateByAddingWeeks:(NSInteger)weeks;
- (NSDate *)mk_dateByAddingMonths:(NSInteger)months;
- (NSDate *)mk_dateByAddingYears:(NSInteger)years;

- (NSDate *)mk_dateByAddingHours:(NSInteger)hours;
- (NSDate *)mk_dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)mk_dateByAddingSeconds:(NSInteger)seconds;

- (NSDate *)mk_dateBySubtractingDays:(NSInteger)days;
- (NSDate *)mk_dateBySubtractingWeeks:(NSInteger)weeks;
- (NSDate *)mk_dateBySubtractingMonths:(NSInteger)months;
- (NSDate *)mk_dateBySubtractingYears:(NSInteger)years;

- (NSDate *)mk_dateBySubtractingHours:(NSInteger)hours;
- (NSDate *)mk_dateBySubtractingMinutes:(NSInteger)minutes;
- (NSDate *)mk_dateBySubtractingSeconds:(NSInteger)seconds;

- (NSInteger)mk_differenceInDaysToDate:(NSDate *)toDate;
- (NSInteger)mk_differenceInMonthsToDate:(NSDate *)toDate;
- (NSInteger)mk_differenceInYearsToDate:(NSDate *)toDate;
```

<!--## NSDecimalNumber-->

## NSDictionary Additions

#### NSDictionary+MK_Block

```objc
- (void)mk_apply:(void (^)(id item))block;

- (void)mk_each:(void (^)(id item))block;

- (instancetype)mk_map:(id (^)(id item))selectorBlock;

- (id)mk_match:(BOOL (^)(id key, id value))conditionBlock;

- (id)mk_reduce:(id)initial withBlock:(id (^)(id item, id aggregate))accumulatorBlock;

- (instancetype)mk_reject:(BOOL (^)(id key, id value))conditionBlock;

- (instancetype)mk_select:(BOOL (^)(id key, id value))conditionBlock;

- (BOOL)mk_all:(BOOL (^)(id key, id value))conditionBlock;

- (BOOL)mk_any:(BOOL (^)(id key, id value))conditionBlock;

- (BOOL)mk_none:(BOOL (^)(id key, id value))conditionBlock;
```

#### NSDictionary+MK_Misc

```objc
- (NSMutableDictionary *)mk_dictionaryWithKeys:(NSArray *)keys;
- (NSMutableDictionary *)mk_renameKeysUsingMapping:(NSDictionary *)mapping;

- (BOOL)mk_isEmpty;
```

#### NSMutableDictionary+MK_Misc

```objc
- (void)mk_safeSetObject:(id)object forKey:(id)key;
```

## NSNumber Additions

#### NSNumber+MK_Comparison

```objc
- (BOOL)mk_isTheSame:(NSNumber *)other;

- (BOOL)mk_isGreaterThan:(NSNumber *)other;

- (BOOL)mk_isLessThan:(NSNumber *)other;

- (BOOL)mk_isEven;

- (BOOL)mk_isOdd;
```

#### NSNumber+MK_Creation

```objc
+ (instancetype)mk_createFrom:(NSNumber *)number;

- (NSDecimalNumber *)mk_decimalNumber;
```

#### NSNumber+MK_Fraction

```objc
- (instancetype)mk_integralPart;
- (instancetype)mk_fractionalPart;

- (BOOL)mk_isInteger;
- (BOOL)mk_isFraction;
```

#### NSNumber+MK_Manipulation

```objc
- (instancetype)mk_add:(NSNumber *)other;

- (instancetype)mk_subtract:(NSNumber *)other;

- (instancetype)mk_multiplyBy:(NSNumber *)other;

- (instancetype)mk_divideBy:(NSNumber *)other;

- (instancetype)mk_raiseToPower:(NSInteger)power;
```

#### NSNumber+MK_Negative

```objc
+ (instancetype)mk_minusOne;

- (instancetype)mk_negative;
- (instancetype)mk_positive;;

- (instancetype)mk_negate;

- (BOOL)mk_isPositive;
- (BOOL)mk_isNegative;
```

#### NSNumber+MK_Precison

```objc
+ (NSDecimalNumberHandler *)mk_decimalNumberHandlerWithScale:(short)scale;

- (instancetype)mk_roundedAsMoney;
- (instancetype)mk_roundedWithPrecision:(short)precision;
```

## NSObject Additions

#### NSObject+MK_AutoDescribe

```objc
+ (NSArray *)mk_propertyList;
+ (NSArray *)mk_propertyList:(Class)clazz;

+ (NSArray *)mk_methodListOnly;
+ (NSArray *)mk_methodListOnly:(Class)clazz;

+ (NSArray *)mk_methodList;
+ (NSArray *)mk_methodList:(Class)clazz;

- (void)mk_printObject;
- (void)mk_printObjectKeys:(NSArray *)keys;

- (void)mk_printObjectMethods;
- (void)mk_printObjectMethodsOnly;

- (NSString *)mk_className;
```

## NSSet Additions

#### NSSet+MK_Block

```objc
- (void)mk_apply:(void (^)(id item))block;

- (void)mk_each:(void (^)(id item))block;

- (instancetype)mk_map:(id (^)(id item))selectorBlock;

- (id)mk_match:(BOOL (^)(id item))conditionBlock;

- (id)mk_reduce:(id)initial withBlock:(id (^)(id item, id aggregate))accumulatorBlock;

- (instancetype)mk_reject:(BOOL (^)(id item))conditionBlock;

- (instancetype)mk_select:(BOOL (^)(id item))conditionBlock;

- (BOOL)mk_all:(BOOL (^)(id item))conditionBlock;

- (BOOL)mk_any:(BOOL (^)(id item))conditionBlock;

- (BOOL)mk_none:(BOOL (^)(id item))conditionBlock;
```

## NSString Additions

#### NSString+MK_Base64

```objc
- (NSString *)mk_base64DecodedString;
- (NSString *)mk_base64EncodedString;

- (NSData *)mk_base64DecodedData;
- (NSData *)mk_base64EncodedData;
```

#### NSString+MK_Conversion

```objc
- (NSNumber *)mk_numberWithInteger;
- (NSNumber *)mk_numberWithLongLong;
```

#### NSString+MK_Empty

```objc
+ (BOOL)mk_isStringEmptyOrNil:(NSString *)value;

- (BOOL)mk_isEmpty;
- (NSString *)mk_trimmedString;
```

#### NSString+MK_Misc

```objc
- (NSString *)mk_firstComponentUsingSeparators:(NSCharacterSet *)separators;
- (NSString *)mk_lastComponentUsingSeparators:(NSCharacterSet *)separators;
- (NSString *)mk_componentAtIndex:(NSInteger)index usingSeparators:(NSCharacterSet *)separators;

- (BOOL)mk_containsString:(NSString *)term caseSensitive:(BOOL)caseSensitive;

- (NSInteger)mk_countOccurencesOfString:(NSString *)term;
- (NSInteger)mk_countOccurencesOfString:(NSString *)term caseSensitive:(BOOL)caseSensitive;

- (NSInteger)mk_countOccurencesOfStrings:(NSArray *)terms;
- (NSInteger)mk_countOccurencesOfStrings:(NSArray *)terms caseSensitive:(BOOL)caseSensitive;

- (NSRange)mk_range;
```

#### NSString+MK_UTF

```objc
+ (NSString *)mk_decodeUTF8String:(NSString *)value;

- (NSString *)mk_decodeUTF8;
```

#### NSString+MK_UUID

```objc
+ (NSString *)mk_stringWithUUID;
```

#### NSString+MK_Validation

```objc
+ (BOOL)mk_isStringValidEmail:(NSString *)email;

- (BOOL)mk_isValidEmail;

- (BOOL)mk_matchesRegex:(NSString *)regex;
```

## Contributing

1. Fork it.
2. Create your feature branch (`git checkout -b new-feature`).
3. Commit your changes (`git commit -am 'Added new-feature'`).
4. Push to the branch (`git push origin new-feature`).
5. Create new Pull Request.


<!--- - - 

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/michalkonturek/mkfoundationkit/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

-->

