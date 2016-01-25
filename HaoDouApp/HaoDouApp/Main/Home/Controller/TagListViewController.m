//
//  DetailMeumViewController.m
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/10.
//  Copyright (c) 2015年 716. All rights reserved.
//
/*
 获得数据，自定义表格，每个cell分左右两部分
 */
#import "TagListViewController.h"
#import "DetailMenuModel.h"
#import "StuffModel.h"
#import "MenuCell.h"
#import "MenuTableView.h"
@interface TagListViewController ()

@end

@implementation TagListViewController

- (void)viewDidLoad {
    self.title = _labelTitle;
    [super viewDidLoad];
    [self loadData];

}
#pragma mark --解析网络数据
- (void)loadData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_tagId forKey:@"tagid"];
    [params setObject:@"" forKey:@"keyword"];
    [params setObject:@"20" forKey:@"limit"];
    [params setObject:@"0" forKey:@"offset"];
    [params setObject:@"Search.getListV3" forKey:@"method"];
    [params setObject:@"1382662746" forKey:@"sessionid"];
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
    NSMutableArray *detailArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in listArr)
    {
        DetailMenuModel *model = [[DetailMenuModel alloc]initWithContentsOfDic:dic];
        
        NSMutableArray *subArr = [[NSMutableArray alloc]init];
        NSArray *listSubArr = [dic objectForKey:@"Stuff"];
        
        for (NSDictionary *subDic in listSubArr)
        {
            StuffModel *stuffModel = [[StuffModel alloc]initWithContentsOfDic:subDic];
            [subArr addObject:stuffModel];
        }
        model.stuffArray = subArr;
        [detailArray addObject:model];
        
        
    }
    
    self.detailData = detailArray;
    
    
    [self handleData];
}

- (void)handleData
{
    NSMutableArray *Array2D = [[NSMutableArray alloc]init];
    NSMutableArray *subArray  = nil;
    for (int i = 0 ; i < self.detailData.count; i++)
    {
        if (i%2==0)
        {
            subArray = [[NSMutableArray alloc]initWithCapacity:2];
            
            [Array2D addObject:subArray];
            
        }
        DetailMenuModel *model = self.detailData[i];
        [subArray addObject:model];

    }
    self.detail2Data = Array2D;
}


#pragma mark --定义视图
- (void)initViews
{
    MenuTableView *tableView = [[MenuTableView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    tableView.menuData = _detail2Data;
    [self.view addSubview:tableView];

}



@end
