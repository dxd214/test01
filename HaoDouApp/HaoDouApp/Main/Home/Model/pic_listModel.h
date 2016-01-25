//
//  Recipe_listModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-23.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

/*
 "recipe_list": [
 {
 "Rid": 342876,
 "Title": "肉末烧豆腐",
 "Cover": "http://recipe0.hoto.cn/pic/recipe/l/5c/3b/342876_3ae7ff.jpg",
 "UserName": "老杨的厨房"
 },
 
 */

#import "BaseModel.h"

@interface pic_listModel : BaseModel

@property(nonatomic,copy)NSString *Rid;
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *Cover;
@property(nonatomic,copy)NSString *UserName;


@end
