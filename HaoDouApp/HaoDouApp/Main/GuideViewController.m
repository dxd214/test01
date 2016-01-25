//
//  GuideViewController.m
//  01 WXMovie
//
//  Created by lyb on 14-8-25.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "GuideViewController.h"
#import "ViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    [self _initWelcome];
}
- (void)_initWelcome
{
    //隐藏状态栏
    //iOS6
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    //将图片存放到数组中
    NSArray *guideImages = @[@"guide_step1.jpg",
                             @"guide_step2.jpg",
                             @"guide_step3.jpg",
                             ];
    
    //创建滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //隐藏滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    //设置显示内容的尺寸
    scrollView.contentSize = CGSizeMake(kScreenWidth*guideImages.count, kScreenHeight);
    //设置分页效果
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    for (int i=0; i<guideImages.count; i++)
    {
        NSString *imgName1 = guideImages[i];
        //视图背景图片
        UIImageView *guideImg = [[UIImageView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        guideImg.image = [UIImage imageNamed:imgName1];
        [scrollView addSubview:guideImg];
        
    }

}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    CGFloat sub = scrollView.contentOffset.x - (scrollView.contentSize.width-scrollView.width);
    
    if (sub > 30)
    {
        //显示状态栏
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        // 加载故事版里面的控制器
        UIViewController *mainCtrl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateInitialViewController];
        self.view.window.rootViewController = mainCtrl;
        
    }
    
}



@end
