//
//  NewsViewController.m
//  foundation
//
//  Created by ios on 15-1-5.
//  Copyright (c) 2015年 716team. All rights reserved.
//

#import "WalkViewController.h"
#import "WalkInfoViewController.h"
#import "WalkCell.h"
#import "ShopModel.h"
#import "DataServicess.h"
#import "CateListModel.h"
@interface WalkViewController ()
{
    UIView *_headerView;
}
@end

@implementation WalkViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)viewDidLoad {
    self.title = @"逛逛";
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
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
        [self initViews];
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
    //对象归档
//    [self objectSort:ShopModels];
    
    
    //四个按钮数据
    NSArray *cateListArray = result[@"result"][@"cate_infos"];
    NSMutableArray *cateListModels = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in cateListArray)
    {
        CateListModel *model = [[CateListModel alloc]initWithContentsOfDic:dic];
        [cateListModels addObject:model];
    }
    _myData = cateListModels;
}
#pragma mark - 对象归档
- (void)objectSort:(NSMutableArray *)ShopModels
{
    // 序列化
    NSString *homePath = NSHomeDirectory();// 获取当前路径
    // 生成归档文件
    NSString *filePath = [homePath stringByAppendingPathComponent:@"test.archive"];
    // 创建 NSMutableData 对象
    NSMutableData *data = [NSMutableData data];
    // 创建归档对象
    NSKeyedArchiver *archive = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    // 归档数据
    [archive encodeObject:ShopModels forKey:@"array"];
    [archive finishEncoding];
    // 生成文件
    [data writeToFile:filePath atomically:YES];
}
- (void)initViews
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
   
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
    _headerView.backgroundColor = [UIColor whiteColor];
    for (NSInteger i = 0; i<4; i++)
    {
        CateListModel *model = _myData[i];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*(75+10)+20,10, 75, 75)];
        [button sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] forState:UIControlStateNormal];
        button.tag = 200+i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i*(75+10)+20,button.bottom+5, 75, 10)];
        label.tag = 300+i;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = model.Name;
        
        [_headerView addSubview:label];
        [_headerView addSubview:button];
        
        _tableView.tableHeaderView = _headerView;

    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)buttonAction:(UIButton *)button
{
    WalkInfoViewController *walkInfoVC = [[WalkInfoViewController alloc]init];
    UILabel *label = (UILabel *)[_headerView viewWithTag:button.tag+100];
    walkInfoVC.hidesBottomBarWhenPushed = YES;
    walkInfoVC.myTitle = label.text;
    walkInfoVC.index = button.tag;
    walkInfoVC.dataList = _dataList;
    [self.navigationController pushViewController:walkInfoVC animated:YES];
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
    webView.hidesBottomBarWhenPushed = YES;
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"最新话题";
}

@end
