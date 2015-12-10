//
//  HRStatusWindow.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/10.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRStatusWindow.h"

@interface HRStatusWindow()

@property (nonatomic, strong) UILabel *showMsg;

@end

@implementation HRStatusWindow

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //        <#statements#>
        self.message = @"";
        self.bounds = CGRectMake(0, 0, 90, 90);
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (UILabel *)showMsg {
    if(_showMsg == nil) {
        _showMsg = [[UILabel alloc] init];
        _showMsg.bounds = CGRectMake(0, 0, self.width, self.height);
        [self addSubview:_showMsg];
    }
    return _showMsg;
}


- (void)setMessage:(NSString *)message {
    _message = message;
    self.showMsg.text = message;
}

- (void)show {
    UIWindow *lastWindow = [[UIApplication sharedApplication].windows lastObject];
    self.frame = lastWindow.frame;
    [lastWindow addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}
@end
