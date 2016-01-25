//
//  FavoriteViewController.m
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/10.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "FavoriteViewController.h"
#import "WalkCell.h"
#import "ShopModel.h"
#import "DataServicess.h"
@interface FavoriteViewController ()

@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    self.title = @"我的收藏";
    [super viewDidLoad];
    [self _initView];
    [self loadData];
}
- (void)_initView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
- (void)loadData
{
    //时间戳
    NSInteger t = (NSInteger)[[NSDate date] timeIntervalSince1970];
    NSString *time = [NSString stringWithFormat:@"%ld",t];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"Topic.getGroupIndexData" forKey:@"method"];
    [params setObject:@"1429166473" forKey:@"sessionid"];
    [params setObject:time  forKey:@"timestamp"];
    
    [DataServicess requestAFWithUrl:@"" params:params reqestHeader:nil httpMethod:@"GET" finishDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        [self loadNetData:result];
        [self _initView];
    } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)loadNetData:(id)result
{
    //首页表格数据
    NSArray *listArray = result[@"result"][@"list"];
    NSMutableArray *ShopModels = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in listArray)
    {
        ShopModel *model = [[ShopModel alloc]initWithContentsOfDic:dic];
        [ShopModels addObject:model];
    }
    
    _dataList = ShopModels;
}

#pragma mark -tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"CookBookCell";
    WalkCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WalkCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = _dataList[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BaseInfoViewController *webView = [[BaseInfoViewController alloc]init];
    ShopModel *model = _dataList[indexPath.row];
    NSString *url = [NSString stringWithFormat:@"http://m.haodou.com/%@.html?id=%@",model.TopicId,model.TopicId];
    webView.Celltitle = model.Title;
    webView.cellUrl = url;
    
    [self.navigationController pushViewController:webView animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}





@end
