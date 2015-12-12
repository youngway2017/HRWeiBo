//
//  HREmotionKeyBoardTabBar.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/11.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HREmotionKeyboardTabBar.h"
#import "HREmotionKeyboardTabBarButton.h"

@interface HREmotionKeyboardTabBar()

@property (nonatomic, strong) HREmotionKeyboardTabBarButton *selectedButton;

@end

@implementation HREmotionKeyboardTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self addButtonWithTitle:@"最近" buttonType:HREmotionKeyboardTabBarRecent];
        [self addButtonWithTitle:@"默认" buttonType:HREmotionKeyboardTabBarDefault];
        [self addButtonWithTitle:@"Emojo" buttonType:HREmotionKeyboardTabBarEmojo];
        [self addButtonWithTitle:@"浪小花" buttonType:HREmotionKeyboardTabBarLxh];
        
    }
    return self;
}

- (void) addButtonWithTitle:(NSString *)title buttonType:(HREmotionKeyboardTabBarButtonType)buttonType{
    
    HREmotionKeyboardTabBarButton *btn = [[HREmotionKeyboardTabBarButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];

    NSString *normalImageName = @"compose_emotion_table_mid_normal";
    NSString *disableImageName = @"compose_emotion_table_mid_selected";
    if (buttonType == HREmotionKeyboardTabBarRecent) {
        normalImageName = @"compose_emotion_table_left_normal";
        disableImageName = @"compose_emotion_table_left_selected";
    } else if (buttonType == HREmotionKeyboardTabBarLxh) {
        normalImageName = @"compose_emotion_table_right_normal";
        disableImageName = @"compose_emotion_table_right_selected";
    }
    [btn setBackgroundImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:disableImageName] forState:UIControlStateDisabled];
    
    btn.tag = buttonType;
    [btn addTarget:self action:@selector(toolbarButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    
}

- (void)toolbarButtonClicked:(HREmotionKeyboardTabBarButton *)sender {
    self.selectedButton.enabled = YES;
    self.selectedButton = sender;
    self.selectedButton.enabled = NO;
    
    if ([self.delegate respondsToSelector:@selector(emotionKeyboardTabBar:didClickButton:)]) {
        [self.delegate emotionKeyboardTabBar:self didClickButton:(HREmotionKeyboardTabBarButtonType)sender.tag];
    }
}

- (void)layoutSubviews {
    NSUInteger count = self.subviews.count;
    CGFloat perW = self.width / count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = perW;
    CGFloat h = self.height;
    for (NSUInteger i = 0; i < self.subviews.count; i++) {
        HREmotionKeyboardTabBarButton *btn = (HREmotionKeyboardTabBarButton *)self.subviews[i];
        x = i * perW;
        btn.frame = CGRectMake(x, y, w, h);
        if (i == 1) {
            [self toolbarButtonClicked:btn];
        }
    }
}


@end
