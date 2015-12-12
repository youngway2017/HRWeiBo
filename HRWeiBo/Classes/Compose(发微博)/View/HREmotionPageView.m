//
//  HREmotionPageView.m
//  HRWeiBo
//
//  Created by yangwei on 15/12/12.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HREmotionPageView.h"
#import "HREmotion.h"
#import "NSString+Emoji.h"

@implementation HREmotionPageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        <#statements#>
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    NSUInteger count = emotions.count;
    for (NSUInteger i = 0; i < count; i++) {
        HREmotion *emotion = (HREmotion *)emotions[i];
        UIButton *btn = [[UIButton alloc] init];
        if (emotion.code) {
            [btn setTitle:emotion.code.emoji forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:32];
        } else {
            [btn setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        }
//        btn.backgroundColor = HRRandomColor;
        [self addSubview:btn];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnW = (self.width - 2*HREmotionMargin)/HREmotionMaxCountCols;
    CGFloat btnH = (self.height - HREmotionMargin)/HREmotionMaxCountRows;
    
    int cols = 0;
    int rows = 0;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = btnW;
    CGFloat h = btnH;
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn = (UIButton *)self.subviews[i];
        cols = i % HREmotionMaxCountCols;
        rows = i / HREmotionMaxCountCols;
        x = cols * btnW + HREmotionMargin;
        y = rows * btnH + HREmotionMargin;
        btn.frame = CGRectMake(x, y, w, h);
    }
}

@end
