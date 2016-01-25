//
//  GuideViewController.h
//  01 WXMovie
//
//  Created by lyb on 14-8-25.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "PushAnimation.h"
@interface GuideViewController : BaseViewController<UIScrollViewDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) PushAnimation *animation;
@end
