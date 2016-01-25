//
//  SelectInfoItem.h
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/21.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelecteInfoModel.h"
@interface SelectInfoItem : UICollectionViewCell
@property(nonatomic,retain)SelecteInfoModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
