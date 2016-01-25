//
//  PersonViewController.h
//  foundation
//
//  Created by ios on 15-1-5.
//  Copyright (c) 2015年 716team. All rights reserved.
//

#import "BaseViewController.h"

@interface PersonViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    long long sum;  //用于存放图片的缓存大小   单位：字节
}
@property (nonatomic, retain) UITableView *tableView;
@property(nonatomic, strong) NSArray *data;


@end
