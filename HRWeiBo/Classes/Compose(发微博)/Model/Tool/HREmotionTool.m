//
//  HREmotionTool.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/14.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HREmotionTool.h"
#import "HREmotion.h"
#import "MJExtension.h"

#define emotionFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.data"]

@interface HREmotionTool();

@end

@implementation HREmotionTool


static NSMutableArray *_recentEmotions;
NSArray *_defaultEmotions;
NSArray *_emojiEmotions;
NSArray *_lxhEmotions;

+ (void)initialize {
//    _emotions = (NSMutableArray *)[NSArray arrayWithContentsOfFile:emotionFile];
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:emotionFile];
    if(_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}

+ (void)saveEmotion:(HREmotion *)emotion {
    [_recentEmotions removeObject:emotion];
    [_recentEmotions insertObject:emotion atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:emotionFile];
   
}

+ (NSArray *)recentEmotions {
    return _recentEmotions;
}

+ (NSArray *)defaultEmotions {
    if (_defaultEmotions == nil) {
        _defaultEmotions = [[NSArray alloc] init];
        _defaultEmotions = [self emotionsArrayWithPath:@"EmotionIcons/default/info.plist"];
    }
    return _defaultEmotions;
}

+ (NSArray *)emojiEmotions {
    if (_emojiEmotions == nil) {
        _emojiEmotions = [[NSArray alloc] init];
        _emojiEmotions = [self emotionsArrayWithPath:@"EmotionIcons/emoji/info.plist"];
    }
    return _emojiEmotions;
}

+ (NSArray *)lxhEmotions {
    if (_lxhEmotions == nil) {
        _lxhEmotions = [[NSArray alloc] init];
        _lxhEmotions = [self emotionsArrayWithPath:@"EmotionIcons/lxh/info.plist"];
    }
    return _lxhEmotions;
}

+ (NSArray *)emotionsArrayWithPath:(NSString *)pathStr {
    NSString *path = [[NSBundle mainBundle] pathForResource:pathStr ofType:nil];
    return [HREmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
}

+ (HREmotion *)emotionWithText:(NSString *)text {
    for (HREmotion *emotion in [self defaultEmotions]) {
        if ([text isEqualToString:emotion.chs]) {
            return emotion;
        }
    }
    
    for (HREmotion *emotion in [self lxhEmotions]) {
        if ([text isEqualToString:emotion.chs]) {
            return emotion;
        }
    }
    
    return nil;
}


@end
