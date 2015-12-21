//
//  ArrowItem.h
//  网易彩票
//
//  Created by yangwei on 15/11/21.
//  Copyright © 2015年 yangwei. All rights reserved.
//

#import "HRSettingItem.h"

@interface HRArrowItem : HRSettingItem

@property (nonatomic, strong) Class descVC;

+ (instancetype)arrowItemWithIcon:(NSString *)icon title:(NSString *)title descVC:(Class)descVC;

@end
