//
//  DetailCookBooksViewController.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-27.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "BaseViewController.h"
#import "DetailCookBookModel.h"
@interface DetailCookViewController : BaseViewController
{
    DetailCookBookModel *_model;
}
@property(nonatomic,copy)NSString *rid;
@property(nonatomic,copy)NSString *cookTitile;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *bigImage;
@property (weak, nonatomic) IBOutlet UILabel *commentLable;
@property (weak, nonatomic) IBOutlet UILabel *cookNameLable;
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *cookTime;
@property (weak, nonatomic) IBOutlet UILabel *infolabel;
@property (weak, nonatomic) IBOutlet UILabel *makeTime;
@property (weak, nonatomic) IBOutlet UIView *cookTimeView;


@property(nonatomic,copy)NSArray *cookArray;





@end
