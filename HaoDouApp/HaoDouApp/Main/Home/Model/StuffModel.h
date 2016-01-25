//
//  StuffModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-25.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "BaseModel.h"

/*
 "Stuff": [
 {
 "name": "土豆",
 "weight": "300g",
 "type": 1,
 "id": 114
 },
 */

@interface StuffModel : BaseModel

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *weight;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *StuffId;


@end
