//
//  HomeCell.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-23.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Select_listModel.h"
#import "KitchenModel.h"

@interface HomeCell : UITableViewCell


@property(nonatomic,retain)Select_listModel *model_s;
@property(nonatomic,retain)KitchenModel *model_k;


//厨房宝典
@property (retain, nonatomic) IBOutlet UIImageView *userImg;

@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UILabel *writer;
@property (retain, nonatomic) IBOutlet UILabel *desc;



@end
