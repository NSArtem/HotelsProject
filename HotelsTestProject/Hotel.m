//
// Created by Artem Abramov on 16/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

#import "Hotel.h"

@implementation Hotel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{   NSStringFromSelector(@selector(hotelID)): @"id",
                NSStringFromSelector(@selector(hotelName)): @"name",
                NSStringFromSelector(@selector(hotelAddress)): @"address",
                NSStringFromSelector(@selector(hotelStars)): @"stars",
                NSStringFromSelector(@selector(distance)): @"distance",
                NSStringFromSelector(@selector(suitesAvailable)): @"suites_availability" };
}

@end