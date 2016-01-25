//
//  BaseWebViewController.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-26.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseInfoViewController : BaseViewController<UIWebViewDelegate>
{
    UIButton *_collectButton;
}
@property (retain, nonatomic) IBOutlet UIWebView *subWebView;
@property(nonatomic,assign)NSInteger fontSize;//字体大小
@property(nonatomic,copy)NSString *Celltitle;
@property(nonatomic,copy)NSString *cellUrl;





@end
