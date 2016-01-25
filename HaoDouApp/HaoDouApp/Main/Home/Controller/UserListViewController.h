//
//  SelectInfoViewController.h
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/15.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "BaseViewController.h"
#import "SelsctListModel.h"
@protocol SelecteListDelegate <NSObject>

//返回数组数据
- (void)responseData:(NSArray *)array;

@end
@interface UserListViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, assign)id<SelecteListDelegate> delegate;

@property(nonatomic,copy)NSString *cid;
@property(nonatomic,copy)NSString *selectListTitle;
@property(nonatomic,retain)SelsctListModel *selectListModel;
@property(nonatomic,retain)NSArray *dataList;
@end
