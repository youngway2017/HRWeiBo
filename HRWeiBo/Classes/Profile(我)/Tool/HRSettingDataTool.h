//
//  DataTool.h
//  网易彩票
//
//  Created by Yangwei on 15/11/24.
//  Copyright © 2015年 yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRSettingDataTool : NSObject

+ (id)objectForKey:(NSString *)defaultName;
+ (void)setObject:(id)value forKey:(NSString *)defaultName;

+ (BOOL)boolForKey:(NSString *)defaultName;
+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName;
@end
