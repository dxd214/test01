//
//  NewsViewController.h
//  foundation
//
//  Created by ios on 15-1-5.
//  Copyright (c) 2015年 716team. All rights reserved.
//

#import "BaseViewController.h"

@interface WalkViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@property(nonatomic,assign)BOOL isIndex;
@property(nonatomic,retain)NSArray *dataList;
@property(nonatomic,retain)NSArray *myData;

@end
