//
//  TagModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-23.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "BaseModel.h"

/*
 "Id": 288,
 "Name": "家常菜"
 */

@interface TagModel : BaseModel

@property(nonatomic,copy)NSString *TagId;
@property(nonatomic,copy)NSString *Name;

@end
