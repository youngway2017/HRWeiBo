//
//  TitleButton.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/3.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRTitleButton.h"

#define marginValue 10

@implementation HRTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    HRLog(@"initWithFrame=%@",NSStringFromCGRect(frame));
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.x = (self.width - (self.titleLabel.width + self.imageView.width + marginValue)) *0.5;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + marginValue;
    HRLog(@"frame=%@",NSStringFromCGRect(self.frame));
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self sizeToFit];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)sizeToFit {
    [super sizeToFit];
    self.bounds = CGRectMake(0, 0, self.width+marginValue, self.height);
}

@end
