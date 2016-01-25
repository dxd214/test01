//
//  BaseViewController.h
//  foundation
//
//  Created by ios on 15-1-5.
//  Copyright (c) 2015年 716team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@class MBProgressHUD;
typedef void(^ClickBlock)(UIButton *button);
@interface BaseViewController : UIViewController

@property(nonatomic, retain)MBProgressHUD *hud;

//加载提示
- (void)showHUD:(NSString *)title;

//隐藏提示
- (void)hiddenHUD;

//是否登录
- (BOOL)userIsLogin;
//历史浏览
@property(nonatomic,retain)NSMutableDictionary *nearSeachDic;
@property(nonatomic,retain)NSMutableDictionary *nearLookDic;
- (AppDelegate *)appDelegete;
@end
