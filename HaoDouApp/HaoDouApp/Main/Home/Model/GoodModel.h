//
//  NutritionModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-25.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//


/*
 "Title": "点滴厨房烹饪小窍门",
 "Url": "http://m.haodou.com/app/recipe/topic/view.php?id=199236",
 "Image": "http://img3.hoto.cn/group/201305/16/486606_04838473.jpg",
 "Content": ""
 */
#import "BaseModel.h"

@interface GoodModel : BaseModel

@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *Url;
@property(nonatomic,copy)NSString *Image;
@property(nonatomic,copy)NSString *Content;


@end
