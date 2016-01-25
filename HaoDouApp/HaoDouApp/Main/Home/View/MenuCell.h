//
//  MenuCell.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-25.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import <UIKit/UIKit.h>
//@import UIKit;

@interface MenuCell : UITableViewCell

@property(nonatomic,retain)NSArray *menuData;



// 视图一
@property (retain, nonatomic) IBOutlet UIImageView  *imgView1;
@property (retain, nonatomic) IBOutlet UILabel      *menuTitle;
@property (retain, nonatomic) IBOutlet UIButton     *lookButton;
@property (retain, nonatomic) IBOutlet UIButton     *loveButton;
@property (retain, nonatomic) IBOutlet UIImageView  *userImg;
@property (retain, nonatomic) IBOutlet UILabel      *menuUserName;


//视图二
@property (retain, nonatomic) IBOutlet UIImageView *imgView2;
@property (retain, nonatomic) IBOutlet UILabel *menuTitle2;
@property (retain, nonatomic) IBOutlet UIButton *lookButton2;
@property (retain, nonatomic) IBOutlet UIButton *loveButton2;
@property (retain, nonatomic) IBOutlet UIImageView *userImg2;
@property (retain, nonatomic) IBOutlet UILabel *menuUserName2;




@end
