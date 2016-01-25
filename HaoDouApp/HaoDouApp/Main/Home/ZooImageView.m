//
//  ZooImageView.m
//  sinaWeiBo_ee_1004
//
//  Created by wxhl on 13-10-19.
//  Copyright (c) 2013年 刘依. All rights reserved.
//

#import "ZooImageView.h"

@implementation ZooImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoominAction)];
        [self addGestureRecognizer:tapOne];

    }
    return self;
}
- (void)initViews
{
    if (!_coverView)
    {
        _coverView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _coverView.backgroundColor = [UIColor blackColor];
        [self.window addSubview:_coverView];
        
        UITapGestureRecognizer *smallImgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomOutAction)];
        [_coverView addGestureRecognizer:smallImgTap];

    }
    
    //全图显示
    if (!_fullImageView)
    {
        _fullImageView = [[UIImageView alloc]initWithImage:self.image];
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        _fullImageView.userInteractionEnabled = YES;
        [_coverView addSubview:_fullImageView];
        
    }
    
    //进度条
    if (!_progressView)
    {
        _progressView = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
        _progressView.labelText = @"加载中……";
        _progressView.progress = 0;
        
    }
    
    
    //保存按钮
    if (!_saveButton)
    {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
                
        [_saveButton setImage:[UIImage imageNamed:@"compose_savebutton_background.png"] forState:UIControlStateNormal];
        [_saveButton setImage:[UIImage imageNamed:@"compose_savebutton_background_highlighted.png"] forState:UIControlStateHighlighted];
        _saveButton.frame = CGRectMake(kScreenWidth-20-23, kScreenHeight-20-19, 23, 19);
        
        [_saveButton addTarget:self action:@selector(saveImg) forControlEvents:UIControlEventTouchUpInside];
        _saveButton.hidden = YES;
        [self.window addSubview:_saveButton];
        
        
    }
    
    
    //坐标转换，将当前视图的坐标转换成显示在window上的坐标
    CGRect frame = [self convertRect:self.bounds toView:self.window];
    
    _fullImageView.frame = frame;
    
    
    
}





//放大

- (void)zoominAction
{
    [self initViews];
    
    _coverView.backgroundColor = [UIColor clearColor];
    
    //实现放大
    [UIView animateWithDuration:0.3 animations:^{
        _fullImageView.frame = [UIScreen mainScreen].bounds;
        
    } completion:^(BOOL finished) {
        //隐藏电磁条
       [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        
        _coverView.backgroundColor = [UIColor blackColor];
        _saveButton.hidden = NO;
        
    }];
    
    _data = [[NSMutableData alloc]init];
    
    
    //请求大图
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url
                                                 cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    

}






//缩小
- (void)zoomOutAction
{
    _data = nil;
    _coverView.backgroundColor = [UIColor clearColor];
    _saveButton.hidden = YES;
    
    CGRect frame = [self convertRect:self.bounds toView:self.window];

    
    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    [UIView animateWithDuration:0.3 animations:^{
        _fullImageView.frame  = frame;
    } completion:^(BOOL finished) {
        [_coverView removeFromSuperview];
        
         _coverView = nil;
         _fullImageView = nil;
         _saveButton = nil;
        
    }];
    

}


//保存图片
- (void)saveImg
{
    UIImage *img = _fullImageView.image;
    
    if (img)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
        hud.labelText = @"正在保存";
        hud.dimBackground = YES;
        
        
        //将图片保存到相册
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)(hud));
       
    }
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    MBProgressHUD *hud = (__bridge MBProgressHUD *)(contextInfo);
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    //显示模式自定义
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"保存成功";
    
    
    //延迟一秒隐藏
    [hud hide:YES afterDelay:1];
    
    
}




#pragma mark--NSURLConnectionDataDelegate


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //图片总大小
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    _fileSize = httpResponse.expectedContentLength;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{

    [_data appendData:data];
    
    //进度条
    float progress = _data.length /(float)_fileSize;
    _progressView.progress = progress;
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    UIImage *imge = [UIImage imageWithData:_data];
    _fullImageView.image = imge;
    
    //隐藏进度条
    [_progressView hide:YES];
    [_progressView removeFromSuperview];
    _progressView = nil;
    
    
    
    //大图等比拉伸
    float height = imge.size.height / imge.size.width * kScreenWidth;
    if (height < kScreenHeight)
    {
        _fullImageView.top = (kScreenHeight - height)/2;
        
    }
    
    _fullImageView.size = CGSizeMake(kScreenWidth, height);
    _coverView.contentSize = CGSizeMake(kScreenWidth, height);
    
    
}

@end
