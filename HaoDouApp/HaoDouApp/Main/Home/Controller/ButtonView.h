//
//  ButtonView.h
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/10.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonView : UIImageView
typedef void(^ButtonBlock)(void);
- (id)initWithFrame:(CGRect)frame
      WithBgImgName:(NSString*)bgImgName
        WithButtonImgName:(NSString *)name
          WithTitle:(NSString *)title;
@property(nonatomic, copy)ButtonBlock buttonBlock;
@end
