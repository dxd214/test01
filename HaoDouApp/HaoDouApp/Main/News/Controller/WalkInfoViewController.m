//
//  WalkInfoViewController.m
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/16.
//  Copyright (c) 2015年 716. All rights reserved.
//
/*
 本页面数据接口有问题
 */
#import "WalkInfoViewController.h"
#import "WalkCell.h"
#import "DataServicess.h"
@implementation WalkInfoViewController
- (void)viewDidLoad
{
    self.title = _myTitle;
    [super viewDidLoad];
    [self initViews];
}
-(void)initViews
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}
#pragma mark - 加载数据
- (void)loadData
{
    //时间戳
    NSInteger t = (NSInteger)[[NSDate date] timeIntervalSince1970];
    NSString *time = [NSString stringWithFormat:@"%ld",t];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"Topic.getList" forKey:@"method"];
    [params setObject:time  forKey:@"nonce"];
    [params setObject:@"1429238902" forKey:@"sessionid"];
    [params setObject:time  forKey:@"timestamp"];
    [params setObject:@"5" forKey:@"cate_id"];
    [params setObject:@"10" forKey:@"limit"];
    [params setObject:@"0" forKey:@"offset"];
    

    [DataServicess requestAFWithUrl:@"" params:params reqestHeader:nil httpMethod:@"GET" finishDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        [self loadNetData:result];
        [self initViews];
    } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)loadNetData:(id)result
{
    //首页表格数据
    NSArray *listArray = result[@"result"][@"list"];
    NSMutableArray *leModels = [[NSMutableArray alloc]init];
    NSMutableArray *yingModels = [[NSMutableArray alloc]init];
    NSMutableArray *haoModels = [[NSMutableArray alloc]init];
    NSMutableArray *youModels = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in listArray)
    {
        ShopModel *model = [[ShopModel alloc]initWithContentsOfDic:dic];
        if ([model.Name isEqualToString:@"乐在厨房"])
        {
            [leModels addObject:model];
        }
        else if ([model.Name isEqualToString:@"营养健康"])
        {
            [yingModels addObject:model];
        }
        else if ([model.Name isEqualToString:@"好好生活"])
        {
            [haoModels addObject:model];
        }
        else
        {
            [youModels addObject:model];
        }
        
    }
    if (_index == 200)
    {
        _dataList = leModels;
    }
    else if (_index == 201)
    {
        _dataList = yingModels;
    }
    else if (_index == 202)
    {
        _dataList = haoModels;
    }
    else if (_index == 203)
    {
        _dataList = youModels;
    }

}

#pragma mark -tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"WalkCell";
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
    
    BaseInfoViewController *subWebView = [[BaseInfoViewController alloc]init];
    ShopModel *model = _dataList[indexPath.row];
    NSString *url = [NSString stringWithFormat:@"http://m.haodou.com/%@.html?id=%@",model.TopicId,model.TopicId];
    subWebView.Celltitle = model.Title;
    subWebView.cellUrl = url;
    
    [self.navigationController pushViewController:subWebView animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

@end
