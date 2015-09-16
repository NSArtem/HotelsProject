//
// Created by Artem Abramov on 16/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIRequest.h"

@interface APIRequest (Factory)

/*
 * u/109052005/1/0777.json
 */
+ (instancetype)requestOfHotelsList;
+ (instancetype)requestOfHotel:(NSNumber *)hotelID;

@end