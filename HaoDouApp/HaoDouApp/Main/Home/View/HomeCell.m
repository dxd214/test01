//
//  HomeCell.m
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-23.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "HomeCell.h"
#import "UIView+Additions.h"


@implementation HomeCell

//精选集
- (void)setModel_s:(Select_listModel *)model_s
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_model_s != model_s)
    {
        _model_s = model_s;
        [_userImg sd_setImageWithURL:[NSURL URLWithString:model_s.Cover]];
        _title.text = model_s.Title;
        _writer.text = model_s.UserName;
        _desc.text = model_s.Content;
    }
}
//厨房宝典
- (void)setModel_k:(KitchenModel *)model_k
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_model_k != model_k)
    {
        _model_k = model_k;
        [_userImg sd_setImageWithURL:[NSURL URLWithString:model_k.Cover]];
        _title.text = model_k.Title;
        _writer.text = model_k.UserName;
        _desc.text = model_k.Content;
    }
}


@end
