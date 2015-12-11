//
//  HREmotionKeyBoard.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/11.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HREmotionKeyboard.h"
#import "HREmotionKeyboardTabBar.h"
#import "HREmotionKeyboardListView.h"


@interface HREmotionKeyboard()

@property (nonatomic, strong) HREmotionKeyboardListView *keyboardLisview;

@property (nonatomic, strong) HREmotionKeyboardTabBar *keyboardTabBar;

@end

@implementation HREmotionKeyboard

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        self.keyboardLisview = [[HREmotionKeyboardListView alloc] init];
        [self addSubview:self.keyboardLisview];
        self.keyboardLisview.backgroundColor = [UIColor redColor];
        
        self.keyboardTabBar = [[HREmotionKeyboardTabBar alloc] init];
        [self addSubview:self.keyboardTabBar];
        self.keyboardTabBar.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)layoutSubviews {
    self.keyboardTabBar.width = self.width;
    self.keyboardTabBar.height = 44;
    self.keyboardTabBar.x = 0;
    self.keyboardTabBar.y = self.height - self.keyboardTabBar.height;
    
    self.keyboardLisview.width = self.width;
    self.keyboardLisview.height = self.height - self.keyboardTabBar.height;
    self.keyboardLisview.x = 0;
    self.keyboardLisview.y = 0;
    
    
}


@end
