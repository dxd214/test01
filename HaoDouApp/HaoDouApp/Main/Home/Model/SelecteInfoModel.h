//
//  RecipeListModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-28.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//
/*
 "RecipeList": [
 {
 "Rid": 182158,
 "Title": "愤怒的小鸟蒸饺",
 "Cover": "http://recipe0.hoto.cn/pic/recipe/g_230/8e/c7/182158_ad58cb.jpg"
 },
 */

#import "BaseModel.h"

@interface SelecteInfoModel : BaseModel

@property(nonatomic,copy)NSString *Rid;
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *Cover;


@end
