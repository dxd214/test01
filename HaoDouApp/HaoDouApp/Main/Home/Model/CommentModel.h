//
//  CommentModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-28.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//
/*
 "comment": [
 {
 "UserId": 3157113,
 "Avatar": "http://avatar1.hoto.cn/79/2c/3157113_185.jpg",
 "UserName": "85081772",
 "Content": "很简单哦~赞一个",
 "CreateTime": "半小时前"
 },
 */
#import "BaseModel.h"

@interface CommentModel : BaseModel
/**
 *  用户编号
 */
@property(nonatomic,copy)NSString *UserId;
/**
 *  用户头像
 */
@property(nonatomic,copy)NSString *Avatar;
/**
 *  用户名
 */
@property(nonatomic,copy)NSString *UserName;
/**
 *  评论内容
 */
@property(nonatomic,copy)NSString *Content;
/**
 *  评论时间
 */
@property(nonatomic,copy)NSString *CreateTime;


@end
