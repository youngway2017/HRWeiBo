//
//  Status.m
//  HRWeiBo
//
//  Created by yangwei on 15/12/5.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRStatus.h"
#import "HRPhoto.h"
#import "MJExtension.h"

@implementation HRStatus

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"pic_urls" : [HRPhoto class]};
}

- (NSString *)created_at {
    HRLog(@"%@",_created_at);
//    Tue Dec 08 16:58:05 +0800 2015
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    formate.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    NSDate *date = [formate dateFromString:_created_at];
    HRLog(@"======%@",date);
    //当前时间
    NSCalendar *nowCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *nowComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    nowComps = [nowCalendar components:unitFlags fromDate:[NSDate date]];
    
    
    
    HRLog(@"%ld",[nowComps year]);
    
//    NSCalendar *nowCalendar = [NSCalendar currentCalendar];
//    //  通过已定义的日历对象，获取某个时间点的NSDateComponents表示，并设置需要表示哪些信息（NSYearCalendarUnit, NSMonthCalendarUnit, NSDayCalendarUnit等）
//    NSDateComponents *nowComponents = [nowCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekOfMonthCalendarUnit | NSWeekOfYearCalendarUnit fromDate:[NSDate date]];
    
    
    
    return _created_at;
}

@end
