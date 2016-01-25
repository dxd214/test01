//
//  BaseNavViewController.m
//  tabbar
//
//  Created by 董晓东 on 15/4/1.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏不透明
    self.navigationBar.translucent = NO;
    
    // 初始化导航栏
    [self _initNavigationBar];
    

}

// 初始化导航栏
- (void)_initNavigationBar
{
    //设置导航栏颜色
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBackground"] forBarMetrics:UIBarMetricsDefault];
    
    // 创建阴影对象并设置属性
    NSShadow *nvTitleShadow = [[NSShadow alloc] init];
    nvTitleShadow.shadowColor = [UIColor grayColor];
    nvTitleShadow.shadowOffset = CGSizeMake(.8, .8);
    // 设置导航栏标题颜色、阴影和字体
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nvTitleShadow,NSShadowAttributeName,[UIFont fontWithName:@"Arial-Bold" size:15],NSFontAttributeName, nil]];


}



@end
