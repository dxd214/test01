//
//  StuffModel.m
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-25.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "StuffModel.h"

@implementation StuffModel

- (id)initWithContentsOfDic:(NSDictionary *)dic
{
    self = [super initWithContentsOfDic:dic];
    if (self)
    {
        self.StuffId = dic[@"id"];
    }
    
    return self;
}
@end
