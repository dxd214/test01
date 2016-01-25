//
//  GoodCell.h
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/15.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodModel.h"
@interface GoodCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (nonatomic, retain) GoodModel *model;

@end
