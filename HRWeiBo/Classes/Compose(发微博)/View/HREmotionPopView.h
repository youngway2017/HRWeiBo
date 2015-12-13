//
//  HREmotionPopView.h
//  HRWeiBo
//
//  Created by yangwei on 15/12/13.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HREmotionButton;

@interface HREmotionPopView : UIView


+ (instancetype)popView;

- (void)showFromButton:(HREmotionButton *)sender;

@end
