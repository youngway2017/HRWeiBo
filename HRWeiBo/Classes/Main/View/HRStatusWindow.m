//
//  HRStatusWindow.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/10.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRStatusWindow.h"

@interface HRStatusWindow()


@end

@implementation HRStatusWindow

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //        <#statements#>
        self.message = @"";
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}


- (void)setMessage:(NSString *)message {
    _message = message;
    UILabel *msg = [[UILabel alloc] init];
    msg.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    msg.backgroundColor = [UIColor grayColor];
    msg.textAlignment = NSTextAlignmentCenter;
    msg.font = [UIFont systemFontOfSize:14];
    msg.text = message;
    [self addSubview:msg];
    
//    UIButton *btn = [[UIButton alloc] init];
//    btn.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
//    btn.backgroundColor = [UIColor orangeColor];
//    [btn setTitle:message forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self addSubview:btn];
    
}

- (void)show {
    UIWindow *lastWindow = [[UIApplication sharedApplication].windows lastObject];
    
    [lastWindow addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}
@end
