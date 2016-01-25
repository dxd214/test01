//
//  PersonViewController.m
//  foundation
//
//  Created by ios on 15-1-5.
//  Copyright (c) 2015年 716team. All rights reserved.
//

#import "PersonViewController.h"
#import "LoginViewController.h"
#import "AboutMeViewController.h"
#import "FavoriteViewController.h"
@interface PersonViewController ()
{
    UIButton *_userFaceBtn;
    UILabel *_label;
}
@end

@implementation PersonViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.backBarButtonItem = nil;
    self.hidesBottomBarWhenPushed = NO;
}
- (void)viewDidLoad {
    self.title = @"豆窝";
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _initViews];
    [self loadData];

}
- (void)_initViews
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
    
    //表的头视图
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _tableView.width, 110)];
    headerView.backgroundColor = [UIColor lightGrayColor];
    headerView.userInteractionEnabled = YES;
    
    //头像按钮
    _userFaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _userFaceBtn.frame = CGRectMake((kScreenWidth-60)/2, 10, 60, 60);
    if ([self userIsLogin] == NO)
    {
        [_userFaceBtn setImage:[UIImage imageNamed:@"BigIconMan"] forState:UIControlStateNormal];
    }
    else
    {
        [_userFaceBtn setImage:[UIImage imageNamed:@"userappimage.jpg"] forState:UIControlStateNormal];
    }
    _userFaceBtn.layer.cornerRadius = 34.0;
    _userFaceBtn.layer.borderWidth = 1.0;
    _userFaceBtn.layer.borderColor =[UIColor clearColor].CGColor;
    _userFaceBtn.clipsToBounds = TRUE;
    [_userFaceBtn addTarget:self
                    action:@selector(buttonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_userFaceBtn];
    //登陆标签
    _label = [[UILabel alloc]initWithFrame:CGRectMake(_userFaceBtn.left+10, _userFaceBtn.bottom+10, 50, 20)];
    if ([self userIsLogin] == NO)
    {
        _label.text = @"登录";
    }
    else
    {
        _label.text = @"已登录";
    }
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:_label];
    _tableView.tableHeaderView = headerView;
    
    
}
//登陆
- (void)buttonAction:(UIButton *)button
{
    //我的收藏
    BOOL isLogin = [self userIsLogin];
    if (isLogin) {
        //清除缓存
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否退出登录？？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.accessibilityLanguage = @"123";
        [alertView show];
    }
    else
    {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}
- (void)loadData
{
    //读取plist文件
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MoreList.plist" ofType:nil];
    _data = [[NSArray alloc] initWithContentsOfFile:plistPath];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iden] ;
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
    }
    //显示的内容
    cell.textLabel.text = _data[indexPath.row];
    if (indexPath.row == 0)
    {
        cell.detailTextLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        //将字节转换成M
        float s = sum/(1024*1024.0);
        //添加显示缓存的label
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fM",s];
    }
    return cell;

    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   if (indexPath.row == 0)
    {
        //清除缓存
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否清除缓存？？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        
    }
    else if (indexPath.row == 1)
    {
        //我的收藏
        BOOL isLogin = [self userIsLogin];
        if (isLogin)
        {
            FavoriteViewController *myFavoriteVC = [[FavoriteViewController alloc]init];
            myFavoriteVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myFavoriteVC animated:YES];
            
        }
        else
        {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        
    }
    else if (indexPath.row == 2)
    {
        //关于我们
        AboutMeViewController *aboutVC = [[AboutMeViewController alloc]init];
        aboutVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutVC animated:YES];
        
    }
    else if (indexPath.row == 3)
    {
        //评分
        NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=469310248"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    
    
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.accessibilityLanguage isEqualToString:@"123"]) {
        if (buttonIndex == 1)
        {
             NSLog(@"注销账号");
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:KPassWord];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [_userFaceBtn setImage:[UIImage imageNamed:@"BigIconMan"] forState:UIControlStateNormal];
            _label.text = @"登录";
        }
    }
    else
    {
        if (buttonIndex == 1)
        {
            //清楚缓存
            [[SDImageCache sharedImageCache] clearDisk];
            
            //计算缓存大小
            [self refreshCaCheSize];
        }
    }
    
    
}

//计算本地缓存
- (void)refreshCaCheSize
{
    
    //取得图片缓存的路径
    NSString *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/ImageCache"];
    sum = 0;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取相应路径下所有文件的名字
    NSArray *fileName = [fileManager subpathsOfDirectoryAtPath:imagePath error:nil];
    
    for (NSString *str in fileName)
    {
        //获取图片的路径
        NSString *imgPath = [imagePath stringByAppendingPathComponent:str];
        //获取文件的属性字典
        NSDictionary *dic = [fileManager attributesOfItemAtPath:imgPath error:nil];
        
        long long size = [dic fileSize];
        
        sum += size;
        
    }
    //刷新视图
    [_tableView reloadData];
    
}



@end
