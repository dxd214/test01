//
//  BaseMenuView.m
//  DouGouFoodApp
//
//  Created by wxhl on 13-10-25.
//  Copyright (c) 2013年 wxhl. All rights reserved.
//

#import "MenuTableView.h"
#import "DetailMenuModel.h"
#import "MenuCell.h"
@implementation MenuTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        
        
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _menuData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MenuCell";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MenuCell" owner:self options:nil]lastObject];
        
    }
    
    NSArray *array = self.menuData[indexPath.row];
   cell.menuData = array;
    
       
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}


@end
