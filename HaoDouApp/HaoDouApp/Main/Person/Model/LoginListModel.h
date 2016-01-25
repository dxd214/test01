//
//  loginListModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-11-1.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//
/*
 "status": 200,
 "result": {
 "info": {
 "UserId": 3188998,
 "UserName": "刘依琪琪",
 "Vip": "0",
 "Avatar": "http://avatar0.hoto.cn/06/a9/3188998_185.jpg?v=3",
 "Intro": "",
 "RecipeCnt": 0,
 "FollowCnt": 1,
 "FansCount": 0,
 "CanFollow": true,
 "Wealth": 1,
 "CheckIn": true,
 "FavoriteCnt": 0,
 "Vistor": [],
 "PhotoCnt": 0,
 "NoticeCnt": 0,
 "MessageCnt": 0
 }
 }
 
 */
#import "BaseModel.h"

@interface LoginListModel : BaseModel

@property(nonatomic,copy)NSString *UserId;
@property(nonatomic,copy)NSString *UserName;
@property(nonatomic,copy)NSString *Vip;
@property(nonatomic,copy)NSString *Avatar;
@property(nonatomic,copy)NSString *Intro;
@property(nonatomic,retain)NSNumber *RecipeCnt;
@property(nonatomic,retain)NSNumber *FollowCnt;
@property(nonatomic,retain)NSNumber *FansCount;
@property(nonatomic,retain)NSNumber *FavoriteCnt;
@property(nonatomic,retain)NSNumber *PhotoCnt;
@property(nonatomic,retain)NSNumber *NoticeCnt;
@property(nonatomic,retain)NSNumber *MessageCnt;


@end
