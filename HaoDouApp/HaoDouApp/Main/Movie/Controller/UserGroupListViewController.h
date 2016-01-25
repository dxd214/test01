//
//  SelecttViewController.h
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/21.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "BaseViewController.h"

@interface UserGroupListViewController:BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,retain)NSArray *dataList;
@end
