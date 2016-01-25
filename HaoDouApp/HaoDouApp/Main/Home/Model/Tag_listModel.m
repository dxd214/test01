//
//  Tag_listModel.m
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-23.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "Tag_listModel.h"

@implementation Tag_listModel
- (id)initWithContentsOfDic:(NSDictionary *)dic
{
    self = [super initWithContentsOfDic:dic];
    if (self)
    {
        self.TagId = dic[@"Id"];
    }
    
    return self;
}

@end
