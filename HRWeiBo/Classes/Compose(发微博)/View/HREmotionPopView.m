//
//  HREmotionPopView.m
//  HRWeiBo
//
//  Created by yangwei on 15/12/13.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HREmotionPopView.h"
#import "HREmotionButton.h"

@interface HREmotionPopView()

@property (weak, nonatomic) IBOutlet HREmotionButton *emotionButton;

@end

@implementation HREmotionPopView

+ (instancetype)popView {
    return [[[NSBundle mainBundle] loadNibNamed:@"HREmotionPopView" owner:nil options:nil]lastObject];
}


- (void)showFromButton:(HREmotionButton *)sender {
    self.emotionButton.emotion = sender.emotion;
    UIWindow *window = [[[UIApplication sharedApplication] windows]lastObject];
    [window addSubview:self];
    CGRect rect = [sender convertRect:sender.bounds toView:window];
    self.centerX = rect.origin.x + rect.size.width * 0.5;
    self.y = rect.origin.y - self.height + sender.height * 0.5;
}

@end
