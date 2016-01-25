//
//  CateListModel.h
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/16.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "BaseModel.h"

@interface CateListModel : BaseModel
@property(nonatomic,assign)NSInteger CateId;
@property(nonatomic,copy)NSString *imageUrl;
@property(nonatomic,copy)NSString *TopicId;
@property(nonatomic,copy)NSString *Name;
@end
