//
//  SettingGroup.h
//  网易彩票
//
//  Created by yangwei on 15/11/20.
//  Copyright © 2015年 yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRSettingGroup : NSObject

@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *footer;
@property (nonatomic, strong) NSMutableArray *items;

@end
