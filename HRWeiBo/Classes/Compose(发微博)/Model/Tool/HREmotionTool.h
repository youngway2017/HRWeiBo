//
//  HREmotionTool.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/14.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HREmotion;
@interface HREmotionTool : NSObject

+ (void)saveEmotion:(HREmotion *)emotion;

+ (NSArray *)recentEmotions;
+ (NSArray *)defaultEmotions;
+ (NSArray *)emojiEmotions;
+ (NSArray *)lxhEmotions;
+ (HREmotion *)emotionWithText:(NSString *)text;


@end
