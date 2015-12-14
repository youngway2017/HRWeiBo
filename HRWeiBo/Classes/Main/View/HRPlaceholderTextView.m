//
//  HRPlaceholderTextView.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/10.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRPlaceholderTextView.h"

@implementation HRPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.placeholderColor = [UIColor grayColor];
        self.font = [UIFont systemFontOfSize:12];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setTextColor:(UIColor *)textColor {
    [super setTextColor:textColor];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)textDidChange {
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if(self.hasText) return;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.placeholderColor forKey:NSForegroundColorAttributeName];
    [dict setObject:self.font forKey:NSFontAttributeName];
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat w = rect.size.width - 2*x;
    CGFloat h = rect.size.height - 2*y;
    
    CGRect drawRect = CGRectMake(x, y, w, h);
    [self.placeholder drawWithRect:drawRect options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
}

@end
