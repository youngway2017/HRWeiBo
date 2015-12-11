//
//  HRComposeKeyboardToolBar.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/11.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HRComposeKeyboardToolBarPicture,
    HRComposeKeyboardToolBarCamera,
    HRComposeKeyboardToolBarMention,
    HRComposeKeyboardToolBarTrend,
    HRComposeKeyboardToolBarEmoticon
} HRComposeKeyboardToolBarButtonType;

@class HRComposeKeyboardToolBar;
@protocol HRComposeKeyboardToolBarDelegate <NSObject>

@optional

- (void)composeKeyboardToolBar:(HRComposeKeyboardToolBar *)toolBar didClickButton:(HRComposeKeyboardToolBarButtonType)buttonType;

@end

@interface HRComposeKeyboardToolBar : UIView

@property (nonatomic, weak) id<HRComposeKeyboardToolBarDelegate> delegate;

@end
