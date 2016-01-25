//
//  SelecttViewController.m
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/21.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "UserGroupListViewController.h"
#import "DataService.h"
#import "SelectModel.h"
#import "SelectItem.h"
#import "UserListViewController.h"

@interface UserGroupListViewController ()

@end

@implementation UserGroupListViewController
- (void)viewDidLoad {
    self.title = @"精选集";
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"1382757233" forKey:@"sessionid"];
    [params setObject:@"Collect.getRecomList" forKey:@"method"];
    [params setObject:@"20" forKey:@"limit"];
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
    NSDictionary *resultDic = result[@"result"];
    NSArray *listArray = resultDic[@"list"];
    NSMutableArray *selectModels = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in listArray)
    {
        SelectModel *model = [[SelectModel alloc]initWithContentsOfDic:dic];
        [selectModels addObject:model];
        
    }
    self.dataList = selectModels;
    
}

- (void)initViews
{
    //创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置item的尺寸
    flowLayOut.itemSize = CGSizeMake(160,200);
    //设置行间距
    flowLayOut.minimumLineSpacing = 0;
    //设置item之间的距离
    flowLayOut.minimumInteritemSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) collectionViewLayout:flowLayOut];
    //设置代理
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"SelectItem"
                                bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"SelectItem"];
    
}
#pragma mark - UICollectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SelectItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"SelectItem" forIndexPath:indexPath];
    cell.model = _dataList[indexPath.item];
    
    return cell;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UserListViewController *selectListVC = [[UserListViewController alloc]init];
    SelectModel *model = _dataList[indexPath.row];
    selectListVC.cid = model.OmniId;
    selectListVC.selectListTitle = model.Title;
    [self.navigationController pushViewController:selectListVC animated:YES];
    
}

@end
