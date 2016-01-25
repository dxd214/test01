//
//  WalkInfoViewController.h
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/16.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "BaseViewController.h"

@interface WalkInfoViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSArray *dataList;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,retain)NSString *myTitle;
@end
