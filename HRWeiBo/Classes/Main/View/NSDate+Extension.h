//
//  NSDate+Extension.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/9.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYesterday;
- (NSString *)dateToStringYMD;
@end
