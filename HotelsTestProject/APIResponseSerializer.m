//
// Created by Artem Abramov on 16/09/15.
// Copyright (c) 2015 Artem Abramov. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/MTLJSONAdapter.h>
#import "APIResponseSerializer.h"


@implementation APIResponseSerializer

- (instancetype)initWithModelClass:(Class)modelClass {
    self = [super init];
    if (self) {
        self.modelClass = modelClass;
        self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    }

    return self;
}

+ (instancetype)serializerWithModelClass:(Class)modelClass {
    return [[self alloc] initWithModelClass:modelClass];
}

- (nullable id)responseObjectForResponse:(nullable NSURLResponse *)response data:(nullable NSData *)data error:(NSError *__nullable __autoreleasing *)error {
    id responseObject = [super responseObjectForResponse:response data:data error:error];

    id responseModel;
    if ([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSArray class]]) {
        @try {
            if ([responseObject isKindOfClass:[NSDictionary class]])
                responseModel = [MTLJSONAdapter modelOfClass:self.modelClass
                                          fromJSONDictionary:responseObject
                                                       error:error];
            else
                responseModel = [MTLJSONAdapter modelsOfClass:self.modelClass
                                                fromJSONArray:responseObject
                                                        error:error];
            return responseModel;
        }
        @catch (NSException *exception) {
            NSLog(@"Failed to serialize: %@", responseObject);
            *error = [NSError errorWithDomain:NSStringFromClass([self class])
                                         code:-1
                                     userInfo:exception.userInfo];
            return nil;
        }
    }  else {
        NSLog(@"JSON object is incorrect: %@", responseObject);
        *error = [NSError errorWithDomain:NSStringFromClass([self class])
                                     code:-1
                                 userInfo:@{NSLocalizedDescriptionKey : @"JSON object is incorrect"}];
        return nil;
    }
    return nil;
}


@end