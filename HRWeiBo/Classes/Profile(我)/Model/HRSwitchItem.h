//
//  SwitchItem.h
//  网易彩票
//
//  Created by yangwei on 15/11/21.
//  Copyright © 2015年 yangwei. All rights reserved.
//

#import "HRSettingItem.h"
#import <UIKit/UIKit.h>

typedef void(^SwitchBlock)(UISwitch *);

@interface HRSwitchItem : HRSettingItem

//@property (nonatomic, assign) BOOL isON;

@property (nonatomic, copy) SwitchBlock switchBlock;



@end
