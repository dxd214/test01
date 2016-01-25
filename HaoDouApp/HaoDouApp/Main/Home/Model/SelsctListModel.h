//
//  LYSubOmnibuseModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-28.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "BaseModel.h"

@interface SelsctListModel : BaseModel

@property(nonatomic,copy)NSString *UserId;
@property(nonatomic,copy)NSString *UserName;
@property(nonatomic,copy)NSString *Avatar;
@property(nonatomic,copy)NSString *CreateTime;
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *Cover;
@property(nonatomic,copy)NSString *Intro;
@property(nonatomic,copy)NSString *IsFavo;
@property(nonatomic,copy)NSString *CurrentGid;
@property(nonatomic,retain)NSNumber *Count;


@property(nonatomic,retain)NSArray *GroupListModels;
@property(nonatomic,retain)NSArray *RecipeListArray;


@end
