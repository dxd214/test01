//
//  BaseMenuView.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-25.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "BaseTableView.h"

@interface MenuTableView : BaseTableView<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,retain)NSArray *menuData;

@end
