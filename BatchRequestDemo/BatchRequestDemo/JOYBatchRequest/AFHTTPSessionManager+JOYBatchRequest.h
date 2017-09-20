//
//  AFHTTPSessionManager+JOYBatchRequest.h
//  BatchRequestDemo
//
//  Created by Ssuperjoy on 2017/9/19.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFHTTPSessionManager (JOYBatchRequest)


/**
 批量请求，当所有请求完成后进行回调，所有请求完成后只要其中一个请求成功就走sucess回调，请求全部失败则走failure回调。

 @param requestArray 请求数组
 @param success 成功回调
 @param failure 失败回调
 */
- (void)joy_batchRequestWithRequestArray:(NSArray<NSURLRequest *> *)requestArray completionBlockWithSuccess:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
