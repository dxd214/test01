//
//  OmnibusModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-26.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

/*
 "Title": "家有小儿——可爱型早餐",
 "Cover": "http://recipe0.hoto.cn/pic/recipe/g_230/8e/c7/182158_ad58cb.jpg",
 "Id": 154705,
 "UserId": 786580,
 "UserName": "仙人球123",
 "Avatar": "http://avatar0.hoto.cn/94/00/786580_185.jpg",
 "RecipeCount": 32
 
 */

#import "BaseModel.h"

@interface SelectModel : BaseModel
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *Cover;
@property(nonatomic,copy)NSString *OmniId;
@property(nonatomic,copy)NSString *UserId;
@property(nonatomic,copy)NSString *UserName;
@property(nonatomic,copy)NSString *Avatar;
@property(nonatomic,copy)NSNumber *RecipeCount;

@end
