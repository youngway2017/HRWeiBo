//
//  TitleButton.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/3.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton

- (instancetype)initWithFrame:(CGRect)frame {
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
    HRLog(@"%@",NSStringFromCGRect(self.imageView.frame));
    self.titleLabel.x = (self.width - (self.titleLabel.width + self.imageView.width)) *0.5;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self sizeToFit];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self sizeToFit];
}



@end
