//
//  HRComposeKeyboardToolBar.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/11.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRComposeKeyboardToolBar.h"

@implementation HRComposeKeyboardToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self addButtonWithImageName:@"compose_toolbar_picture" highlightedImageName:@"compose_toolbar_picture_highlighted" buttonType:HRComposeKeyboardToolBarPicture];
        [self addButtonWithImageName:@"compose_camerabutton_background" highlightedImageName:@"compose_camerabutton_background_highlighted" buttonType:HRComposeKeyboardToolBarCamera];
        [self addButtonWithImageName:@"compose_mentionbutton_background" highlightedImageName:@"compose_mentionbutton_background_highlighted" buttonType:HRComposeKeyboardToolBarMention];
        [self addButtonWithImageName:@"compose_trendbutton_background" highlightedImageName:@"compose_trendbutton_background_highlighted" buttonType:HRComposeKeyboardToolBarTrend];
        [self addButtonWithImageName:@"compose_keyboardbutton_background" highlightedImageName:@"compose_keyboardbutton_background_highlighted" buttonType:HRComposeKeyboardToolBarEmoticon];
    }
    return self;
}

- (void) addButtonWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName buttonType:(HRComposeKeyboardToolBarButtonType)buttonType{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    btn.tag = buttonType;
    [btn addTarget:self action:@selector(toolbarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
}

- (void)toolbarButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(composeKeyboardToolBar:didClickButton:)]) {
        [self.delegate composeKeyboardToolBar:self didClickButton:(HRComposeKeyboardToolBarButtonType)sender.tag];
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
        UIButton *btn = (UIButton *)self.subviews[i];
        x = i * perW;
        btn.frame = CGRectMake(x, y, w, h);
    }
}


@end
