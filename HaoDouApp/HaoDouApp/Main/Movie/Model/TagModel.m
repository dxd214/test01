//
//  TagModel.m
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-23.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "TagModel.h"

@implementation TagModel

- (id)initWithContentsOfDic:(NSDictionary *)dic
{
    self = [super initWithContentsOfDic:dic];
    if (self)
    {
        self.TagId = [dic[@"Id"] stringValue];
    }
    
    return self;
}

@end
