//
//  CookBookViewController.m
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-26.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "BaseListViewController.h"
#import "CookListtModel.h"
#import "BaseInfoViewController.h"
#import "TagModel.h"
#import "TagListViewController.h"

@interface BaseListViewController ()

@end

@implementation BaseListViewController

- (void)viewDidLoad
{
   
    [super viewDidLoad];
    if (_isCook == YES)
    {
        self.title = @"厨房宝典";
        [self loadData];
    }
    else
    {
        self.title = _subAssorTitle;
        _dataList = _subAssortomentData;
        [self initViews];
    }
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"1382662289" forKey:@"sessionid"];
    [params setObject:@"Wiki.getListByType" forKey:@"method"];
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
    NSArray *listArray = [resultDic objectForKey:@"list"];
    NSMutableArray *CookListModels = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in listArray)
    {
        CookListtModel *model = [[CookListtModel alloc]initWithContentsOfDic:dic];
        [CookListModels addObject:model];
    }
    
     _dataList =  CookListModels;
}

- (void)initViews
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"CookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(285, 12, 20, 20)];
        imgView.backgroundColor = [UIColor clearColor];
        imgView.image = [UIImage imageNamed:@"ico_radius_arrow_right.png"];
        [cell.contentView addSubview:imgView];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (_isCook == YES)
    {
        CookListtModel *model = _dataList[indexPath.row];
        cell.textLabel.text = model.Title;
    }
    else
    {
        TagModel *model = _subAssortomentData[indexPath.row];
        cell.textLabel.text = model.Name;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    return cell;


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_isCook == YES)
    {
        BaseInfoViewController *subWebView = [[BaseInfoViewController alloc]init];
        CookListtModel *model = _dataList[indexPath.row];
        subWebView.Celltitle = model.Title;
        subWebView.cellUrl = model.Url;
        
        [self.navigationController pushViewController:subWebView animated:YES];
       
    }
    else
    {
        TagListViewController *detailVC = [[TagListViewController alloc]init];
        TagModel *model = _dataList[indexPath.row];
        detailVC.tagId = model.TagId;
        detailVC.labelTitle = model.Name;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
}



@end
