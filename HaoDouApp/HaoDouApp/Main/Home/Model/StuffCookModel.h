//
//  StuffCookModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-27.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//
/*
 "Stuff": [
 {
 "name": "鲜虾仁",
 "weight": "100g",
 "id": 12787,
 "type": 1,
 "cateid": 11,
 "cate": "水产品"
 },

 */

#import "BaseModel.h"

@interface StuffCookModel : BaseModel

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *weight;
@property(nonatomic,copy)NSString *stuffID;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *cateid;
@property(nonatomic,copy)NSString *cate;


@end
