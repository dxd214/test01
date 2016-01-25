//
//  GoupListModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-28.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//
/*
 "GroupList": [
 {
 "Gid": 150148,
 "Gname": "可爱营养主食"
 }, */

#import "BaseModel.h"

@interface GoupListModel : BaseModel

@property(nonatomic,copy)NSString *Gid;
@property(nonatomic,copy)NSString *Gname;

@end
