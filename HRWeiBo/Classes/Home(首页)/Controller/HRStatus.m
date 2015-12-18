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
#import "RegexKitLite.h"
#import "HRPartStatus.h"
#import "HREmotion.h"
#import "HREmotionTool.h"

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
    if (range.location > source.length || range.length > source.length) {
        return;
    }
    HRLog(@"length=%ld",source.length);
    HRLog(@"source=%@",source);
    HRLog(@"range=%@",NSStringFromRange(range));
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

- (void)setText:(NSString *)text {
    _text = text;

    UIFont *font = [UIFont systemFontOfSize:18];
    NSMutableAttributedString *mutableAttributedStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableAttributedString *resultAttributedStr = [[NSMutableAttributedString alloc] initWithString:@""];
    [mutableAttributedStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, mutableAttributedStr.length)];
    NSMutableArray *statusParts = [NSMutableArray array];
    
    statusParts = [self getStatusPartsArrayWithText:text];
   
    for (HRPartStatus *part in statusParts) {
        NSRange showRange;
        showRange.location = resultAttributedStr.length;
        switch (part.partStatusType) {
            case HRPartStatusTypeNormal: {
                [resultAttributedStr appendAttributedString:[mutableAttributedStr attributedSubstringFromRange:part.range]];
                break;
            }
            case HRPartStatusTypeAt: {
                [mutableAttributedStr addAttribute:NSForegroundColorAttributeName value:HRRgba(235, 123, 96, 1) range:part.range];
                [resultAttributedStr appendAttributedString:[mutableAttributedStr attributedSubstringFromRange:part.range]];
                break;
            }
            case HRPartStatusTypeTopic: {
                [mutableAttributedStr addAttribute:NSForegroundColorAttributeName value:HRRgba(235, 123, 96, 1) range:part.range];
                [resultAttributedStr appendAttributedString:[mutableAttributedStr attributedSubstringFromRange:part.range]];
                break;
            }
            case HRPartStatusTypeEmotion: {
                HREmotion *emotion = [HREmotionTool emotionWithText:part.text];
                if (emotion) {
                    NSTextAttachment *atta = [[NSTextAttachment alloc] init];
                    atta.bounds = CGRectMake(0, -4,font.lineHeight, font.lineHeight);
                    atta.image = [UIImage imageNamed:emotion.png];
                    NSAttributedString *emotion = [NSAttributedString attributedStringWithAttachment:atta];
                    [resultAttributedStr appendAttributedString:emotion];
                } else {
                    [resultAttributedStr appendAttributedString:[mutableAttributedStr attributedSubstringFromRange:part.range]];
                }
                break;
            }
            case HRPartStatusTypeURL: {
                [mutableAttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:part.range];
                [resultAttributedStr appendAttributedString:[mutableAttributedStr attributedSubstringFromRange:part.range]];
                break;
            }
            default:
                break;
        }
        showRange.length = resultAttributedStr.length - showRange.location;
        part.showRange = showRange;
    }
    [resultAttributedStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, resultAttributedStr.length)];
    [resultAttributedStr addAttribute:@"StatusParts" value:statusParts range:NSMakeRange(0, 1)];
    self.AttributedText = resultAttributedStr;
    HRLog(@"++%@",self.AttributedText);
}

- (NSMutableArray *)getStatusPartsArrayWithText:(NSString *)text {
    NSString *atString = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    NSString *topicString = @"\\#[^\\s].*?\\#";
    NSString *emotionString = @"\\[[^\\s].*?\\]";
    NSString *urlString = @"(http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?";
    
    NSString *normalStr = [NSString stringWithFormat:@"%@|%@|%@|%@",atString,topicString,emotionString,urlString];
    
    NSMutableArray *statusParts = [NSMutableArray array];
    
    [statusParts addObjectsFromArray:[self text:text regexStr:atString partStatusType:HRPartStatusTypeAt]];
    [statusParts addObjectsFromArray:[self text:text regexStr:topicString partStatusType:HRPartStatusTypeTopic]];
    [statusParts addObjectsFromArray:[self text:text regexStr:emotionString partStatusType:HRPartStatusTypeEmotion]];
    [statusParts addObjectsFromArray:[self text:text regexStr:urlString partStatusType:HRPartStatusTypeURL]];
    
    [text enumerateStringsSeparatedByRegex:normalStr usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        NSRange range = *capturedRanges;
        if (!range.length) {
            return;
        }
        HRPartStatus *part = [[HRPartStatus alloc] init];
        part.partStatusType = HRPartStatusTypeNormal;
        part.text = *capturedStrings;
        part.range = range;
        [statusParts addObject:part];
    }];
    
    [statusParts sortUsingComparator:^NSComparisonResult(HRPartStatus *part1, HRPartStatus *part2) {
        if (part1.range.location < part2.range.location) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    
    return statusParts;
}

- (NSMutableArray *)text:(NSString *)text regexStr:(NSString *)regexStr partStatusType:(HRPartStatusType)type {
    NSMutableArray *parts = [NSMutableArray array];
    [text enumerateStringsMatchedByRegex:regexStr usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        NSRange range = *capturedRanges;
        if (!range.length) {
            return;
        }
        HRPartStatus *partStatus = [[HRPartStatus alloc] init];
        partStatus.partStatusType = type;
        partStatus.text = *capturedStrings;
        partStatus.range = range;
        [parts addObject:partStatus];
        
    }];
    return parts;
}

@end
