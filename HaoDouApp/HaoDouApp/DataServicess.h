//
//  DataServicess.h
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/16.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef void (^FinishDidBlock)(AFHTTPRequestOperation *operation,id result);
typedef void (^FailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface DataServicess : NSObject

+ (AFHTTPRequestOperation *)requestAFWithUrl:(NSString *)urlString
                                      params:(NSMutableDictionary *)params
                                reqestHeader:(NSDictionary *)headerDic
                                  httpMethod:(NSString *)httpMethod
                              finishDidBlock:(FinishDidBlock)finishDidBlock
                                failureBlock:(FailureBlock)failureBlock;
@end
