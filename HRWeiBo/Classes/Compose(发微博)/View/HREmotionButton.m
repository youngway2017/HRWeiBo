//
//  HREmotionButton.m
//  HRWeiBo
//
//  Created by yangwei on 15/12/13.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HREmotionButton.h"
#import "HREmotion.h"
#import "NSString+Emoji.h"

@implementation HREmotionButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:32];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
//        
    }
    return self;
}

- (void)setEmotion:(HREmotion *)emotion {
    _emotion = emotion;
    if (emotion.code) {
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
    } else {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }
}

@end
