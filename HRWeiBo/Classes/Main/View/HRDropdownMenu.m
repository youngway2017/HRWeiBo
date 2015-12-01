//
//  HRDropdownMenu.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/1.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRDropdownMenu.h"

@interface HRDropdownMenu()

@property (nonatomic, strong) UIImageView *contentImageView;

@end

@implementation HRDropdownMenu

- (UIImageView *)contentImageView {
    if(_contentImageView == nil) {
        _contentImageView = [[UIImageView alloc] init];
        
        _contentImageView.image = [UIImage imageNamed:@"popover_background"];
        _contentImageView.userInteractionEnabled = YES;
        [self addSubview:_contentImageView];
    }
    return _contentImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
//        []
    }
    return self;
}

+ (instancetype)menu {
    return [[self alloc] init];
}

- (void)setContentView:(UIView *)contentView {
    _contentView = contentView;
    HRLog(@"%f",contentView.width + 20);
    self.contentImageView.bounds = CGRectMake(0, 0, contentView.width + 20, contentView.height + 25);
    contentView.frame = CGRectMake(10, 15, contentView.width, contentView.height);
    [self.contentImageView addSubview:contentView];
}

- (void)setContentController:(UIViewController *)contentController {
    _contentController = contentController;
    [self setContentView:contentController.view];
}

- (void)showMenuFrom:(UIView *)from {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    CGRect frame = [from convertRect:from.bounds toView:nil];
    self.frame = window.frame;
    self.contentImageView.center = CGPointMake(frame.origin.x + frame.size.width * 0.5, CGRectGetMaxY(frame) + self.contentImageView.height * 0.5);
    [window addSubview:self];
}

- (void)dismissMenu {
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissMenu];
    if([self.delegate respondsToSelector:@selector(dropdownMenuDiddismiss:)]) {
        [self.delegate dropdownMenuDiddismiss:self];
    }
}

@end
