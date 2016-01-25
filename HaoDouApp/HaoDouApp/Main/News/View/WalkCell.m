//
//  WalkCell.m
//  HaoDouApp
//
//  Created by 董晓东 on 15/4/16.
//  Copyright (c) 2015年 716. All rights reserved.
//

#import "WalkCell.h"

@implementation WalkCell

- (void)setModel:(ShopModel *)model
{
    if (_model != model)
    {
        _model = model;
        NSMutableArray *dataArray = [NSMutableArray array];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        _titleLabel.text = model.Title;
        _nameLabel.text = model.UserName;
        _descLabel.text = model.PreviewContent;
        [dataArray addObject:model.Title];
        [dataArray addObject:model.UserName];
        [dataArray addObject:model.PreviewContent];
        
        // 序列化
        // 生成归档文件
        NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"test.archive"];
        // 创建 NSMutableData 对象
        NSMutableData *data = [NSMutableData data];
        // 创建归档对象
        NSKeyedArchiver *archive = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        // 归档数据
        [archive encodeObject:dataArray forKey:@"array"];
        [archive finishEncoding];
        // 生成文件
        [data writeToFile:filePath atomically:YES];
    }
    
}

@end
