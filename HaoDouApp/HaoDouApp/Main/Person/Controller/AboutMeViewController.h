//
//  AboutMeViewController.h
//  MyDoctor
//
//  Created by wxhl_zy012 on 14-12-3.
//  Copyright (c) 2014年 www.716.com. All rights reserved.
//

#import "BaseViewController.h"

#pragma mark -
/**
  `AboutMeViewController` 是 `BaseViewController` 的子类，主要展示本应用的制作团队，以及涉及的法律条文
 ## 下面是AboutMeViewController视图控制器的属性列表
 *
 *  @param tableView    表视图
 *  @param data         数据源
 *
 */
@interface AboutMeViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    
}

@property (nonatomic, retain) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *data;

@end
