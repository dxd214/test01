//
//  ZooImageView.h
//  sinaWeiBo_ee_1004
//
//  Created by wxhl on 13-10-19.
//  Copyright (c) 2013年 刘依. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ZooImageView : UIImageView<NSURLConnectionDataDelegate>
{
    UIImageView *_fullImageView; //全屏图片
    UIScrollView *_coverView;
    MBProgressHUD *_progressView; //进度条
    UIButton *_saveButton; //保存按钮
    

    NSMutableData *_data;
    long long _fileSize;
    
    
}

@property(nonatomic,copy)NSString *urlString;



@end
