//
//  NSArray+MK_Misc.m
//  MKFoundation
//
//  Copyright (c) 2013 Michal Konturek
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "NSArray+MK_Misc.h"

#import "NSArray+MK_Block.h"

@implementation NSArray (MK_Misc)

- (id)mk_firstObject {
    if ([self mk_isEmpty]) return nil;
    return [self objectAtIndex:0];
}

- (id)mk_max {
    if ([self mk_isEmpty]) return [NSDecimalNumber zero];
    
    return [self mk_reduce:^id(id item, id aggregate) {
        return ([item compare:aggregate] == NSOrderedDescending) ? item : aggregate;
    }];
}

- (id)mk_min {
    if ([self mk_isEmpty]) return [NSDecimalNumber zero];
    
    return [self mk_reduce:^id(id item, id aggregate) {
        return ([item compare:aggregate] == NSOrderedAscending) ? item : aggregate;
    }];
}

- (instancetype)mk_reverse {
    return [[[self reverseObjectEnumerator] allObjects] mutableCopy];
}

- (BOOL)mk_isEmpty {
    return ([self count] == 0);
}

@end
