//
//  logInViewController.m
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-30.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseInfoViewController.h"
#import "DataService.h"
#import "LoginListModel.h"
#import "LoginModel.h"
#import "RegisterssViewController.h"
#import "PersonViewController.h"

@interface LoginViewController ()
{
    UITextField *_userField;
    UITextField *_pwField;
}
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    self.title = @"登陆";
    [super viewDidLoad];
    _loginTableView.backgroundColor = [UIColor clearColor];
    _loginTableView.delegate = self;
    _loginTableView.dataSource = self;
    _loginTableView.tableFooterView = _footView;
    
    
    //定制注册按钮
    UIButton *right = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [right setBackgroundImage:[UIImage imageNamed:@"Default_shicai.png"] forState:UIControlStateNormal];
    [right setTitle:@"注册" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(createUser) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
;

}

//注册
- (void)createUser
{
    
    RegisterssViewController *registerVC = [[RegisterssViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}


#pragma mark -tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 50, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:label];
    
    if (indexPath.row == 0 && !_userField) {
        _userField = [[UITextField alloc]initWithFrame:CGRectMake(label.right-5, 8,270, 30)];
        _userField.borderStyle = UITextBorderStyleNone;
        [cell.contentView addSubview:_userField];
    }
    
    if (indexPath.row == 1 && !_pwField) {
        _pwField = [[UITextField alloc]initWithFrame:CGRectMake(label.right-5, 8,270, 30)];
        _pwField.borderStyle = UITextBorderStyleNone;
        _pwField.secureTextEntry = YES;
        [cell.contentView addSubview:_pwField];
    }

    
    if (indexPath.row == 0)
    {
        label.text = @"账号:";
        _userField.placeholder = @"请输入邮箱账号和手机密码";
    }else if(indexPath.row == 1)
    {
        label.text = @"密码:";
        _pwField.placeholder = @"请输入密码";
        
    }

    
    
    return cell;
}



//新浪登录接口
- (IBAction)sinaAction:(id)sender
{

    BaseInfoViewController *sinaVC = [[BaseInfoViewController alloc]init];
    sinaVC.Celltitle = @"新浪";
    sinaVC.cellUrl = @"https://api.weibo.com/oauth2/authorize?client_id=1676587957&redirect_uri=http%3A%2F%2Fwww.haodou.com%2Fapi%2Foauth_redirect.php%3Fcallback%3Drecipe%3A%2F%2Fiphone.haodou.com&response_type=code&display=mobile&with_offical_account=1";
    [self.navigationController pushViewController:sinaVC animated:YES];
}

//QQ登录接口
- (IBAction)QQAction:(id)sender
{
    BaseInfoViewController *QQVC = [[BaseInfoViewController alloc]init];
    QQVC.Celltitle = @"腾讯";
    QQVC.cellUrl = @"http://openapi.qzone.qq.com/oauth/show?which=Login&display=mobile&client_id=200063&redirect_uri=recipe%3A%2F%2Fiphone.haodou.com&token_key=&state=&switch=0&status_version=&status_os=&update_auth=1&sign=&sdkv=&need_pay=0&time=&pf=&which=ConfirmPage&response_type=code&has_auth=1&status_machine=&src=1&sdkp=&tid=1383215278&serial=&openapi=1010_1020_2020_2030_1050_1022";
    [self.navigationController pushViewController:QQVC animated:YES];
}

//好豆登录
- (IBAction)loginHaoDouAction:(id)sender
{
    [_userField resignFirstResponder];
    [_pwField resignFirstResponder];
    
    if (_userField.text.length == 0 || _pwField.text.length == 0)
    {
        NSLog(@"请输入相应地信息");
         return;
    }
    //获取数据
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserInfo.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if ([ dic[@"name"] isEqualToString:_userField.text] && [dic[@"passWord"] isEqualToString:_pwField.text])
    {
        //保存密码
        NSDictionary *passWord = dic;
        [[NSUserDefaults standardUserDefaults]setObject:passWord forKey:KPassWord];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self.navigationController popViewControllerAnimated:YES];

//        PersonViewController *personVC = [[PersonViewController alloc]init];
//        personVC.navigationItem.leftBarButtonItem = nil;
//        personVC.navigationItem.backBarButtonItem = nil;
//        [self.navigationController pushViewController:personVC animated:YES];
        
    }
    
    //项目实战
//    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
//    
//    [params setObject:_userField.text forKey:@"name"];
//    [params setObject:_pwField.text forKey:@"pwd"];
//    [params setObject:@"1383287714" forKey:@"sessionid"];
//    [params setObject:@"Account.login" forKey:@"method"];
//    [DataService requestAFWithUrl:@"" params:params reqestHeader:nil httpMethod:@"GET" finishDidBlock:^(AFHTTPRequestOperation *operation, id result)
//    {
//        NSDictionary *dic = result[@"result"];
//        NSLog(@"%@",dic[@"errormsg"]);
//        
//        [self loadNetData:result];
//    } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];

}

//获得用户登录数据并保存密码
- (void)loadNetData:(id)result
{
    NSDictionary *resultDic = [result objectForKey:@"result"];
    NSString *errorString = [resultDic objectForKey:@"errormsg"];
    if (errorString)
    {
        return;
    }
    else
    {
        //保存密码
        NSDictionary *passWord = resultDic;
        [[NSUserDefaults standardUserDefaults]setObject:passWord forKey:KPassWord];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self loadloginMessageData];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
    
    
}


//获得登录用户信息，并保存
- (void)loadloginMessageData
{
    NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:KPassWord];
    _loginModel = [[LoginModel alloc]initWithContentsOfDic:dic];
    
    //请求体
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:_loginModel.UserId forKey:@"userid"];
    [params setObject:@"3188998" forKey:@"uid"];
    [params setObject:_loginModel.Sign forKey:@"sign"];
    [params setObject:@"1383299106" forKey:@"sessionid"];
    [params setObject:@"RecipeUser.getuserinfo" forKey:@"method"];
    [DataService requestAFWithUrl:@"" params:params reqestHeader:nil httpMethod:@"GET" finishDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        NSDictionary *resultDic = [result[@"result"] objectForKey:@"info"];
        [[NSUserDefaults standardUserDefaults]setObject:resultDic forKey:KUserMessage];
    } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
   
}

@end
