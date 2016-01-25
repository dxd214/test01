//
//  AssortomentModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-23.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "BaseModel.h"
/*
 "Cate": "热门分类",
 "ImgUrl": "http://www.haodou.com/public/images/mobile/recipe/1.png",
 
 */
@interface SortModel : BaseModel


@property(nonatomic,copy)NSString *Cate;
@property(nonatomic,copy)NSString *ImgUrl;
@property(nonatomic,retain)NSMutableArray *tagModels;


@end
