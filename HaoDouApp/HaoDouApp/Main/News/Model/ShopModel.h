//
//  ShopModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-24.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//
/*
 "list": [
 {
 "Title": "四季养生—秋季养生食谱",
 "Url": "http://m.haodou.com/app/recipe/topic/wapindex.php?type=qiujiyangsheng",
 "Type": 2,
 "Image": "http://img1.hoto.cn/haodou/app_image_upload/guangguang/2013-10-19/150.jpg"
 },
 
 */

#import "BaseModel.h"

@interface ShopModel : BaseModel

@property(nonatomic,copy)NSString *PreviewContent;
@property(nonatomic,copy)NSString *imageUrl;
@property(nonatomic,copy)NSString *TopicId;
@property(nonatomic,copy)NSString *FavoriteCount;
@property(nonatomic,copy)NSString *ViewCount;
@property(nonatomic,copy)NSString *Name;
@property(nonatomic,copy)NSString *Url;
@property(nonatomic,copy)NSString *LastPostTime;
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *UserName;
@property(nonatomic,assign)NSInteger WebViewId;
@property(nonatomic,copy)NSString *Collection;


@end
