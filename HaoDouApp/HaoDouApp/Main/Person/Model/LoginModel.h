//
//  LoginModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-11-1.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//
/*
 "Ssid": "453dee1bbc13f217ec3d5eab045d9d6a",
 "UserId": "3188998",
 "Name": "740483648@qq.com",
 "Nick": "刘依琪琪",
 "Avatar": "http://avatar0.hoto.cn/06/a9/3188998_185.jpg?v=0",
 "Sign": "ee65c777423b8c998b37dbe1dc82b0dc",
 "MsgCnt": 0,
 "CheckIn": false,
 "MessageCnt": 0,
 "Sina": 0,
 "QQ": 0,
 "QQWeibo": 0
 
 */

#import "BaseModel.h"

@interface LoginModel : BaseModel

@property(nonatomic,copy)NSString *Ssid;
@property(nonatomic,copy)NSString *UserId;
@property(nonatomic,copy)NSString *Name;
@property(nonatomic,copy)NSString *Nick;
@property(nonatomic,copy)NSString *Avatar;
@property(nonatomic,copy)NSString *Sign;
@property(nonatomic,copy)NSString *CheckIn;
@property(nonatomic,copy)NSNumber *MsgCnt;
@property(nonatomic,copy)NSNumber *MessageCnt;
@property(nonatomic,copy)NSNumber *Sina;
@property(nonatomic,copy)NSNumber *QQ;
@property(nonatomic,copy)NSNumber *QQWeibo;



@end
