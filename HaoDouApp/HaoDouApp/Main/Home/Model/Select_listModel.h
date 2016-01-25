//
//  Collect_listModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-23.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "BaseModel.h"

/*
 "collect_list": [
 {
 "Cover": "http://img1.hoto.cn/haodou/recipe_collect/collectrecommend/791.jpg",
 "UserName": "黑椒牛柳意大利面",
 "Title": "改善女性肤色要看“脸色”吃饭",
 "Content": "从食物上补充体内元素，根本上解决女性健康，这样红润肌肤就自然而然的呈现在我们的脸上。",
 "Cid": 151743
 },

 */





@interface Select_listModel : BaseModel

/**
 *   案例图片
 */
@property(nonatomic,copy)NSString *Cover;
/**
 *   用户名
 */
@property(nonatomic,copy)NSString *UserName;
/**
 *   案例标题
 */
@property(nonatomic,copy)NSString *Title;
/**
 *   案例内容
 */
@property(nonatomic,copy)NSString *Content;
/**
 *   案例编号
 */
@property(nonatomic,copy)NSString *Cid;

@end
