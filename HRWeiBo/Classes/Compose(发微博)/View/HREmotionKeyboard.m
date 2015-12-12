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


@interface HREmotionKeyboard()<HREmotionKeyboardTabBarDelegate>

@property (nonatomic, strong) HREmotionKeyboardListView *emotionListViewRecent;
@property (nonatomic, strong) HREmotionKeyboardListView *emotionListViewDefault;
@property (nonatomic, strong) HREmotionKeyboardListView *emotionListViewEmojo;
@property (nonatomic, strong) HREmotionKeyboardListView *emotionListViewLxh;

@property (nonatomic, strong) UIView *showingView;

@property (nonatomic, strong) HREmotionKeyboardTabBar *keyboardTabBar;

@end

@implementation HREmotionKeyboard

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        
        self.keyboardTabBar = [[HREmotionKeyboardTabBar alloc] init];
        self.keyboardTabBar.delegate = self;
        [self addSubview:self.keyboardTabBar];
        self.keyboardTabBar.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (HREmotionKeyboardListView *)emotionListViewRecent {
    if (_emotionListViewRecent == nil) {
        _emotionListViewRecent = [[HREmotionKeyboardListView alloc] init];
    }
    return _emotionListViewRecent;
}

- (HREmotionKeyboardListView *)emotionListViewDefault {
    if (_emotionListViewDefault == nil) {
        _emotionListViewDefault = [[HREmotionKeyboardListView alloc] init];
    }
    return _emotionListViewDefault;
}

- (HREmotionKeyboardListView *)emotionListViewEmojo {
    if (_emotionListViewEmojo == nil) {
        _emotionListViewEmojo = [[HREmotionKeyboardListView alloc] init];
    }
    return _emotionListViewEmojo;
}

- (HREmotionKeyboardListView *)emotionListViewLxh {
    if (_emotionListViewLxh == nil) {
        _emotionListViewLxh = [[HREmotionKeyboardListView alloc] init];
    }
    return _emotionListViewLxh;
}

- (void)layoutSubviews {
    self.keyboardTabBar.width = self.width;
    self.keyboardTabBar.height = 39;
    self.keyboardTabBar.x = 0;
    self.keyboardTabBar.y = self.height - self.keyboardTabBar.height;
    
    self.showingView.width = self.width;
    self.showingView.height = self.height - self.keyboardTabBar.height;
    self.showingView.x = 0;
    self.showingView.y = 0;
}

#pragma mark - HREmotionKeyboardTabBarDelegate

- (void)emotionKeyboardTabBar:(HREmotionKeyboardTabBar *)toolBar didClickButton:(HREmotionKeyboardTabBarButtonType)buttonType {
    [self.showingView removeFromSuperview];
    switch (buttonType) {
        case HREmotionKeyboardTabBarRecent: {
            [self addSubview:self.emotionListViewRecent];
            break;
        }
        case HREmotionKeyboardTabBarDefault: {
            [self addSubview:self.emotionListViewDefault];
            break;
        }
        case HREmotionKeyboardTabBarEmojo: {
            [self addSubview:self.emotionListViewEmojo];
            break;
        }
        case HREmotionKeyboardTabBarLxh: {
            [self addSubview:self.emotionListViewLxh];
            break;
        }
        default:
            break;
        
    }
    self.showingView = [self.subviews lastObject];
}


@end
