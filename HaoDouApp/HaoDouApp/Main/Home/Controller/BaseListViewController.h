//
//  CookBookViewController.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-26.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign)BOOL isCook;
@property(nonatomic,retain)NSArray *CookBookData;
@property(nonatomic,retain)NSArray *dataList;
@property(nonatomic,retain)NSArray *subAssortomentData;
@property(nonatomic,copy)NSString *subAssorTitle;
@end
