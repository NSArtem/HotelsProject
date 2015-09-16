//
// Created by Artem Abramov on 16/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLResponseSerialization.h"


@interface APIResponseSerializer : AFJSONResponseSerializer

@property (nonatomic, strong) Class modelClass;

- (instancetype)initWithModelClass:(Class)modelClass;
+ (instancetype)serializerWithModelClass:(Class)modelClass;


@end