//
//  SelectInfoItem.m
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/21.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "SelectInfoItem.h"

@implementation SelectInfoItem

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(SelecteInfoModel *)model
{
    if (_model != model)
    {
        _model = model;
        [_imgView sd_setImageWithURL:[NSURL URLWithString:model.Cover]];
        _nameLabel.text = model.Title;

    }
}
@end
