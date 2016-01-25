//
//  MovieViewController.m
//  foundation
//
//  Created by ios on 15-1-5.
//  Copyright (c) 2015年 716team. All rights reserved.
//

#import "SortViewController.h"
#import "BaseListViewController.h"
#import "SortModel.h"
#import "TagModel.h"
@interface SortViewController ()

@end

@implementation SortViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)viewDidLoad {
    self.title = @"分类";
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
     [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];;
    [params setObject:@"Search.getCateListV3" forKey:@"method"];
    [params setObject:@"1382446422" forKey:@"sessionid"];
    [DataService requestAFWithUrl:@"" params:params reqestHeader:nil httpMethod:@"GET" finishDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        [self loadNetData:result];
        [self initViews];
    } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
   
}
- (void)loadNetData:(id)result
{
    
    NSArray *listArray = result[@"result"][@"list"];
    NSMutableArray *sortModels = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in listArray)
    {
        SortModel *model = [[SortModel alloc]initWithContentsOfDic:dic];
        model.tagModels = [[NSMutableArray alloc]init];
        NSArray *tagsArray = dic[@"Tags"];
        for (NSDictionary *dic in tagsArray)
        {
            TagModel *tagModel = [[TagModel alloc]initWithContentsOfDic:dic];
            [model.tagModels addObject:tagModel];
        }
        
        [sortModels addObject:model];
    }
    self.dataList = sortModels;
}

- (void)initViews
{
    
    NSArray *imgsArray = @[@"category_ico_hot.png"
                           ,@"category_ico_prevalent.png"
                           ,@"category_ico_effect.png"
                           ,@"category_ico_recipe.png"
                           ,@"category_ico_taste.png"
                           ,@"category_ico_process.png"
                           ,@"category_ico_tool.png"
                           ,@"category_ico_savour.png"
                           ,@"category_ico_scene.png"];
    
    for (NSInteger i = 0 ; i < _dataList.count/3; i++)
    {
        for(NSInteger j = 0; j < 3;j++)
        {
            
            SortModel *model = _dataList[i * 3 + j];
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(j * (100+10)+30 , (90+10)*i+10, 100, 90)];
            [button setBackgroundImage:[UIImage imageNamed:@"button_pop_gray.png"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:imgsArray[i * 3 + j]] forState:UIControlStateNormal];
            button.tag = 400 + (i * 3 + j);
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 80, 30)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = model.Cate;
            
            [button addSubview:label];
            [self.view addSubview:button];
            
        }
    }
    
    
}

- (void)buttonAction:(UIButton *)button
{
    NSInteger tempTag = button.tag - 400;
    BaseListViewController *cookVC = [[BaseListViewController alloc]init];
    cookVC.hidesBottomBarWhenPushed = YES;
    SortModel *model = _dataList[tempTag];
    cookVC.subAssortomentData = model.tagModels;
    cookVC.subAssorTitle = model.Cate;
    cookVC.isCook = NO;
    [self.navigationController pushViewController:cookVC animated:YES];
    
}

@end
