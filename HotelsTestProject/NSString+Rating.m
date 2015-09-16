//
// Created by Artem Abramov on 16/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

#import "NSString+Rating.h"


@implementation NSString (Rating)

+ (instancetype)ratingForNumber:(NSNumber *)number
{
    if (number && number.integerValue > 0) {
        NSUInteger stars = (NSUInteger) ((number.integerValue <= 5) ? number.integerValue : 5);
        return [@"" stringByPaddingToLength:stars withString:@"★" startingAtIndex:0];
    } else {
        return @"Rating unavailable";
    }
}
@end