//
//  DetailMenuModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-25.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

/*
 "RecipeId": 348693,
 "Title": "烤山药蛋",
 "Intro": "山药蛋里面加颗蛋所以叫山药蛋蛋，是不是很可爱呢？很容易做的哦~！喜欢吃的朋友们不要错过了哦，快来瞧瞧吧！",
 "Cover": "http://recipe1.hoto.cn/pic/recipe/g_230/15/52/348693_8a1cca.jpg",
 "UserId": 2045354,
 "UserName": "菜男烧小菜",
 "ViewCount": 407,
 "CommentCount": 19,
 "FavoriteCount": 44,
 "Avatar": "http://avatar0.hoto.cn/aa/35/2045354_48.jpg",
 "Stuff": [
 {
 "name": "土豆",
 "weight": "300g",
 "type": 1,
 "id": 114
 },
 
 */

#import "BaseModel.h"


@interface DetailMenuModel : BaseModel

@property(nonatomic,copy)NSString *RecipeId;
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *Intro;
@property(nonatomic,copy)NSString *Cover;
@property(nonatomic,copy)NSString *UserId;
@property(nonatomic,copy)NSString *UserName;
@property(nonatomic,copy)NSNumber *ViewCount;
@property(nonatomic,copy)NSNumber *CommentCount;
@property(nonatomic,copy)NSNumber *FavoriteCount;
@property(nonatomic,copy)NSString *Avatar;

@property(nonatomic,retain)NSArray *stuffArray;



@end
