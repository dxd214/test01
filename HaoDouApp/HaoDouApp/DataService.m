//
//  DataService.m
//  weibo
//
//  Created by zsm on 14-11-15.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import "DataService.h"
#import "AppDelegate.h"
@implementation DataService
#define base_Url @"http://api.haodou.com/index.php"
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
                                reqestHeader:(NSMutableDictionary *)headerDic
                                  httpMethod:(NSString *)httpMethod
                              finishDidBlock:(FinishDidBlock)finishDidBlock
                                failureBlock:(FailureBlock)failureBlock
{
    
    NSString *str = @"?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&format=json&vc=19&vn=v3.0.1&loguid=&deviceid=fe811703e516ddcb4f353bab4f4d2b91&channel=apptore";
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

    //设置请求的回调
    [requstOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        //成功的回调
        if (finishDidBlock) {
            finishDidBlock(operation,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            //失败的回调
        if (failureBlock) {
            failureBlock(operation,error);
        }
    }];
    //开始请求
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
    for (NSString *key in params)
    {
        id value = [params objectForKey:key];
        if (![value isKindOfClass:[NSData class]])
        {
            
            
            // 普通参数-username
            // 普通参数开始的一个标记
            [data appendData:[@"--mj\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            // 参数描述
            NSString *keyString = [NSString stringWithFormat:@"Content-Disposition:form-data; name=\"%@\"\r\n",key];
            [data appendData:[keyString dataUsingEncoding:NSUTF8StringEncoding]];
            
            // 参数值
            NSString *valueString = [NSString stringWithFormat:@"\r\n%@\r\n",value];
            [data appendData:[valueString dataUsingEncoding:NSUTF8StringEncoding]];
        }
        else
        {
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





