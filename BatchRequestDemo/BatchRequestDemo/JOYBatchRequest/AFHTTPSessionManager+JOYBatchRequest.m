//
//  AFHTTPSessionManager+JOYBatchRequest.m
//  BatchRequestDemo
//
//  Created by Ssuperjoy on 2017/9/19.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "AFHTTPSessionManager+JOYBatchRequest.h"
#import "NSURLRequest+JOYBatchRequest.h"

@implementation AFHTTPSessionManager (JOYBatchRequest)

- (void)joy_batchRequestWithRequestArray:(NSArray<NSURLRequest *> *)requestArray completionBlockWithSuccess:(void(^)())success failure:(void(^)(NSError *error))failure
{
    dispatch_group_t group = dispatch_group_create();
    
    __block BOOL isSucess = NO;
    __block NSError *lastError;
    for (NSMutableURLRequest *request in requestArray) {
        if (request) {
            dispatch_group_enter(group); 
            __block NSURLSessionDataTask *dataTask = nil;
            dataTask = [self dataTaskWithRequest:request
                                  uploadProgress:nil
                                downloadProgress:nil
                               completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                                   dispatch_group_leave(group);
                                   
                                   if (error) {
                                       if (request.joy_completionBlock) {
                                           request.joy_completionBlock(nil, error);
                                       }
                                       request.joy_error = error;
                                       lastError = error;
                                   } else {
                                       if (request.joy_completionBlock) {
                                           request.joy_completionBlock(responseObject, nil);
                                       }
                                       isSucess = YES;
                                   }
                               }];
            [dataTask resume];
        }
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (isSucess) {
            if (success) {
                success();
            }
        } else {
            if (failure) {
                failure(lastError);
            }
        }
    });    
}

@end
