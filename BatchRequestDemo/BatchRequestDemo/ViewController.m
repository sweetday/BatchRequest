//
//  ViewController.m
//  BatchRequestDemo
//
//  Created by Ssuperjoy on 2017/9/19.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "ViewController.h"
#import "NSURLRequest+JOYBatchRequest.h"
#import "AFHTTPSessionManager+JOYBatchRequest.h"

static NSString * const TestUrlOne = @"https://www.moer.cn/api/app/v400/findRecommendStocks.json";
static NSString * const TestUrlTwo = @"https://www.moer.cn/api/app/v210/findUnLoginWriter.json";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)btnClick:(UIButton *)sender {
    
    __block id resultOne;
    NSURLRequest *requestOne = [NSURLRequest joy_httpRequestWithMethodType:JOYHttpMethodTypeGet urlString:TestUrlOne parameters:nil completionBlock:^(id responseObject, NSError *error) { // 每个请求成功后都会回调
        // 这里可以进行再一次封装，把responseObject转换成自己想要的model，再把model回调回来。
        resultOne = responseObject;
    }];
    
    __block id resultTwo;
    NSURLRequest *requestTwo = [NSURLRequest joy_httpRequestWithMethodType:JOYHttpMethodTypePost urlString:TestUrlTwo parameters:nil completionBlock:^(id responseObject, NSError *error) {
        resultTwo = responseObject;
    }];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager joy_batchRequestWithRequestArray:@[requestOne, requestTwo] completionBlockWithSuccess:^{ // 所有请求请求成功后统一回调
        
        if (!requestOne.joy_error) {
            NSLog(@"%@", resultOne);
        }
        
        if (!requestTwo.joy_error) {
            NSLog(@"%@", resultTwo);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

@end
