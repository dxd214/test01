//
//  HomeViewController.h
//  foundation
//
//  Created by ios on 15-1-5.
//  Copyright (c) 2015年 716team. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTableView.h"

@interface HomeViewController : BaseViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_picArrays;//轮播图 数据
    NSMutableArray *_tapListArray;//tag_list 按钮数据
    NSMutableArray *_selectArray;//精选集 --section1数据
    NSMutableArray *_kitchenArray ;//厨房宝典   ---section2 数据
    
    UIScrollView *_firstScrollView;
    //创建主要滑动视图
    UIScrollView *_scrollView;
    //创建PageControl控件
    UIPageControl *_pageCtrl;
    //滑动广告model数组
    NSMutableArray *_adModels;
    //创建头视图名字的数组
    NSArray *_headerSectionName;
    //往下滑出的视图
    UIView * _placeView;
    //头部视图
    UIView *_headView;
    BaseTableView *_homeTableView;

}

@end
