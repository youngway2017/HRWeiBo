//
//  SettingItem.h
//  网易彩票
//
//  Created by yangwei on 15/11/20.
//  Copyright © 2015年 yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HRSettingItem;
typedef void(^OptionBlock)(HRSettingItem *);


@interface HRSettingItem : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) OptionBlock option;

+ (instancetype)settingItemWithIcon:(NSString *)icon title:(NSString *)title;

@end
