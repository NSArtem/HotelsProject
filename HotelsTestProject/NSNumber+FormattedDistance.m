//
// Created by Artem Abramov on 17/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

#import "NSNumber+FormattedDistance.h"


@implementation NSNumber (FormattedDistance)

- (NSString *)formattedDistance {
    static NSNumberFormatter *formatter;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        formatter = [NSNumberFormatter new];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
    });
    
    return [formatter stringForObjectValue:self];
}
@end