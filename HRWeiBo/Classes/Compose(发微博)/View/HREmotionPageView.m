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
#import "HREmotionPopView.h"
#import "HREmotionButton.h"

@interface HREmotionPageView()

#define HREmotionButtonDidSelectNotification @"HREmotionButtonDidSelectNotification"

@property (nonatomic, strong) HREmotionPopView *popView;

@end

@implementation HREmotionPageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        <#statements#>
    }
    return self;
}



- (HREmotionPopView *)popView {
    if (_popView == nil) {
        _popView = [HREmotionPopView popView];
    }
    return _popView;
}

- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    NSUInteger count = emotions.count;
    for (NSUInteger i = 0; i < count; i++) {
        HREmotion *emotion = (HREmotion *)emotions[i];
        HREmotionButton *btn = [[HREmotionButton alloc] init];
        btn.emotion = emotion;
        [btn addTarget:self action:@selector(emotionButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
//        btn.backgroundColor = HRRandomColor;
        [self addSubview:btn];
    }
}


- (void)emotionButtonDidClick:(HREmotionButton *)sender {
    [self.popView showFromButton:sender];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });

    NSDictionary *dict = @{HREmotionButtonDidSelectNotificationKey:sender.emotion};
    [[NSNotificationCenter defaultCenter] postNotificationName:HREmotionButtonDidSelectNotification object:nil userInfo:dict];

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
        HREmotionButton *btn = (HREmotionButton *)self.subviews[i];
        cols = i % HREmotionMaxCountCols;
        rows = i / HREmotionMaxCountCols;
        x = cols * btnW + HREmotionMargin;
        y = rows * btnH + HREmotionMargin;
        btn.frame = CGRectMake(x, y, w, h);
    }
}


@end
