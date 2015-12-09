//
//  NSDate+Extension.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/9.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)


- (BOOL)isThisYear {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *currentComp = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    
    NSDateComponents *dateComp = [calendar components:NSCalendarUnitYear fromDate:self];
    
    return currentComp.year == dateComp.year;
}

- (BOOL)isToday {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *currentComp = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *dateComp = [calendar components:unitFlags fromDate:self];
    
    return currentComp.year == dateComp.year && currentComp.month == dateComp.month && currentComp.day == dateComp.day;
}

- (BOOL)isYesterday {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [format dateFromString:[self dateToStringYMD]];
    currentDate = [format dateFromString:[currentDate dateToStringYMD]];
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date toDate:currentDate options:NSCalendarWrapComponents];
    
    return comps.year == 0 && comps.month == 0 && comps.day == 1;
}

- (NSString *)dateToStringYMD {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    return [format stringFromDate:self];
}


@end
