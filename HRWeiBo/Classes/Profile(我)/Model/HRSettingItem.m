//
//  SettingItem.m
//  网易彩票
//
//  Created by yangwei on 15/11/20.
//  Copyright © 2015年 yangwei. All rights reserved.
//

#import "HRSettingItem.h"

@implementation HRSettingItem

+ (instancetype)settingItemWithIcon:(NSString *)icon title:(NSString *)title {
    HRSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    return item;
}


@end
