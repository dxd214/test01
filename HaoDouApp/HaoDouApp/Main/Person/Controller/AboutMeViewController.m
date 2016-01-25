//
//  AboutMeViewController.m
//  MyDoctor
//
//  Created by wxhl_zy012 on 14-12-3.
//  Copyright (c) 2014年 www.716.com. All rights reserved.
//

#import "AboutMeViewController.h"
#import "AboutMeModel.h"
@interface AboutMeViewController ()

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    self.title = @"关于我们";
    [super viewDidLoad];
    _data = [NSMutableArray array];
    [self _initViews];
    [self _loadData];
}
/**
 *  加载视图
 */
- (void)_initViews
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
    
    //表的头视图
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _tableView.width, 100)];
    headerView.userInteractionEnabled = YES;
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 100, 30)];
    nameLabel.font = [UIFont boldSystemFontOfSize:17];
    nameLabel.text = @"我的菜谱";
    [headerView addSubview:nameLabel];
    
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 40, 250, 20)];
    versionLabel.text = @"软件版本：2.8.7（2014-11-24）";
    versionLabel.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:versionLabel];

    UILabel *appLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 60, 120, 20)];
    appLabel.text = @"软件授权：好豆菜谱";
    appLabel.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:appLabel];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-70, 20, 57, 57)];
    imgView.image = [UIImage imageNamed:@"icon"];
    [headerView addSubview:imgView];

    _tableView.tableHeaderView = headerView;
    
}
/**
 加载数据
 
 @warning 这是一段警告文字
 */- (void)_loadData
{
    //获取数据
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"AboutMe.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    for(NSDictionary *dic in array)
    {
        AboutMeModel *model = [[AboutMeModel alloc]init];
        model.title = dic[@"title"];
        model.detail = dic[@"detail"];
        [_data addObject:model];
    }
    [_tableView reloadData];
}
#pragma mark- UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}
/**
 *  创建单元格
 *
 *  @param tableView 表视图
 *  @param indexPath 下标
 *
 *  @return 单元格Cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"aboutCell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iden];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [_data[indexPath.row] title];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = [UIColor greenColor];
    cell.detailTextLabel.text = [_data[indexPath.row] detail];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *tel = @"4006571918";//电话号
    NSString *email =@"app@hdcp.com";//邮件地址
    NSString *myUrl = @"www.haodou.com";//网址
    NSString *str = [NSString string];
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //点击单元格事件
    if (indexPath.row == 0)
    {
        //网页
        str = [NSString stringWithFormat:@"http://%@",myUrl];
    }
    else if(indexPath.row == 1)
    {
        //电话
        str = [NSString stringWithFormat:@"tel://%@",tel];
    }
    else if(indexPath.row == 2)
    {
        //邮件
        str = [NSString stringWithFormat:@"mailto://%@",email];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]]; //跳转

}



@end
