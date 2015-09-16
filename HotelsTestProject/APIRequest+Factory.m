//
// Created by Artem Abramov on 16/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

#import "APIRequest+Factory.h"
#import "Hotel.h"


@implementation APIRequest (Factory)

+ (instancetype)requestOfHotelsList {
    return [self requestWithResourceName:@"u/109052005/1/0777.json"
                           responseClass:[Hotel class]
                                  method:@"GET"];
}

@end