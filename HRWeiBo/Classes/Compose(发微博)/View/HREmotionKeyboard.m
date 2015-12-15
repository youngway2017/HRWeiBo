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
#import "MJExtension.h"
#import "HREmotion.h"
#import "HREmotionTool.h"
#import "HRConst.h"

@interface HREmotionKeyboard()<HREmotionKeyboardTabBarDelegate>

@property (nonatomic, strong) HREmotionKeyboardListView *emotionListViewRecent;
@property (nonatomic, strong) HREmotionKeyboardListView *emotionListViewDefault;
@property (nonatomic, strong) HREmotionKeyboardListView *emotionListViewEmoji;
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
        _emotionListViewRecent.emotions = [HREmotionTool emotions];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionButtonDidSelect) name:HREmotionButtonDidSelectNotification object:nil];
    }
    return _emotionListViewRecent;
}

- (HREmotionKeyboardListView *)emotionListViewDefault {
    if (_emotionListViewDefault == nil) {
        _emotionListViewDefault = [[HREmotionKeyboardListView alloc] init];
        _emotionListViewDefault.emotions = [self emotionsArrayWithPath:@"EmotionIcons/default/info.plist"];
    }
    return _emotionListViewDefault;
}

- (HREmotionKeyboardListView *)emotionListViewEmoji {
    if (_emotionListViewEmoji == nil) {
        _emotionListViewEmoji = [[HREmotionKeyboardListView alloc] init];
        _emotionListViewEmoji.emotions = [self emotionsArrayWithPath:@"EmotionIcons/emoji/info.plist"];
    }
    return _emotionListViewEmoji;
}

- (HREmotionKeyboardListView *)emotionListViewLxh {
    if (_emotionListViewLxh == nil) {
        _emotionListViewLxh = [[HREmotionKeyboardListView alloc] init];
        _emotionListViewLxh.emotions = [self emotionsArrayWithPath:@"EmotionIcons/lxh/info.plist"];
    }
    return _emotionListViewLxh;
}

- (NSArray *)emotionsArrayWithPath:(NSString *)pathStr {
    NSString *path = [[NSBundle mainBundle] pathForResource:pathStr ofType:nil];
    return [HREmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
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
        case HREmotionKeyboardTabBarEmoji: {
            [self addSubview:self.emotionListViewEmoji];
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

- (void)emotionButtonDidSelect {
    self.emotionListViewRecent.emotions = [HREmotionTool emotions];
    HRLog(@"亲 ，该刷新了");
}

- (void)dealloc {
    HRLog(@"亲 ，该销毁了");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
