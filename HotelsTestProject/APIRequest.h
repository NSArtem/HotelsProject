//
// Created by Artem Abramov on 16/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface APIRequest : NSObject

@property (nonatomic, strong) NSNumber *itemID;
@property (nonatomic, copy) NSString *resourceName;
@property (nonatomic, strong) Class responseClass;
@property (nonatomic, copy) NSString *method;

- (instancetype)initWithResourceName:(NSString *)resourceName responseClass:(Class)responseClass method:(NSString *)method;
+ (instancetype)requestWithResourceName:(NSString *)resourceName responseClass:(Class)responseClass method:(NSString *)method;


@end