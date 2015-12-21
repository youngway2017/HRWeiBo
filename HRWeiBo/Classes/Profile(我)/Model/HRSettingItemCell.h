//
//  SettingItemCell.h
//  网易彩票
//
//  Created by yangwei on 15/11/21.
//  Copyright © 2015年 yangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HRSettingItem;

@interface HRSettingItemCell : UITableViewCell

@property (nonatomic, strong) HRSettingItem *item;

@property (nonatomic, strong) UISwitch *switchBtn;

@property (nonatomic, strong) UILabel *label;



@end
