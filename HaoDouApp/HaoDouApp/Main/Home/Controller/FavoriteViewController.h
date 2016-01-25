//
//  FavoriteViewController.h
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/10.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "BaseViewController.h"

@interface FavoriteViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}

@property(nonatomic,retain)NSArray *dataList;

@end
