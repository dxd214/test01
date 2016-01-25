//
//  SelectItem.h
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/21.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectModel.h"
@interface SelectItem : UICollectionViewCell
@property(nonatomic,retain)SelectModel *model;
@property (retain, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@end
