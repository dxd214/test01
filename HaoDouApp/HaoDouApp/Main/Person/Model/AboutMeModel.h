//
//  AboutMeModel.h
//  MyDoctor
//
//  Created by wxhl_zy012 on 14-12-3.
//  Copyright (c) 2014年 www.716.com. All rights reserved.
//

#import "BaseModel.h"
/**
 普通用法
 可点击的用法：`AboutMeModel` 是 `BaseModel` 的子类，表示关于我的属性
 ## 测试黑色字体
 */
@interface AboutMeModel : BaseModel
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *detail;

@end
