//
//  RegisterssViewController.m
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/28.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "RegisterssViewController.h"

@interface RegisterssViewController ()

@end

@implementation RegisterssViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)buttonAction:(id)sender {
    if (_userName.text.length == 0)
    {
        NSLog(@"请输入用户名");
        return;
    }
    if (_passWord.text.length == 0)
    {
        NSLog(@"请输入密码");
        return;
    }
    if (![_passWord.text isEqualToString:_oncePwd.text]) {
        NSLog(@"两次密码输入不一致，请重新输入");
        return;
    }
    else
    {
        //写入本地数据文件
        NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserInfo.plist"];
        //创建需要写入的内容
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:_userName.text forKey: @"name"];
        [dic setValue:_passWord.text forKey: @"passWord"];
        [dic writeToFile:filePath atomically:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
