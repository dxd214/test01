//
//  StuffCookModel.m
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-27.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "StuffCookModel.h"

@implementation StuffCookModel

- (id)initWithContentsOfDic:(NSDictionary *)dic
{
    self = [super initWithContentsOfDic:dic];
    if (self)
    {
        self.stuffID = dic[@"id"];
    }
    
    return self;
}




@end
