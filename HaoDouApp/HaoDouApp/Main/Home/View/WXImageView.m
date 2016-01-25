//
//  WXImageView.m
//  WXHL_Weibo1.0
//
//  Created by JayWon on 13-7-1.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WXImageView.h"

@implementation WXImageView

- (id)initWithFrame:(CGRect)frame
          WithIndex:(NSInteger )i
      WithLabelText:(NSString *)text
      WithUserText:(NSString *)name
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        [self initViewsWithText:text
                      WithIndex:i
                   WithUserText:(NSString *)name];
    }
    return self;
}

/**
 *  创建视图，并添加单击手势
 *
 *  @param text 图片名称
 *  @param i    图片下标
 *  @param name 用户名
 */
-(void)initViewsWithText:(NSString *)text WithIndex:(NSInteger )i WithUserText:(NSString *)name
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGesture];
    //添加标题
    [self _initLabelView:i withString:text withName:name];
}

/**
 *  创建标题简介
 *
 *  @param text 图片名称
 *  @param i    图片下标
 *  @param name 用户名
 */
- (void)_initLabelView:(NSInteger )i withString:(NSString *)text withName:(NSString *)name
{
    UIView *smallView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bottom-30, kScreenWidth, 30)];
    smallView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addSubview:smallView];
    //菜名
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5 , 100, 28)];
    firstLabel.font = [UIFont boldSystemFontOfSize:18];
    firstLabel.textColor = [UIColor whiteColor];
    firstLabel.backgroundColor = [UIColor clearColor];
    firstLabel.text = text;
    [firstLabel sizeToFit];
    
    [smallView addSubview:firstLabel];
    
    
    //厨房名
    UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLabel.right + 5, 0, 160, 28)];
    secondLabel.text = [NSString stringWithFormat:@" by %@",name];
    secondLabel.textColor = [UIColor whiteColor];
    secondLabel.backgroundColor = [UIColor clearColor];
    secondLabel.font = [UIFont systemFontOfSize:16];
    [smallView addSubview:secondLabel];
}
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.tapBlock) {
        _tapBlock();
    }
}




@end
