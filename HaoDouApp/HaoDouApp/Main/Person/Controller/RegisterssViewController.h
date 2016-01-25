//
//  RegisterssViewController.h
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/28.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterssViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UITextField *oncePwd;
- (IBAction)buttonAction:(id)sender;

@end
