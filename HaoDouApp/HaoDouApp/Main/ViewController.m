//
//  ViewController.m
//  welcome
//
//  Created by 董晓东 on 15/3/17.
//  Copyright (c) 2015年 实创装饰集团出品. All rights reserved.
//

#import "ViewController.h"
#import "HuodongViewController.h"
#import "MainTabViewController.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _imgStr = @"";
    //显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    //活动图片
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self _firstUse];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_imgStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil)
        {
            // 加载故事版里面的控制器
            MainTabViewController *tab = [[MainTabViewController alloc] init];
            tab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:tab animated:YES completion:nil];
            [_timer invalidate];
            _imageView = nil;
        }
    }];
    [self.view addSubview:_imageView];
    
    //定时器跳转
    _index = 2;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}
#pragma mark- 判断有没有活动
- (void)_firstUse
{
    //设置首次使用欢迎页面
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    BOOL showGuide = [userDefaults boolForKey:KhiddenHuoDong];
    
    if (showGuide == NO)
    {
        [userDefaults setBool:YES forKey:KhiddenHuoDong];
        //同步数据
        [userDefaults synchronize];
    }
    else
    {
        _imgStr = imgUrl;
    }
    
}
#pragma mark - 活动页面
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    HuodongViewController *huodongVC = [[HuodongViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:huodongVC];
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
  
    [self presentViewController:nav animated:YES completion:^{
        _imageView = nil;
        [_timer invalidate];
    }];

}
#pragma mark - 定时器
- (void)timerAction:(NSTimer *)timer
{
    _index--;
    if (_index<0)
    {
        // 加载故事版里面的控制器
        MainTabViewController *tab = [[MainTabViewController alloc] init];
        tab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:tab animated:YES completion:nil];
        [_timer invalidate];
        
    }
}
#pragma mark- 隐藏状态栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
}

- (BOOL)prefersStatusBarHidden
{
    return YES; // 返回NO表示要显示，返回YES将hiden
}
@end
