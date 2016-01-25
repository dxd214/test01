//
//  SelectInfoViewController.m
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/15.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "UserListViewController.h"
#import "GoupListModel.h"
#import "SelecteInfoModel.h"
#import "SelectInfoItem.h"
#import "DetailCookViewController.h"

@interface UserListViewController ()

@end

@implementation UserListViewController

- (void)viewDidLoad {
    self.title = _selectListTitle;
    [super viewDidLoad];
    _dataList = [[NSMutableArray alloc]init];
    [self loadData];
    
}

- (void)loadData
{
   
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_cid forKey:@"cid"];
    [params setObject:@"Collect.getInfo" forKey:@"method"];
    [params setObject:@"1382757727" forKey:@"sessionid"];
    
    [DataService requestAFWithUrl:@"" params:params reqestHeader:nil httpMethod:@"GET" finishDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        [self loadNetData:result];
        [self initViews];
    } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}
- (void)loadNetData:(id)result
{

    NSDictionary *infoDic = result[@"result"][@"info"];
    
    NSArray *listArr = infoDic[@"RecipeList"];
    NSMutableArray *selecteInfoModels = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in listArr)
    {
        SelecteInfoModel *model  = [[SelecteInfoModel alloc]initWithContentsOfDic:dic];
        [selecteInfoModels addObject:model];
    }
    _dataList = selecteInfoModels;
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
    UINib *nib = [UINib nibWithNibName:@"SelectInfoItem"
                                bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"SelectInfoItem"];
    
}
#pragma mark - UICollectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SelectInfoItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"SelectInfoItem" forIndexPath:indexPath];
    cell.model = _dataList[indexPath.item];
    return cell;

    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SelecteInfoModel *model = _dataList[indexPath.item];
    DetailCookViewController *detailBookVC = [[DetailCookViewController alloc]init];
    detailBookVC.rid = model.Rid;
    detailBookVC.cookTitile = model.Title;
    
    [self.navigationController pushViewController:detailBookVC animated:YES];
    
}




@end
