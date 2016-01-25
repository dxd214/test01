//
//  common.h
//  foundation
//
//  Created by ios on 15-1-5.
//  Copyright (c) 2015年 716team. All rights reserved.
//

#ifndef HaoDouApp_common_h
#define HaoDouApp_common_h

//获取物理屏幕的尺寸
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

// 当前SDK版本
#define kVersion [[UIDevice currentDevice].systemVersion floatValue]

/*_________________json数据文件_________________________*/
#define home_list      @"index.php?"    //主页


/*_________________请求数据url_________________________*/
//#define schedule_url    @"/m/cinema/schedule.html"
#define imgUrl @"http://jbcdn2.b0.upaiyun.com/2014/01/a233d0ea49dc2992c64ffa3ffdfb4246.jpg"
#define URLmystring  @"http://m.sc.cc/index.php/hd/index/id/3294.html"
//显示欢迎页面
#define KShowGuide  @"showGuide"
//隐藏活动页面
#define KhiddenHuoDong  @"hiddenHuoDong"
//保存最近浏览
#define KNearSearchKey @"KNearSearchKey"
#define KNearLookKey @"KNearLookKey"
#define KPassWord @"KPassWord"
#define KUserMessage @"KUserMessage"


#endif
