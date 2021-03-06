//
// Created by Artem Abramov on 16/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

#import "APIRequest+Factory.h"
#import "Hotel.h"

@implementation APIRequest (Factory)

+ (instancetype)requestOfHotelsList {
    return [self requestWithResourceName:@"hotelsList.json"
                           responseClass:[Hotel class]
                                  method:@"GET"];
}

+ (instancetype)requestOfHotel:(NSNumber *)hotelID
{
    if (!hotelID) {
        return nil;
    }

    NSString *path = [NSString stringWithFormat:@"%@.json", hotelID.stringValue];
    return [self requestWithResourceName:path
                           responseClass:[Hotel class]
                                  method:@"GET"];
}

+ (instancetype)requestOfImage:(NSString *)imageURLPath;{
    if (!imageURLPath.length) {
        return nil;
    }

    NSString *path = [NSString stringWithFormat:@"%@", imageURLPath];
    APIRequest *request = [self requestWithResourceName:path
                                          responseClass:nil
                                                 method:@"GET"];
    request.requestType = Image;
    request.cropImage = YES;
    return request;
}

@end
