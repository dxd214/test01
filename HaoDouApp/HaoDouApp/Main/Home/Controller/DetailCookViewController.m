//
//  DetailCookBooksViewController.m
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-27.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//
/*
 1、保存浏览历史
 2、加载网络数据并解析
 3、重新整理网络数据
 4、显示视图
 5、
 */
#import "DetailCookViewController.h"
#import "Tag_listModel.h"
#import "StepsModel.h"
#import "StuffCookModel.h"
#import "CommentModel.h"
#import "ZooImageView.h"
#import "TagListViewController.h"
@interface DetailCookViewController ()

@end

@implementation DetailCookViewController
- (void)viewDidLoad {
    self.title = _cookTitile;
    [super viewDidLoad];
    
    //保存最近浏览
    [self saveHistory];
    [self loadData];
}
- (void)saveHistory
{
    self.nearLookDic = [[NSUserDefaults standardUserDefaults]objectForKey:KNearLookKey];
    NSMutableDictionary *sDic = [[NSMutableDictionary alloc]initWithDictionary:self.nearLookDic];
    
    [sDic setObject:_rid forKey:_cookTitile];
    
    [[NSUserDefaults standardUserDefaults]setObject:sDic forKey:KNearLookKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//加载网络数据
- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_rid forKey:@"rid"];
    [params setObject:@"Info.getInfoV3" forKey:@"method"];
    [params setObject:@"1382661984" forKey:@"sessionid"];
    [DataService requestAFWithUrl:@"" params:params reqestHeader:nil httpMethod:@"GET" finishDidBlock:^(AFHTTPRequestOperation *operation, id result) {
        [self loadNetData:result];
        //加载视图
        [self initViews];
    } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)loadNetData:(id)result
{
    NSDictionary *resultDic = result[@"result"];
    NSDictionary *infoDic = resultDic[@"info"];
    
    _model = [[DetailCookBookModel alloc]initWithContentsOfDic:infoDic];
    //整理数据
    
    //解析标签数据：
    NSArray *tagsSouce = infoDic[@"Tags"];
    NSMutableArray *tagModels = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in tagsSouce)
    {
        Tag_listModel *model = [[Tag_listModel alloc]initWithContentsOfDic:dic];
        [tagModels addObject:model];
    }
    
    //转换为2维数组
    _model.TagsArray = [self exchange2Data2:tagModels];
    
    
    
    //解析步骤数据
    NSMutableArray *stepModels = [[NSMutableArray alloc]init];
    NSArray *Steps = infoDic[@"Steps"];
    for (NSDictionary *dic in Steps)
    {
        StepsModel *model = [[StepsModel alloc]initWithContentsOfDic:dic];
        [stepModels addObject:model];
    }
    _model.StepsArray = stepModels;
    
    //解析材料数据
    NSMutableArray *stuffModels = [[NSMutableArray alloc]init];
    NSArray *stuffSouce = infoDic[@"Stuff"];
    for (NSDictionary *dic in stuffSouce)
    {
        StuffCookModel *model = [[StuffCookModel alloc]initWithContentsOfDic:dic];
        [stuffModels addObject:model];
        
    }
    _model.StuffArray = [self exchange2Data:stuffModels];
    
    //解析评论数据
    NSMutableArray *commentModels = [[NSMutableArray alloc]init];
    NSArray *commentSouce = [resultDic objectForKey:@"comment"];
    for (NSDictionary *dic in commentSouce)
    {
        CommentModel *model = [[CommentModel alloc]initWithContentsOfDic:dic];
        [commentModels addObject:model];
    }
    _model.commentArray = commentModels;
    
}

//转换为二维数组
- (NSArray *)exchange2Data:(NSArray *)souceArray
{
    NSMutableArray *array1D = [[NSMutableArray alloc]init];
    NSMutableArray *array2d = nil;
    for (NSInteger i = 0; i < souceArray.count; i++)
    {
        if (i % 2 == 0)
        {
            array2d = [[NSMutableArray alloc]init];
            [array1D addObject:array2d];
        }
        
        StuffCookModel *model = souceArray[i];
        [array2d addObject:model];
        
        
    }
    
    return array1D;
    
    
    
    
}

//转换为二维数组
- (NSArray *)exchange2Data2:(NSArray *)souceArray
{
    NSMutableArray *array1D = [[NSMutableArray alloc]init];
    NSMutableArray *array2d = nil;
    for (int i = 0; i < souceArray.count; i++)
    {
        if (i % 4 == 0)
        {
            array2d = [[NSMutableArray alloc]init];
            [array1D addObject:array2d];
        }
        
        Tag_listModel *model = souceArray[i];
        [array2d addObject:model];
        
    }
    return array1D;
}

- (void)initViews
{
    _scrollView.contentSize = CGSizeMake(kScreenWidth, 2000);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    //大图
    [_bigImage sd_setImageWithURL:[NSURL URLWithString:_model.Cover]];
    
    //评论
    NSString *commentCount = [NSString stringWithFormat:@"%@评论",_model.CommentCount];
    _commentLable.text = commentCount;
    
    //菜名
    _cookNameLable.text = _model.Title;
    //用户头像
    [_userImg sd_setImageWithURL:[NSURL URLWithString:_model.Avatar]];
    _userImg.layer.cornerRadius = 18;
    _userImg.layer.masksToBounds = YES;
    
    //用户名
    _userName.text = _model.UserName;
    
    //时间
    _cookTime.text = _model.ReviewTime;
    
    //简介
    _infolabel.text = _model.Intro;
    
    
    //二维数组
    /*鹅肉  600g    山药 300g
     油    适量     盐  适量
     */
    
    for (NSInteger i = 0; i < _model.StuffArray.count; i++)
    {
        NSArray *subArr = _model.StuffArray[i];
        for (NSInteger j = 0; j < subArr.count ; j++)
        {
            StuffCookModel *model = subArr[j];
            UIView *stuffView = [[UIView alloc]initWithFrame:CGRectMake(j * 140 + 20, i * 25 + 340, 140 , 20)];
            stuffView.backgroundColor = [UIColor clearColor];
            
            //材料
            UILabel *stuffName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
            stuffName.textAlignment = NSTextAlignmentLeft;
            stuffName.textColor = [UIColor grayColor];
            stuffName.font = [UIFont systemFontOfSize:14];
            stuffName.text = model.name;
            [stuffView addSubview:stuffName];
            
            //数量
            UILabel *countLable = [[UILabel alloc]initWithFrame:CGRectMake(stuffName.right, 0, 60, 20)];
            countLable.textAlignment = NSTextAlignmentCenter;
            countLable.textColor = [UIColor grayColor];
            countLable.font = [UIFont systemFontOfSize:14];
            countLable.text = model.weight;
            [stuffView addSubview:countLable];
            
            [_scrollView addSubview:stuffView];
            
        }
        
    }
    
    
    //制作时间
    _cookTimeView.frame = CGRectMake(10,340 + 27 * _model.StuffArray.count, 300, 30);
    _makeTime.text = _model.CookTime;
    
    //步骤
    UILabel *cookStep = [[UILabel alloc]initWithFrame:CGRectMake(10, _cookTimeView.bottom + 5, 100, 30)];
    cookStep.font = [UIFont systemFontOfSize:18];
    cookStep.text = @"步骤";
    [_scrollView addSubview:cookStep];
    
    
    for (NSInteger i = 0; i < _model.StepsArray.count; i++)
    {
        UIView *stepView = [[UIView alloc]initWithFrame:CGRectMake(10, cookStep.bottom + i * 90 + 10, kScreenWidth - 20, 90)];
        stepView.backgroundColor = [UIColor clearColor];
        
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        [button setBackgroundImage:[UIImage imageNamed:@"bg_step_number.png"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        
        NSString *stepIndex = [NSString stringWithFormat:@"%ld",i+1];
        [button setTitle:stepIndex forState:UIControlStateNormal];
        
        button.enabled = NO;
        [stepView addSubview:button];
        
        
        StepsModel *model = _model.StepsArray[i];
        ZooImageView *imge = [[ZooImageView alloc]initWithFrame:CGRectMake(button.right + 20, 0, 80, 70)];
        imge.urlString = model.StepPhoto;
        
        [imge sd_setImageWithURL:[NSURL URLWithString:model.StepPhoto]];
        [stepView addSubview:imge];
        
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(imge.right + 10, 0, 150, 70)];
        lable.numberOfLines = 0;
        lable.font = [UIFont systemFontOfSize:13];
        lable.textAlignment = NSTextAlignmentLeft;
        lable.text = model.Intro;
        [stepView addSubview:lable];
        
        [_scrollView addSubview:stepView];
        
    }
    
    
    
    
    UILabel *noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _cookTime.bottom + 120 * _model.StepsArray.count + 20, kScreenWidth - 20, 30)];
    noteLabel.font = [UIFont systemFontOfSize:18];
    noteLabel.text = @"小贴士";
    [_scrollView addSubview:noteLabel];
    
    UILabel *textTips =[[UILabel alloc]initWithFrame:CGRectMake(10, noteLabel.bottom , kScreenWidth - 20, 80)];
    
    textTips.font = [UIFont systemFontOfSize:12];
    textTips.numberOfLines = 0;
    textTips.text = _model.Tips;
    [textTips sizeToFit];
    [_scrollView addSubview:textTips];
    
    
    //评论
    UILabel *commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,textTips.bottom + 10, kScreenWidth - 20, 30)];
    commentLabel.font = [UIFont systemFontOfSize:18];
    commentLabel.text = @"评论";
    [_scrollView addSubview:commentLabel];
    
    
    
    
    NSInteger commentNumbers = 3;
    if ([_model.CommentCount integerValue] < 3)
    {
        commentNumbers = [_model.CommentCount intValue];
    }
    
    UIView *commentView = [[UIView alloc]initWithFrame:CGRectMake(10, commentLabel.bottom + 10, kScreenWidth - 20, commentNumbers * 60 + 50)];
    commentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [_scrollView addSubview:commentView];
    
    
    
    for (NSInteger i = 0; i < commentNumbers; i++)
    {
        UIView *subCommentView = [[UIView alloc]initWithFrame:CGRectMake(10, i * 60 + 10 , kScreenWidth - 40, 50)];
        subCommentView.backgroundColor = [UIColor clearColor];
        [commentView addSubview:subCommentView];
        
        CommentModel *model = [_model.commentArray objectAtIndex:i];
        
        //头像
        UIImageView *userImg = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 35, 35)];
        userImg.layer.cornerRadius = 17;
        userImg.layer.masksToBounds = YES;
        [userImg sd_setImageWithURL:[NSURL URLWithString:model.Avatar]];
        [subCommentView addSubview:userImg];
        
        
        //用户名
        UILabel *commentName = [[UILabel alloc]initWithFrame:CGRectMake(userImg.right + 5, 10, 100, 20)];
        commentName.font = [UIFont systemFontOfSize:13];
        commentName.backgroundColor = [UIColor clearColor];
        commentName.text = model.UserName;
        [commentName sizeToFit];
        [subCommentView addSubview:commentName];
        
        //内容
        NSString *commentText = [NSString stringWithFormat:@": %@",model.Content];
        UILabel *commentTextLable = [[UILabel alloc]initWithFrame:CGRectMake(commentName.right, 7, 120, 20)];
        commentTextLable.numberOfLines = 0;
        commentTextLable.backgroundColor = [UIColor clearColor];
        commentTextLable.font = [UIFont systemFontOfSize:13];
        commentTextLable.text = commentText;
        
        [subCommentView addSubview:commentTextLable];
        
        
        //时间
        UILabel *commentTimer = [[UILabel alloc]initWithFrame:CGRectMake(userImg.right + 5, commentName.bottom, 200, 20)];
        commentTimer.textColor = [UIColor lightGrayColor];
        commentTimer.backgroundColor = [UIColor clearColor];
        commentTimer.text = model.CreateTime;
        commentTimer.font = [UIFont systemFontOfSize:12];
        [subCommentView addSubview:commentTimer];
        
        
        
    }
    UIButton *commentButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 60 * commentNumbers, 200, 30)];
    commentButton.backgroundColor = [UIColor grayColor];
    [commentButton setTitle:@"点击查看全部评论" forState:UIControlStateNormal];
    
    commentButton.titleLabel.font = [UIFont systemFontOfSize:13];
    commentButton.titleLabel.textColor = [UIColor blackColor];
    [commentView addSubview:commentButton];
    
    
    
    //相关标签
    UILabel *tipsLable = [[UILabel alloc]initWithFrame:CGRectMake(10,commentView.bottom + 5, kScreenWidth - 20, 30)];
    tipsLable.font = [UIFont systemFontOfSize:18];
    tipsLable.text = @"相关标签";
    [_scrollView addSubview:tipsLable];
    
    for (NSInteger i = 0; i < _model.TagsArray.count; i++)
    {
        _cookArray = _model.TagsArray[i];
        
        for (NSInteger j = 0; j < _cookArray.count; j++)
        {
            Tag_listModel *model = _cookArray[j];
            
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(30 + 70 * j,tipsLable.bottom + i * 40,60, 30)];
            button.tag = 2014+j;
            [button addTarget:self action:@selector(tapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundImage:[UIImage imageNamed:@"bg_tag.png"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            [button setTitle:model.Name forState:UIControlStateNormal];
            [_scrollView addSubview:button];
        }
        
    }
    
    //成果照
    UILabel *resultLable = [[UILabel alloc]initWithFrame:CGRectMake(10,tipsLable.bottom + 5 + 40 *_model.TagsArray.count, kScreenWidth - 20, 30)];
    resultLable.font = [UIFont systemFontOfSize:18];
    resultLable.text = @"成果照";
    [_scrollView addSubview:resultLable];
    
    UIButton *resultPhoto = [[UIButton alloc]initWithFrame:CGRectMake(20, resultLable.bottom, 280, 40)];
    [resultPhoto setBackgroundColor:[UIColor colorWithRed:0.5 green:1 blue:0 alpha:1]];
    [resultPhoto setTitle:@"发布我的成果照" forState:UIControlStateNormal];
    [resultPhoto setTitle:@"发布我的成果照" forState:UIControlStateHighlighted];
    
    resultPhoto.titleLabel.font = [UIFont systemFontOfSize:13];
    resultPhoto.titleLabel.textColor = [UIColor blackColor];
    [_scrollView addSubview:resultPhoto];
    
    
    //有疑问，联系作者【后期添加】
    UILabel *messageLable = [[UILabel alloc]initWithFrame:CGRectMake(10, resultPhoto.bottom + 5, kScreenWidth -20, 30)];
    messageLable.textColor = [UIColor colorWithRed:0.5 green:1 blue:0 alpha:1];
    messageLable.text = @"有疑问？私信作者";
    [_scrollView addSubview:messageLable];
    
    _scrollView.contentSize = CGSizeMake(kScreenWidth, messageLable.bottom + 50);
}
- (void)tapButtonAction:(UIButton *)button
{
    NSInteger tempTag = button.tag - 2014;
    TagListViewController *detailMVC = [[TagListViewController alloc]init];
    Tag_listModel *model = _cookArray[tempTag];
    detailMVC.tagId = model.TagId;
    detailMVC.labelTitle = model.Name;
    [self.navigationController pushViewController:detailMVC animated:YES];
}
@end
