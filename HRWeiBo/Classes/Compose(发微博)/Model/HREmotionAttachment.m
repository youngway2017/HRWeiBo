//
//  HREmotionAttachment.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/14.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HREmotionAttachment.h"
#import "HREmotion.h"

@implementation HREmotionAttachment



- (void)setEmotion:(HREmotion *)emotion {
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];
}


@end
