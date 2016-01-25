//
//  HomeViewController.m
//  foundation
//
//  Created by ios on 15-1-5.
//  Copyright (c) 2015年 716team. All rights reserved.
//

#import "HomeViewController.h"
#import "pic_listModel.h"
#import "Tag_listModel.h"
#import "Select_listModel.h"
#include "KitchenModel.h"
#import "HomeCell.h"
#import "WXImageView.h"
#import "ButtonView.h"

#import "DetailCookViewController.h"
#import "FavoriteViewController.h"
#import "LoginViewController.h"
#import "UserGroupListViewController.h"
#import "GoodListViewController.h"
#import "TagListViewController.h"
#import "BaseListViewController.h"

#import "SelectModel.h"
#import "UserListViewController.h"
@interface HomeViewController ()
{
    
}

@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    self.title = @"主页";
    [super viewDidLoad];
    _picArrays = [[NSMutableArray alloc]init];
    _tapListArray = [[NSMutableArray alloc]init];
    _selectArray = [[NSMutableArray alloc]init];
    _kitchenArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];

}
#pragma mark - 创建整体视图
//初始化视图
- (void)initViews
{
    _homeTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49-64) style:UITableViewStyleGrouped];
    _homeTableView.backgroundColor = [UIColor whiteColor];
    _homeTableView.sectionHeaderHeight = 20;
    _homeTableView.sectionFooterHeight = 50;
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 390)];
    _headView.backgroundColor = [UIColor clearColor];
    _homeTableView.tableHeaderView = _headView;
    [self initHeadViews];
    [self initButtons];
    [self.view addSubview:_homeTableView];

    
}
//初始化标题广告视图
#pragma mark -创建轮播图
- (void)initHeadViews
{
    //创建主要滑动视图
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _scrollView.contentSize=CGSizeMake(kScreenWidth, kScreenHeight*6-400);
    [_headView addSubview:_scrollView];
    
    //创建最上端滑动显示视图【带手势的图片视图，标题视图】
    _firstScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _firstScrollView.delegate=self;
    //设置分页效果
    _firstScrollView.pagingEnabled=YES;
    //设置在边缘是否反弹
    _firstScrollView.bounces=NO;
    _firstScrollView.showsHorizontalScrollIndicator=NO;
    _firstScrollView.showsVerticalScrollIndicator=NO;
    _firstScrollView.contentSize=CGSizeMake(kScreenWidth*5, 200);
   
    
    for(NSInteger i=0;i<_picArrays.count;i++)
    {
        //图片视图
        NSString *imgName = [_picArrays[i] Cover];
        NSString *text = [_picArrays[i] Title];
        NSString *name = [_picArrays[i] UserName];
        WXImageView *imageView=[[WXImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, 200)
                                                       WithIndex:i
                                                   WithLabelText:text
                                                    WithUserText:name];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgName]];
        
        __block HomeViewController *this = self;
        
        imageView.tapBlock = ^{
            
            pic_listModel *model = _picArrays[i];
            DetailCookViewController *detailCookVC = [[DetailCookViewController alloc]init];
            detailCookVC.cookTitile = model.Title;
            detailCookVC.rid = model.Rid;
            detailCookVC.hidesBottomBarWhenPushed = YES;
            [this.navigationController pushViewController:detailCookVC animated:YES];

        };

       
        [_firstScrollView addSubview:imageView];
    }
    [_scrollView addSubview:_firstScrollView];
    
    //----------创建PageControl控件----------
    //创建定时器
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollViewChanged) userInfo:nil repeats:YES];
    
    _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenWidth-150, _firstScrollView.bottom-25, 200, 20)];
    _pageCtrl.numberOfPages = 5;
    _pageCtrl.userInteractionEnabled=NO;
    _pageCtrl.currentPage = 0;
    [_scrollView addSubview:_pageCtrl];

}

#pragma mark -初始化按钮视图
- (void)initButtons
{

    CGFloat width3 = (kScreenWidth - 3*5 - 4*80)/2;
    NSArray *titles = @[@"精选集",@"营养餐桌",@"我的收藏",@"签到"];
    NSArray *images = @[@"menu_ico_collect",
                        @"menu_ico_recipe",
                        @"menu_ico_love",
                        @"menu_ico_sign"];
    for (NSInteger i = 0; i<4; i++)
    {
        ButtonView *buttonView = [[ButtonView alloc]initWithFrame:CGRectMake(i*(80+5)+width3, _firstScrollView.bottom+5, 80 , 82 )
                                                    WithBgImgName:@"bg_zoarium_body.png"
                                                WithButtonImgName:images[i]
                                                        WithTitle:titles[i]];
        buttonView.backgroundColor = [UIColor clearColor];
        __block HomeViewController *this = self;
        buttonView.buttonBlock =  ^{
            [self imageButton:i withController:this];
        };

        
        [_headView addSubview:buttonView];
    }
    for (NSInteger i = 0; i < _tapListArray.count /4; i ++)
    {
        for (NSInteger j = 0 ; j < 4; j++)
        {
            Tag_listModel *model = _tapListArray[i * 4 + j];
            
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(35 + 80 * j, 300 + 50 * i, 65, 30)];
            //根据Model的ID 来设置Tag值
            NSInteger tempTag = i * 4 + j;
            button.tag = tempTag + 300;
            [button setBackgroundImage:[UIImage imageNamed:@"bg_tag.png"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            [button setTitle:model.Name forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [_headView addSubview:button];
        }
    }
    
    
    
}


#pragma mark --ButtonAction
- (void)imageButton:(NSInteger )i withController:(HomeViewController *)this
{
    BOOL isLogin = [self userIsLogin];
    switch (i)
    {
        case 0:
        {
          //精选集
           UserGroupListViewController *omnVC = [[UserGroupListViewController alloc]init];
            omnVC.hidesBottomBarWhenPushed = YES;
          [this.navigationController pushViewController:omnVC animated:YES];
        }
            break;
        case 1:
        {
            //营养餐桌
            GoodListViewController *nutritionVC = [[GoodListViewController alloc]init];
            nutritionVC.hidesBottomBarWhenPushed = YES;
            [this.navigationController pushViewController:nutritionVC animated:YES];
            
        }
            break;
        case 2:
        {
            //我的收藏
            if (isLogin)
            {
                FavoriteViewController *myFavoriteVC = [[FavoriteViewController alloc]init];
                myFavoriteVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:myFavoriteVC animated:YES];
            }
            else
            {
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                loginVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:loginVC animated:YES];
            }
        }
            break;
        case 3:
        {
            //签到
            if (isLogin)
            {
                [self showHUD:@"签到成功"];
                [self performSelector:@selector(hiddenHUD) withObject:nil afterDelay:1];
            }else
            {
                //如果没有登录，则跳到登录界面
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                loginVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:loginVC animated:YES];
            }

        }
            break;
            
        default:
            break;
    }
    

}
- (void)buttonAction:(UIButton *)button
{
    NSInteger tempTag = button.tag - 300;
    TagListViewController *detailMVC = [[TagListViewController alloc]init];
    detailMVC.hidesBottomBarWhenPushed = YES;
    Tag_listModel *model = _tapListArray[tempTag];
    detailMVC.tagId = model.TagId;
    detailMVC.labelTitle = model.Name;
    [self.navigationController pushViewController:detailMVC animated:YES];
}

#pragma mark - 数据处理
- (void)loadData
{
    [self showHUD:@"正在加载"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"1382446160" forKey:@"sessionid"];
    [params setObject:@"Suggest.recipeV3" forKey:@"method"];
    [DataService requestAFWithUrl:@"" params:params reqestHeader:nil httpMethod:@"GET" finishDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        //处理数据
         [self loadNetData:result];
        //取消加载提示
         [self hiddenHUD];
        //初始化视图
        [self initViews];
    } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)loadNetData:(id)result
{
    
    NSDictionary *subResult = result[@"result"];
    //轮播图 数据
    NSArray *recipeArr = subResult[@"recipe_list"];
    for (NSDictionary *dic in recipeArr)
    {
        pic_listModel *model = [[pic_listModel alloc]initWithContentsOfDic:dic];
        [_picArrays addObject:model];
    }
    
    //tag_list 按钮数据
    NSArray *tapListArr = [subResult objectForKey:@"tag_list"];
    for (NSDictionary *dic in tapListArr)
    {
        Tag_listModel *model = [[Tag_listModel alloc]initWithContentsOfDic:dic];
        [_tapListArray addObject:model];
    }

    
    //collect_list --section1数据
    NSArray *collectistArr = [subResult objectForKey:@"collect_list"];
    for (NSDictionary *dic in collectistArr)
    {
        Select_listModel *model = [[Select_listModel alloc]initWithContentsOfDic:dic];
        [_selectArray addObject:model];

    }

    //wiki_list   ---section2 数据
    NSArray *wikiListArr = [subResult objectForKey:@"wiki_list"];
    for (NSDictionary *dic in wikiListArr)
    {
        KitchenModel *model = [[KitchenModel alloc]initWithContentsOfDic:dic];
        [_kitchenArray addObject:model];

    }

    [_homeTableView reloadData];
    
}

#pragma mark UIScrollViewDelegata
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    int index=targetContentOffset->x/kScreenWidth;
    _pageCtrl.currentPage=index;
}


- (void)scrollViewChanged
{
    float i=_pageCtrl.currentPage;
    if(i==4)
    {
        i=-1;
    }
    [_firstScrollView setContentOffset:CGPointMake((i+1)*kScreenWidth, 0) animated:YES];
    if(_pageCtrl.currentPage==4)
    {
        _pageCtrl.currentPage=0;
    }else{
        _pageCtrl.currentPage++;
    }
}

#pragma mark --homeTableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"homeCell";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeCell" owner:self options:nil]lastObject];
    }
    
    if (indexPath.section == 0 && _selectArray.count > 0)
    {
        cell.model_s = _selectArray[indexPath.row];
    }
    else if (indexPath.section == 1 && _kitchenArray.count > 0)
    {
        cell.model_k = _kitchenArray[indexPath.row];
    }
    else
    {
        NSLog(@"没有数据");
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 0, 40);
    button.tag = section;
    [button setTitle:@"点击查看更多" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"bg_zoarium_body"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:self
               action:@selector(buttonFooterAction:)
     forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return  @"精选集";
    }
    else
    {
        return  @"厨房宝典";
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
#pragma mark - 修改
        //精选集
        UserListViewController *selectListVC = [[UserListViewController alloc]init];
        selectListVC.hidesBottomBarWhenPushed = YES;
        Select_listModel *model = _selectArray[indexPath.row];
        selectListVC.cid = model.Cid;
        selectListVC.selectListTitle = model.Title;
        [self.navigationController pushViewController:selectListVC animated:YES];
    }
    else
    {
        BaseInfoViewController *baseWeb =[[BaseInfoViewController alloc]init];
        baseWeb.hidesBottomBarWhenPushed = YES;
        KitchenModel *model = _kitchenArray[indexPath.row];
        baseWeb.Celltitle = model.Title;
        baseWeb.cellUrl = model.Url;
        [self.navigationController pushViewController:baseWeb animated:YES];

    }
}
- (void)buttonFooterAction:(UIButton *)button
{
    if (button.tag == 0)
    {
        //精选集
        UserGroupListViewController *omnVC = [[UserGroupListViewController alloc]init];
        omnVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:omnVC animated:YES];
    }
    else
    {
        BaseListViewController *cookVC = [[BaseListViewController alloc]init];
        cookVC.hidesBottomBarWhenPushed = YES;
        cookVC.isCook = YES;
        [self.navigationController pushViewController:cookVC animated:YES];
    }
    
}
@end
