//
// Created by Artem Abramov on 16/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

#import "Hotel.h"
#import "MTLValueTransformer.h"

@implementation Hotel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{   NSStringFromSelector(@selector(hotelID)): @"id",
                NSStringFromSelector(@selector(hotelName)): @"name",
                NSStringFromSelector(@selector(hotelAddress)): @"address",
                NSStringFromSelector(@selector(hotelStars)): @"stars",
                NSStringFromSelector(@selector(distance)): @"distance",
                NSStringFromSelector(@selector(imageURLPath)): @"image",
                NSStringFromSelector(@selector(latitude)): @"lat",
                NSStringFromSelector(@selector(longitude)): @"lon",
                NSStringFromSelector(@selector(suites)): @"suites_availability",
                NSStringFromSelector(@selector(suitesAvailable)): @"suites_availability" };
}

- (CLLocation *)location
{
    return [[CLLocation alloc] initWithLatitude:(CLLocationDegrees)[self.latitude doubleValue]
                                      longitude:(CLLocationDegrees)[self.longitude doubleValue]];
}

+ (NSValueTransformer *)suitesJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *suites, BOOL *success, NSError **error) {
        return [suites componentsSeparatedByString:@":"];
    }];
}

@end