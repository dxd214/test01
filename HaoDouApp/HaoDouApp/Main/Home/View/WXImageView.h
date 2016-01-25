//
//  WXImageView.h
//  WXHL_Weibo1.0
//
//  Created by JayWon on 13-7-1.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)(void);

@interface WXImageView : UIImageView
- (id)initWithFrame:(CGRect)frame
          WithIndex:(NSInteger )i
      WithLabelText:(NSString *)text
       WithUserText:(NSString *)name;
@property(nonatomic, copy)TapBlock tapBlock;

@end
