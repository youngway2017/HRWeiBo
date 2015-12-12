//
//  HREmotionKeyboardTabBarButton.m
//  HRWeiBo
//
//  Created by yangwei on 15/12/12.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HREmotionKeyboardTabBarButton.h"

@implementation HREmotionKeyboardTabBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    
}

@end
