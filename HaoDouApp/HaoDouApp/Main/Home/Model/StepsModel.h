//
//  StepsModel.h
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-27.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//
/*
 "Steps": [
 {
 "StepPhoto": "http://recipe0.hoto.cn/pic/step/m/ea/58/1726698.jpg",
 "Intro": "原料图。"
 },
 */

#import "BaseModel.h"

@interface StepsModel : BaseModel

@property(nonatomic,copy)NSString *StepPhoto;
@property(nonatomic,copy)NSString *Intro;

@end
