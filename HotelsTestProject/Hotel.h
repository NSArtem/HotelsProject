//
// Created by Artem Abramov on 16/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

@import Foundation;
@import CoreLocation;

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Hotel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *hotelID;
@property (nonatomic, copy) NSString *hotelName;
@property (nonatomic, copy) NSString *hotelAddress;
@property (nonatomic, strong) NSNumber *hotelStars;
@property (nonatomic, strong) NSNumber *distance;
@property (nonatomic, copy) NSString *suitesAvailable; //TODO: Map to NSSet of suites
@property (nonatomic, copy) NSString *imageURLPath;
@property (nonatomic, strong) CLLocation *location;

//Response example:
//{
//    "id": 40611,
//    "name": "Belleclaire Hotel",
//    "address": "250 West 77th Street, Manhattan",
//    "stars": 3.0,
//    "distance": 100.0,
//    "suites_availability": "1:44:21:87:99:34"
//}

@end