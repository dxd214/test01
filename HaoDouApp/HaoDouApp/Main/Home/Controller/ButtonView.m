//
//  ButtonView.m
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/10.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "ButtonView.h"

@implementation ButtonView

- (id)initWithFrame:(CGRect)frame
      WithBgImgName:(NSString*)bgImgName
  WithButtonImgName:(NSString *)name
          WithTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:bgImgName];
        self.userInteractionEnabled = YES;
        [self initViewsWithImgName:name
                      WithTitle:title];
    }
    return self;
}
- (void)initViewsWithImgName:name
                WithTitle:title
{
    //按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(2, 2, self.width-4, 60);
    [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    //标题
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, button.bottom, self.width, 20)];
    label.text = title;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14];
    [self addSubview:label];

}
-(void)buttonAction:(UIButton *)button
{
    if (self.buttonBlock) {
        _buttonBlock();
    }
}

@end
