//
//  GoodCell.m
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/15.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "GoodCell.h"

@implementation GoodCell

- (void)awakeFromNib {
   
}
- (void)setModel:(GoodModel *)model
{
    if (_model != model)
    {
        _model = model;
        [_imgView sd_setImageWithURL:[NSURL URLWithString:model.Image]];
        _nameLabel.text = model.Title;
        _descLabel.text = model.Content;
    }
}


@end
