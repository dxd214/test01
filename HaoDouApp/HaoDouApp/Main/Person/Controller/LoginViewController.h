//
//  logInViewController.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-30.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

/**
 `LoginViewController` 是 `BaseViewController` 的子类，用于登陆
 ## 测试黑色字体
 */

#import "BaseViewController.h"
@class LoginModel;
@class LoginListModel;

@interface LoginViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)LoginModel *loginModel;

@property (retain, nonatomic) IBOutlet UITableView *loginTableView;
@property (retain, nonatomic) IBOutlet UIView *footView;
- (IBAction)sinaAction:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *QQAction;

- (IBAction)QQAction:(id)sender;
- (IBAction)loginHaoDouAction:(id)sender;


@end
