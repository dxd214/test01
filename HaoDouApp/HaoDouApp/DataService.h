//
//  DataService.h
//  weibo
//
//  Created by zsm on 14-11-15.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef void (^FinishDidBlock)(AFHTTPRequestOperation *operation,id result);
typedef void (^FailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface DataService : NSObject
/**
 *  网络请求
 *
 *  @param urlString      请求的网址
 *  @param params         参数（GET）
 *  @param headerDic      请求头（POST）
 *  @param httpMethod     请求方式（GET or POST）
 *  @param finishDidBlock 成功的回调
 *  @param failureBlock   失败的回调
 *
 *  @return 返回回调结果
 */
+ (AFHTTPRequestOperation *)requestAFWithUrl:(NSString *)urlString
                                      params:(NSMutableDictionary *)params
                                reqestHeader:(NSDictionary *)headerDic
                                  httpMethod:(NSString *)httpMethod
                              finishDidBlock:(FinishDidBlock)finishDidBlock
                                failureBlock:(FailureBlock)failureBlock;
@end
