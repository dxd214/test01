//
//  wiki_listModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-23.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "BaseModel.h"
/*
 "Url": "http://m.haodou.com/app/recipe/topic/view.php?id=234871",
 "Title": "视觉系日式料理（餐具篇）",
 "UserName": "梅依旧",
 "Content": "    日式料理，首先给你的是视觉上的冲击，精巧的碗碟里盛着少少的食物，东西精致得像摆设，已经超越了食物的本身，它其中渗透着对生活的禅意与生活的本真。 日式料理，也被称为视觉...",
 "Cover": "http://img3.hoto.cn/group/201310/21/141772_24137221.jpg"
 */

@interface KitchenModel : BaseModel

@property(nonatomic,copy)NSString *Url;
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *UserName;

@property(nonatomic,copy)NSString *Content;
@property(nonatomic,copy)NSString *Cover;


@end
