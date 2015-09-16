//
//  RequestOperationManager.m
//  HotelsTestProject
//
//  Created by Artem Abramov on 16/09/15.
//  Copyright © 2015 Artem Abramov. All rights reserved.
//

#import "RequestOperationManager.h"
#import "APIRequest.h"
#import "APIResponseSerializer.h"

static NSString * const kBaseURL = @"https://dl.dropboxusercontent.com";

@interface RequestOperationManager()

@end

@implementation RequestOperationManager

+ (RequestOperationManager *)manager {
    static dispatch_once_t once;
    static RequestOperationManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    });
    return sharedInstance;
}

- (AFHTTPRequestOperation *)fetch:(APIRequest *)request
                          success:(SHHTTPRequestSucessBlock)success
                          failure:(SHHTTPRequestFailureBlock)failure
{
    AFHTTPRequestOperation *operation = [self operationWithRequest:request success:success failure:failure];
    [operation start];
    return operation;
}

- (AFHTTPRequestOperation *)operationWithRequest:(APIRequest *)request
                                     success:(SHHTTPRequestSucessBlock)success
                                     failure:(SHHTTPRequestFailureBlock)failure
{
    if (!request) {
        NSLog(@"Request can not be nil");
        NSError *error = [NSError errorWithDomain:NSStringFromClass([self class])
                                             code:-1 //TODO: introduce enum with errors
                                         userInfo:@{NSLocalizedDescriptionKey : @"Request can't be nil"}];
        if (failure) {
            failure(nil, error);
        }
    }
    NSString *urlString = [[NSURL URLWithString:request.resourceName relativeToURL:self.baseURL] absoluteString];
    NSError *error = nil;
    NSMutableURLRequest *urlRequest = [self.requestSerializer requestWithMethod:request.method
                                                                      URLString:urlString
                                                                     parameters:nil //TODO: we may need to introduce params
                                                                          error:&error];

    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:urlRequest
                                                        success:success
                                                        failure:failure];

    operation.responseSerializer = [APIResponseSerializer serializerWithModelClass:request.responseClass];
    return operation;
}

@end
