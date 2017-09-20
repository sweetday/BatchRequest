//
//  NSURLRequest+JOYBatchRequest.m
//  BatchRequestDemo
//
//  Created by Ssuperjoy on 2017/9/19.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "NSURLRequest+JOYBatchRequest.h"
#import <objc/runtime.h>
#import "AFNetworking.h"

@implementation NSURLRequest (JOYBatchRequest)

+ (NSMutableURLRequest *)joy_httpRequestWithMethodType:(JOYHttpMethodType)methodType urlString:(NSString *)urlString parameters:(id)parameters completionBlock:(void(^)(id responseObject, NSError *error))completionBlock
{
    NSError *serializationError = nil;
    NSString *method;
    switch (methodType) {
        case JOYHttpMethodTypeGet: {
            method = @"GET";
            break;
        }
        case JOYHttpMethodTypePost: {
            method = @"POST";
            break;
        }
    }
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:method URLString:urlString parameters:parameters error:&serializationError];
    if (serializationError) {
        if (completionBlock) {
            completionBlock(nil, serializationError);
        }
        return nil;
    } else {
        request.joy_completionBlock = completionBlock;
        return request;
    }

}

- (void)setJoy_completionBlock:(void (^)(id, NSError *))joy_completionBlock
{
    objc_setAssociatedObject(self, @selector(joy_completionBlock), joy_completionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(id, NSError *))joy_completionBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setJoy_error:(NSError *)joy_error
{
    objc_setAssociatedObject(self, @selector(joy_error), joy_error, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSError *)joy_error
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
