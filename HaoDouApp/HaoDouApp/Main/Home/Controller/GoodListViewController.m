//
//  GoodFoodViewController.m
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/10.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "GoodListViewController.h"
#import "GoodModel.h"
#import "GoodCell.h"
@interface GoodListViewController ()

@end

@implementation GoodListViewController

- (void)viewDidLoad {
    self.title = @"营养餐桌";
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"1382753430" forKey:@"sessionid"];
    [params setObject:@"Wiki.getListByType" forKey:@"method"];
    [params setObject:@"20" forKey:@"limit"];
    [params setObject:@"2" forKey:@"type"];
    [params setObject:@"0" forKey:@"offset"];
    
    [DataService requestAFWithUrl:@"" params:params reqestHeader:nil httpMethod:@"GET" finishDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        [self loadNetData:result];
        [self initViews];
    } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadNetData:(id)result
{
    NSDictionary *resultDic = [result objectForKey:@"result"];
    NSArray *listArr = [resultDic objectForKey:@"list"];
    NSMutableArray *goodModels = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in listArr)
    {
        GoodModel *model = [[GoodModel alloc]initWithContentsOfDic:dic];
        [goodModels addObject:model];
        
    }
    
    _dataList = goodModels;
    
}


- (void)initViews
{
    BaseTableView *tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];

}

#pragma mark -tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return  _dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"iden";
    GoodCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:iden];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"GoodCell" owner:self options:nil]lastObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.model = _dataList[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GoodModel *model = _dataList[indexPath.row];
    BaseInfoViewController *infoVC = [[BaseInfoViewController alloc]init];
    infoVC.cellUrl = model.Url;
    infoVC.Celltitle = model.Title;
    
    [self.navigationController pushViewController:infoVC animated:YES];
}
@end
