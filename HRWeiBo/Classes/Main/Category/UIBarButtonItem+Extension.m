//
//  UIBarButtonItem+Extension.m
//  HRWeiBo
//
//  Created by Yangwei on 15/11/30.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)barButtonItemWithTarget:(UIViewController *)target Image:(NSString *)image imageHighlighted:(NSString *)imageHighlighted action:(SEL)action {
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRight setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btnRight setImage:[UIImage imageNamed:imageHighlighted] forState:UIControlStateHighlighted];
    btnRight.bounds = CGRectMake(0, 0, 30, 30);
    [btnRight addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btnRight];
}

@end
