//
//  BaseWebViewController.m
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-26.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//
/*
 多线程GCD
 */
#import "BaseInfoViewController.h"
#import "PersonViewController.h"
@interface BaseInfoViewController ()

@end

@implementation BaseInfoViewController

- (void)viewDidLoad
{
    
    self.title = _Celltitle;
    [super viewDidLoad];
    [self _initNavItem];
    _subWebView.delegate = self;
    _fontSize = 14;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.cellUrl]];
    //后台加载数据
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.subWebView loadRequest:request];
        
        //网络请求之后进入主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"进入主线程");
        });
    });
    
}

#pragma mark --WebView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *weiboURL = [request.URL absoluteString];
    NSString *strUrl = [weiboURL substringToIndex:7];
    if ([strUrl isEqualToString:@"recipe:"])
    {
#pragma 跳转到登陆成功界面
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        BOOL showGuide = [userDefaults boolForKey:KPassWord];
        
        if (showGuide == NO)
        {
            [userDefaults setBool:YES forKey:KPassWord];
            //同步数据
            [userDefaults synchronize];
        }

        PersonViewController *personVC = [[PersonViewController alloc]init];
        [self.navigationController pushViewController:personVC animated:YES];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        return YES;

}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载完成");
    NSString *strSize=[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.fontSize='%ldpx';var pArray = document.getElementsByTagName('p');for(var i=0; i<pArray.length;i++){var spanArray = document.getElementsByTagName('span');pArray[i].style.fontSize='%ldpx';for(var j=0; j<spanArray.length;j++){spanArray[j].style.fontSize='%ldpx';}}",_fontSize,_fontSize,_fontSize];
    [webView stringByEvaluatingJavaScriptFromString:strSize];

}
#pragma mark - UI设计
- (void)_initNavItem
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.tag = 99;
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    [leftButton setImage:[UIImage imageNamed:@"main_menu_icon_back.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    //右边按钮
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 22)];
    rightView.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    //字体
    UIButton *fontButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fontButton.tag = 100;
    [fontButton setImage:[UIImage imageNamed:@"DrugIconText"] forState:UIControlStateNormal];
    [fontButton setImage:[UIImage imageNamed:@"DrugIconText2"]forState:UIControlStateHighlighted];
    fontButton.frame=CGRectMake(0, 0, 22, 22);
    [fontButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:fontButton];
    //分享
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.tag = 101;
    [shareButton setImage:[UIImage imageNamed:@"DrugShareIcon"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"DrugShareIconSel.png"]forState:UIControlStateHighlighted];
    shareButton.frame=CGRectMake(30, 0, 22, 22);
    [shareButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:shareButton];
    //收藏
    _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectButton.tag = 102;
    [_collectButton setImage:[UIImage imageNamed:@"DrugIcon04"]forState:UIControlStateNormal];
    [_collectButton setImage:[UIImage imageNamed:@"DrugIcon04Sel.png"] forState:UIControlStateSelected];
    _collectButton.frame=CGRectMake(60, 0, 22, 22);
    [_collectButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:_collectButton];
}
- (void)buttonAction:(UIButton *)button
{
    if(button.tag == 99)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(button.tag == 100)
    {
        //调整字体
        if(_fontSize < 20)
        {
            _fontSize +=2;
        }
        else
        {
            _fontSize = 14;
        }
        [_subWebView reload];
    }
    else if(button.tag == 101)
    {
#pragma mark - 分享
        //分享
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"jpg"];
        //构造分享内容
        id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                           defaultContent:@"默认分享内容"
                                                    image:[ShareSDK imageWithPath:imagePath]
                                                    title:@"ShareSDK"
                                                      url:@"http://www.mob.com"
                                              description:@"这是一条测试信息"
                                                mediaType:SSPublishContentMediaTypeNews];
        
        //弹出分享菜单
        [ShareSDK showShareActionSheet:nil
                             shareList:nil
                               content:publishContent
                         statusBarTips:YES
                           authOptions:nil
                          shareOptions:nil
                                result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                    
                                    if (state == SSResponseStateSuccess)
                                    {
                                        [self showHUD:@"分享成功"];
                                        
                                        [self performSelector:@selector(hiddenHUD) withObject:self afterDelay:1];
                                    }
                                    else if (state == SSResponseStateFail)
                                    {
                                        NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                    }
                                }];
    }
    else if(button.tag == 102)
    {
#pragma mark- 收藏
        
        [self collectButtonAction:button];
        //网络请求
        [self showHUD:@"收藏成功"];
        [self performSelector:@selector(hiddenHUD) withObject:self afterDelay:1];
    }
}
#pragma mark - 保存数据到本地文件
//添加收藏，并将数据保存到本地【在显示页面从本地读取数据】
- (void)collectButtonAction:(UIButton *)button
{
    if(button.selected == NO)
    {
        [DataService requestAFWithUrl:@"" params:nil reqestHeader:nil httpMethod:@"GET" finishDidBlock:^(AFHTTPRequestOperation *operation, id result) {
            NSLog(@"收藏成功");
            
        } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
        button.selected = !button.selected;
        
    }
    else
    {
        NSLog(@"您已经收藏");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"确定取消收藏吗？"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
        
        
        //显示提示框
        [alertView show];
        button.selected = !button.selected;
    }
    
}
#pragma mark -UIAlertView delaget

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"点击取消了");
    }
    else if (buttonIndex == 1)
    {
        
        NSLog(@"取消收藏");
        [DataService requestAFWithUrl:@"" params:nil reqestHeader:nil httpMethod:@"GET" finishDidBlock:^(AFHTTPRequestOperation *operation, id result) {
            NSLog(@"取消成功");
        } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }
    
}



@end
