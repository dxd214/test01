//
//  HuodongViewController.m
//  welcome
//
//  Created by 董晓东 on 15/3/17.
//  Copyright (c) 2015年 实创装饰集团出品. All rights reserved.
//

#import "HuodongViewController.h"
#import "MainTabViewController.h"
@interface HuodongViewController ()

@end


@implementation HuodongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //返回主菜单
    [self _initViews];
    //创建活动展示容器
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self _initLoadWebViewWithWebView:_webView WithURLString:URLmystring];
    [self.view addSubview:_webView];
}
#pragma mark - 返回主菜单
- (void)_initViews
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setImage:[UIImage imageNamed:@"TopBackGreen"] forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];

}
- (void)buttonAction
{
    MainTabViewController *mainTabVC = [[MainTabViewController alloc]init];
    mainTabVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:mainTabVC animated:YES completion:nil];
    
}
#pragma mark - 网页加载
- (void)_initLoadWebViewWithWebView:(UIWebView *)webView
                      WithURLString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webView.scalesPageToFit = YES;
    //禁用UIWebView左右滚动
//    [(UIScrollView *)[[webView subviews] objectAtIndex:0] setBounces:NO];
    [self HiddenVerticalScrollIndicator:webView];
    [webView loadRequest:request];
}
- (void)HiddenVerticalScrollIndicator:(UIWebView *)webView
{
        //取消右侧，下侧滚动条，去处上下滚动边界的黑色背景
        for (UIView *_aView in [webView subviews])
        {
            if ([_aView isKindOfClass:[UIScrollView class]])
            {
                [(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO];
                //右侧的滚动条
                [(UIScrollView *)_aView setShowsHorizontalScrollIndicator:NO];
                //下侧的滚动条
                for (UIView *_inScrollview in _aView.subviews)
                {
                    if ([_inScrollview isKindOfClass:[UIImageView class]])
                    {
                        _inScrollview.hidden = YES;
                        //上下滚动出边界时的黑色的图片
                    }
                }
            }
        }
    //   禁用UIWebView左右滚动
    [(UIScrollView *)[[webView subviews] objectAtIndex:0] setBounces:NO];
}



@end
