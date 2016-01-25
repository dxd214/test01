//
//  SelectItem.m
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/21.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "SelectItem.h"

@implementation SelectItem

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(SelectModel *)model
{
    if (_model != model)
    {
        _model = model;
        [_imgView sd_setImageWithURL:[NSURL URLWithString:model.Cover]];
        NSString *string = [NSString stringWithFormat:@"%@道菜",model.RecipeCount];
        _countLabel.text = string;
        _NameLabel.text = model.Title;
        _userName.text = model.UserName;
        [_userImg sd_setImageWithURL:[NSURL URLWithString:model.Avatar]];
    }
}

@end
