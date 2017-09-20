//
//  NSURLRequest+JOYBatchRequest.h
//  BatchRequestDemo
//
//  Created by Ssuperjoy on 2017/9/19.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JOYHttpMethodType) {
    JOYHttpMethodTypeGet,
    JOYHttpMethodTypePost
};

@interface NSURLRequest (JOYBatchRequest)

@property (nonatomic, copy) void(^joy_completionBlock)(id responseObject, NSError *error);

@property (nonatomic, strong) NSError *joy_error;


/**
 创建http请求

 @param methodType 请求方法（get/post）
 @param urlString 请求url
 @param parameters 请求参数
 @param completionBlock 请求完成回调
 @return 返回请求
 */
+ (NSMutableURLRequest *)joy_httpRequestWithMethodType:(JOYHttpMethodType)methodType urlString:(NSString *)urlString parameters:(id)parameters completionBlock:(void(^)(id responseObject, NSError *error))completionBlock;

@end
