//
//  DataServicess.m
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/16.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "DataServicess.h"
#import "AppDelegate.h"
@implementation DataServicess
#define base_Url @"http://api.hoto.cn/index.php"
+ (AFHTTPRequestOperation *)requestAFWithUrl:(NSString *)urlString
                                      params:(NSMutableDictionary *)params
                                reqestHeader:(NSMutableDictionary *)headerDic
                                  httpMethod:(NSString *)httpMethod
                              finishDidBlock:(FinishDidBlock)finishDidBlock
                                failureBlock:(FailureBlock)failureBlock
{
    NSString *str = @"?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&appsign=33f84f3b2deae60a8752e34b61adc1c6&channel=appstore&deviceid=0f607264fc6318a92b9e13c65db7cd3c%7CADD99A3D-0026-4B03-9A07-7B3864383455%7CB8D0DB0C-7ED8-4FEC-92A6-FCE26DFB5118&format=json&loguid=&signmethod=md5&uuid=a0f3877bac53c748433f7900b90de3a3&v=2&vc=34&vn=v4.8.0";
    
    urlString = [base_Url stringByAppendingFormat:@"%@%@",urlString,str];
    // 1.创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    // 2.添加请求头
    for (NSString *key in headerDic.allKeys)
    {
        [request addValue:headerDic[key] forHTTPHeaderField:key];
    }
#pragma mark - GET请求
    // 3.如果是GET请求
    if ([httpMethod caseInsensitiveCompare:@"GET"] == NSOrderedSame) {
        // 设置GET请求
        [request setHTTPMethod:@"GET"];
        
        // 把参数拼接到URL的后面 www.baidu.com?count=123&
        // 创建一个可变字符串
        NSMutableString *paramString = [NSMutableString string];
        for (NSString *key in params) {
            NSString *value = [params objectForKey:key];
            [paramString appendFormat:@"&%@=%@",key,value];
        }
        
        // 如果有参数我们就从新设定URL
        if (params.count > 0)
        {
            request.URL = [NSURL URLWithString:[urlString stringByAppendingString:paramString]];
        }
        
    }
#pragma mark - POST请求
    // 4.如果是POST请求
    if ([httpMethod caseInsensitiveCompare:@"POST"] == NSOrderedSame)
    {
        
        // 设置POST请求
        [request setHTTPMethod:@"POST"];
        
        // 当前参数中是否带有NSData类型
        BOOL isData = NO;
        for (NSString *key in params) {
            if ([params[key] isKindOfClass:[NSData class]])
            {
                isData = YES;
            }
        }
        
        if (isData == YES) {
            // 设置请求头信息-数据类型
#warning  此处需要修改
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            
            // 设置请求体
            request.HTTPBody = [self dataImageWithParams:params];
        }
        else
        {
            request.HTTPBody = [self dataStringWithParams:params];
        }
        
        
    }
    
    // 4.发送请求
    AFHTTPRequestOperation *requstOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    // 设置返回数据的解析方式
    requstOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    [requstOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (finishDidBlock) {
             finishDidBlock(operation,responseObject);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failureBlock) {
             failureBlock(operation,error);
         }
     }];
    
    [requstOperation start];
    return requstOperation;
}

+ (NSData *)dataStringWithParams:(NSDictionary *)params
{
    NSMutableString *paramString = [NSMutableString string];
    for (NSString *key in params) {
        NSString *value = [params objectForKey:key];
        [paramString appendFormat:@"&%@=%@",key,value];
    }
    return [[paramString substringFromIndex:1] dataUsingEncoding:NSUTF8StringEncoding];
    
}

+ (NSData *)dataImageWithParams:(NSDictionary *)params
{
    // 拼接请求体
    NSMutableData *data = [NSMutableData data];
    // 把参数添加到请求体里面面
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        if (![value isKindOfClass:[NSData class]]) {
            
            
            // 普通参数-username
            // 普通参数开始的一个标记
            [data appendData:[@"--mj\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            // 参数描述
            NSString *keyString = [NSString stringWithFormat:@"Content-Disposition:form-data; name=\"%@\"\r\n",key];
            [data appendData:[keyString dataUsingEncoding:NSUTF8StringEncoding]];
            
            // 参数值
            NSString *valueString = [NSString stringWithFormat:@"\r\n%@\r\n",value];
            [data appendData:[valueString dataUsingEncoding:NSUTF8StringEncoding]];
        } else {
            // 普通参数-username
            // 普通参数开始的一个标记
            [data appendData:[@"--mj\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            // 参数描述
            NSString *keyString = [NSString stringWithFormat:@"Content-Disposition:form-data; name=\"%@\"; filename=\"img.png\"\r\n",key];
            [data appendData:[keyString dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:[@"Content-Type:image/png\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            // 参数值
            [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [data appendData:value];
            [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
        }
        
    }
    // 参数结束的标识
    [data appendData:[@"--mj--" dataUsingEncoding:NSUTF8StringEncoding]];
    return data;
}

@end
