//
//  MenuCell.m
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-25.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "MenuCell.h"
#import "DetailMenuModel.h"
#import "UIImageView+WebCache.h"
#import "DetailCookViewController.h"
#import "UIView+Additions.h"

@implementation MenuCell

- (void)setMenuData:(NSArray *)menuData
{
    
    if (_menuData != menuData)
    {
        _menuData = menuData;
        
        DetailMenuModel *model1 = _menuData[0];
        DetailMenuModel *model2 = _menuData[1];
             
        [_imgView1 sd_setImageWithURL:[NSURL URLWithString:model1.Cover]];
        _imgView1.userInteractionEnabled = YES;
        _menuTitle.text = model1.Title;
       [_lookButton setTitle:[model1.CommentCount stringValue] forState:UIControlStateNormal];;
       [_loveButton setTitle:[model1.FavoriteCount stringValue] forState:UIControlStateNormal];
        [_userImg sd_setImageWithURL:[NSURL URLWithString:model1.Avatar]];
        _menuUserName.text = model1.UserName;
        
        [_imgView2 sd_setImageWithURL:[NSURL URLWithString:model2.Cover]];
        _imgView2.userInteractionEnabled = YES;
        _menuTitle2.text = model2.Title;
        [_lookButton2 setTitle:[model2.CommentCount stringValue] forState:UIControlStateNormal];;
        [_loveButton2 setTitle:[model2.FavoriteCount stringValue ]forState:UIControlStateNormal];
        [_userImg2 sd_setImageWithURL:[NSURL URLWithString:model2.Avatar]];
        _menuUserName2.text = model2.UserName;
        
        
        UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestAction:)];
        UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestAction:)];
        [_imgView1 addGestureRecognizer:tapOne];
        [_imgView2 addGestureRecognizer:tapTwo];
        
        _imgView1.tag =120;
        _imgView2.tag = 121;
        
        
        
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)tapGestAction:(UITapGestureRecognizer *)tap
{
    NSInteger tempTag = tap.view.tag - 120;
    DetailMenuModel *model = _menuData[tempTag];
    DetailCookViewController *detailCookVC = [[DetailCookViewController alloc]init];
    detailCookVC.rid = model.RecipeId;
    detailCookVC.cookTitile = model.Title;
    [self.viewController.navigationController pushViewController:detailCookVC animated:YES];
    
    
}

@end
