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

- (void)setSource:(NSString *)source {
//    <a href="http://app.weibo.com/t/feed/1tqBja" rel="nofollow">360安全浏览器</a>
    
    NSRange startRange = [source rangeOfString:@">"];
    NSRange endRange = [source rangeOfString:@"<" options:NSBackwardsSearch];
    NSRange range;
    range.location = startRange.location + 1;
    range.length = endRange.location - range.location;
    _source = [source substringWithRange:range];

}

- (NSString *)created_at {
//    Tue Dec 08 16:58:05 +0800 2015
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    formate.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //创建时间
    NSDate *createdDate = [formate dateFromString:_created_at];
    //当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:createdDate toDate:currentDate options:NSCalendarWrapComponents];

    if ([createdDate isThisYear]) {
        if ([createdDate isYesterday]) {
            formate.dateFormat = @"昨天 HH:mm";
            return [formate stringFromDate:createdDate];
        } else if([createdDate isToday]) {
            if (comps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",comps.hour];
            } else if(comps.minute > 1) {
                return [NSString stringWithFormat:@"%ld分钟前",comps.minute];
            } else {
                return @"刚刚";
            }
        } else {
            formate.dateFormat = @"MM-dd HH:mm";
            return [formate stringFromDate:createdDate];
        }
    } else {
        formate.dateFormat = @"yyyy-MM-dd HH:mm";
        return [formate stringFromDate:createdDate];
    }
    
}

@end
