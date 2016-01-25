//
//  WalkCell.h
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/16.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopModel.h"
@interface WalkCell : UITableViewCell
@property(nonatomic,retain)ShopModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end
