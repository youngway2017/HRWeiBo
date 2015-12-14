//
//  HREmotionTool.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/14.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HREmotionTool.h"
#define emotionFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.data"]

@implementation HREmotionTool


static NSMutableArray *_emotions;

+ (void)initialize {
//    _emotions = (NSMutableArray *)[NSArray arrayWithContentsOfFile:emotionFile];
    _emotions = [NSKeyedUnarchiver unarchiveObjectWithFile:emotionFile];
    if(_emotions == nil) {
        _emotions = [NSMutableArray array];
    }
}

+ (void)saveEmotion:(HREmotion *)emotion {
    [_emotions removeObject:emotion];
    [_emotions insertObject:emotion atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_emotions toFile:emotionFile];
//    [_emotions writeToFile:emotionFile atomically:YES];
    
}

+ (NSArray *)emotions {
    return _emotions;
}

@end
