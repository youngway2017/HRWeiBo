//
//  HREmotionKeyBoardTabBar.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/11.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HREmotionKeyboardTabBarRecent,
    HREmotionKeyboardTabBarDefault,
    HREmotionKeyboardTabBarEmojo,
    HREmotionKeyboardTabBarLxh
} HREmotionKeyboardTabBarButtonType;

@class HREmotionKeyboardTabBar;
@protocol HREmotionKeyboardTabBarDelegate <NSObject>

@optional

- (void)emotionKeyboardTabBar:(HREmotionKeyboardTabBar *)toolBar didClickButton:(HREmotionKeyboardTabBarButtonType)buttonType;

@end

@interface HREmotionKeyboardTabBar : UIView

@property (nonatomic, weak) id<HREmotionKeyboardTabBarDelegate> delegate;
@end
