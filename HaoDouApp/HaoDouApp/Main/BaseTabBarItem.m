//
//  SCTabBarItem.m
//  tabbar
//
//  Created by 董晓东 on 15/4/1.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "BaseTabBarItem.h"

@implementation BaseTabBarItem
- (id)_initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    self = [super init];
    if (self)
    {
        // 设置TabBarItem图标与标题之间距离 4个坐标分别控制图标上左下右四个方向间距
        self.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        // 设置TabBarItem标题未选择状态颜色与高亮颜色
        [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    }
    return self;
}

@end
