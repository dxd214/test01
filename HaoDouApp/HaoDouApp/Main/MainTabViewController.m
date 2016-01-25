//
//  MainTabViewController.m
//  CustomTabBar
//
//  Created by 董晓东 on 15/4/1.
//  Copyright (c) 2015年 YunLife. All rights reserved.
//

#import "MainTabViewController.h"
#import "HomeViewController.h"
#import "SortViewController.h"
#import "WalkViewController.h"
#import "PersonViewController.h"
#import "BaseNavViewController.h"
#import "BaseTabBarItem.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    //三级控制器
    [self _initView];

    self.delegate = self;
    // 设置起始标签位置
    self.selectedIndex = 0;
    [self arrowMoveTo:self.selectedIndex withAnimation:NO];
   
    self.tabBar.backgroundColor = [UIColor redColor];
    

    
    // 背景视图
    _selectedArrowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    [_selectedArrowView setImage:[UIImage imageNamed:@"arrow"]];
    // 将箭头视图添加到标签栏并设置起始位置
    [self arrowMoveTo:self.selectedIndex withAnimation:NO];
    [self.tabBar addSubview:_selectedArrowView];
    [self.tabBar bringSubviewToFront:_selectedArrowView];
    
   
    
}


- (void)_initView
{
    HomeViewController *firstVC = [[HomeViewController alloc] init];
    SortViewController *secondVC = [[SortViewController alloc] init];
    WalkViewController *thirdVC = [[WalkViewController alloc] init];
    PersonViewController *fourVC = [[PersonViewController alloc]init];
    NSArray *ctrls = @[firstVC,secondVC,thirdVC,fourVC];

    NSArray *imageSelected =@[@"main_ico_menu_home_on.png",@"main_ico_menu_category_on.png",@"main_ico_menu_random_on.png",@"main_ico_menu_center_on.png"];
    NSArray *images = @[@"main_ico_menu_home.png",@"main_ico_menu_category.png",@"main_ico_menu_random.png",@"main_ico_menu_center.png"];
    
    NSArray *titles = @[@"主页",@"分类",@"逛逛",@"豆窝"];
    NSMutableArray *navNC = [NSMutableArray array];
    for (NSInteger i=0; i < 4; i++)
    {
        UIViewController *viewVC = (UIViewController *)ctrls[i];
        BaseNavViewController *baseNC = [[BaseNavViewController alloc] initWithRootViewController:viewVC];
        BaseTabBarItem *item = [[BaseTabBarItem alloc]initWithTitle:titles[i] image:[[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:imageSelected[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        item.tag = 1000+i;
        baseNC.tabBarItem = item;
        [navNC addObject:baseNC];
    }
    // 通过数组设置标签控制器所控制的视图
    self.viewControllers = navNC;
}

#pragma mark UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    [self arrowMoveTo:self.selectedIndex withAnimation:YES];
    
}
#pragma mark ArrowMove
- (void)arrowMoveTo:(NSUInteger)tabBarItemIndex withAnimation:(BOOL)animation {
    
    NSUInteger count = self.viewControllers.count;
    
    CGRect frame = CGRectMake((kScreenWidth * (tabBarItemIndex * 2 + 1) / (count * 2)) - (_selectedArrowView.width / 2), 0, _selectedArrowView.width, _selectedArrowView.height);
    
    if (animation)
    {
        [UIView animateWithDuration:.35 animations:^{
            _selectedArrowView.frame = frame;
        }];
    }
    else
    {
        _selectedArrowView.frame = frame;
    }
    
}

@end
