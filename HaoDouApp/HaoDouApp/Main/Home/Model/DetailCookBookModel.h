//
//  DetailCookBookModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-27.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

/*
 "status": 200,
 "result": {
 "info": {
 "RecipeId": 349055,
 "Cover": "http://recipe1.hoto.cn/pic/recipe/l/7f/53/349055_965745.jpg",
 "Title": "鲜虾烧丝瓜",
 "Intro": "丝瓜中维生素B1等含量亦高，有利于小儿大脑发育。丝瓜中含有很强的抗过敏物质，可以对春秋季过敏有食疗作用。\n虾营养丰富，含蛋白质是鱼、蛋、奶的几倍到几十倍；还含有丰富的钾、碘、镁、磷等矿物质及维生素A、氨茶碱等成分，且其肉质松软，易消化。和滑嫩的丝瓜搭配，营养又美味。其中富含的磷、钙、对小儿、孕妇尤有补益功效。",
 "CookTime": "10分钟内",
 "ReadyTime": "10分钟内",
 "Tips": "孕妇食谱，孕初期以及中期的孕妇尽量不要食用刺激性调味品。以清淡为主。\n我用的是本地一种很小的肉丝瓜，所以用了4根，大家要看情况。\n盐是一茶匙半调味，剩下半茶匙放盐水泡丝瓜了。\n喜欢清淡口的，可以不放蚝油，也一样好吃。",
 "UserName": "老杨的厨房",
 "FavoriteCount": 322,
 "CommentCount": 12,
 "PhotoCount": 2,
 "ReviewTime": "2013-10-25",
 "UserId": 132051,
 "Avatar": "http://avatar1.hoto.cn/d3/03/132051_185.jpg",
 "ViewCount": 106,
 "Type": 1,
 "UserCount": 2,
 */

//--------------菜谱数据原型------------------------
#import "BaseModel.h"
@interface DetailCookBookModel : BaseModel

@property(nonatomic,copy)NSString *RecipeId;
@property(nonatomic,copy)NSString *Cover;
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *Intro;
@property(nonatomic,copy)NSString *CookTime;
@property(nonatomic,copy)NSString *ReadyTime;
@property(nonatomic,copy)NSString *Tips;
@property(nonatomic,copy)NSString *UserName;
@property(nonatomic,copy)NSNumber *FavoriteCount;
@property(nonatomic,copy)NSNumber *CommentCount;
@property(nonatomic,copy)NSNumber *PhotoCount;
@property(nonatomic,copy)NSString *ReviewTime;
@property(nonatomic,copy)NSString *Avatar;
@property(nonatomic,copy)NSNumber *ViewCount;
@property(nonatomic,copy)NSNumber *UserCount;


@property(nonatomic,retain)NSArray *TagsArray; //标签
@property(nonatomic,retain)NSArray *StepsArray;//步骤
@property(nonatomic,retain)NSArray *StuffArray;//材料

@property(nonatomic,retain)NSArray *commentArray; //评价











@end
