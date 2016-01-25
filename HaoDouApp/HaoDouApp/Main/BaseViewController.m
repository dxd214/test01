//
//  BaseViewController.m
//  foundation
//
//  Created by ios on 15-1-5.
//  Copyright (c) 2015年 716team. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    UIView *_maskView;
}
@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建导航栏返回按钮
    if (self.navigationController.viewControllers.count > 1) {
        [self _initBackBarButtonItem];
    }
}
#pragma mark -创建导航栏按钮
// 创建导航栏返回按钮
- (void)_initBackBarButtonItem
{
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"main_menu_icon_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
   
}
//按钮点击事件
- (void)buttonAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 加载提示
//加载提示
- (void)showHUD:(NSString *)title
{
    _maskView = [[UIView alloc]initWithFrame:self.view.bounds];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = .5;
    [self.view addSubview:_maskView];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = title;
    
}
//隐藏提示
- (void)hiddenHUD {
    [_maskView removeFromSuperview];
    [self.hud hide:YES];
    
}

#pragma mark - 是否登录
//判断是否登录
- (BOOL)userIsLogin
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:KPassWord];
    if (dic)
    {
        return YES;
    }
    
    return NO;
}
#pragma mark- AppDelegate
- (AppDelegate *)appDelegete
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}



@end
