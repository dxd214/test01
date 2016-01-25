//
//  OmnibusModel.m
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-26.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "SelectModel.h"

@implementation SelectModel


- (id)initWithContentsOfDic:(NSDictionary *)dic
{
    self = [super initWithContentsOfDic:dic];
    if (self)
    {
        self.OmniId = dic[@"Id"];
    }
    
    return self;
}
@end
