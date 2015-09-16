//
// Created by Artem Abramov on 16/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

#import "APIRequest.h"


@implementation APIRequest
- (instancetype)initWithResourceName:(NSString *)resourceName responseClass:(Class)responseClass method:(NSString *)method {
    self = [super init];
    if (self) {
        self.resourceName = resourceName;
        self.responseClass = responseClass;
        self.method = method;
        self.requestType = JSON;
    }

    return self;
}

+ (instancetype)requestWithResourceName:(NSString *)resourceName responseClass:(Class)responseClass method:(NSString *)method {
    return [[self alloc] initWithResourceName:resourceName responseClass:responseClass method:method];
}


@end