//
//  DetailMeumViewController.h
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/10.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "BaseViewController.h"

@interface TagListViewController : BaseViewController
@property(nonatomic,copy)NSString *tagId;
@property(nonatomic,copy)NSString *labelTitle;
@property(nonatomic,retain)NSArray *detailData;
@property(nonatomic,retain)NSArray *detail2Data;
@end
