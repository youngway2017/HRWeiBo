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
#import "HREmotionTool.h"
#import "HRConst.h"

@interface HREmotionPageView()

//#define HREmotionButtonDidSelectNotification @"HREmotionButtonDidSelectNotification"
//#define HREmotionButtonDidDeleteNotification @"HREmotionButtonDidDeleteNotification"

@property (nonatomic, strong) HREmotionPopView *popView;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UILongPressGestureRecognizer *longGesture;
@end

@implementation HREmotionPageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.deleteButton = [[UIButton alloc] init];
        [self.deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [self.deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        
        self.longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)];
        [self addGestureRecognizer:self.longGesture];
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
    //加入最后一个删除按钮
    [self.deleteButton addTarget:self action:@selector(deleteButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteButton];
    
}

- (void)deleteButtonDidClick:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:HREmotionButtonDidDeleteNotification object:nil userInfo:nil];
    
}

- (void)emotionButtonDidClick:(HREmotionButton *)sender {
    if(sender) {
        [HREmotionTool saveEmotion:sender.emotion];
        [self.popView showFromButton:sender];
        NSDictionary *dict = @{HREmotionButtonDidSelectNotificationKey:sender.emotion};
        [[NSNotificationCenter defaultCenter] postNotificationName:HREmotionButtonDidSelectNotification object:nil userInfo:dict];
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });

}

- (void)longPressClick:(UILongPressGestureRecognizer *)longGesture {
    switch (longGesture.state) {
        
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged: {
            HREmotionButton *btn = [self emotionButtonContainsPoint];
            if(btn) {
                [self.popView showFromButton:btn];
            }
            break;
        }
        
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            [self emotionButtonDidClick:[self emotionButtonContainsPoint]];

            break;
        }
    }

}

- (HREmotionButton *) emotionButtonContainsPoint {
    CGPoint point = [self.longGesture locationInView:self];
    for (int i = 0; i < self.subviews.count - 1; i++) {
        HREmotionButton *btn = (HREmotionButton *)self.subviews[i];
        if(CGRectContainsPoint(btn.frame, point)) {
            HRLog(@"%@",btn.emotion.chs);
            return btn;
        }
    }
    return nil;
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
    self.deleteButton.frame = CGRectMake(self.width - (btnW + HREmotionMargin), self.height - btnH, w, h);
}


@end
