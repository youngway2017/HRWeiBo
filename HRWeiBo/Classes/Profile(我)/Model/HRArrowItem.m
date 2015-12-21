//
//  ArrowItem.m
//  网易彩票
//
//  Created by yangwei on 15/11/21.
//  Copyright © 2015年 yangwei. All rights reserved.
//

#import "HRArrowItem.h"

@implementation HRArrowItem

+ (instancetype)arrowItemWithIcon:(NSString *)icon title:(NSString *)title descVC:(Class)descVC{
    HRArrowItem *item = [super settingItemWithIcon:icon title:title];
    item.descVC = descVC;
    return item;
}

- (void)setDescVC:(Class)descVC {
    _descVC = descVC;
}

@end
