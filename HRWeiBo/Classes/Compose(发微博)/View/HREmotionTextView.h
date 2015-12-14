//
//  HREmotionTextView.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/14.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRPlaceholderTextView.h"

@class HREmotion;
@interface HREmotionTextView : HRPlaceholderTextView


- (void)insertEmotion:(HREmotion *)emotion settingBlock:(void (^) (NSMutableAttributedString *content))settingBlock;

- (NSString *)getFullText;

@end
