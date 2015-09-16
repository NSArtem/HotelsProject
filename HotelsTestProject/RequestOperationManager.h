//
//  RequestOperationManager.h
//  HotelsTestProject
//
//  Created by Artem Abramov on 16/09/15.
//  Copyright © 2015 Artem Abramov. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@class APIRequest;

typedef void (^SHHTTPRequestSucessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^SHHTTPRequestFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface RequestOperationManager : AFHTTPRequestOperationManager

- (AFHTTPRequestOperation *)fetch:(APIRequest *)request
                          success:(SHHTTPRequestSucessBlock)success
                          failure:(SHHTTPRequestFailureBlock)failure;

@end
