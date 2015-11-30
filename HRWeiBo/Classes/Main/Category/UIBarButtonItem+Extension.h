//
//  UIBarButtonItem+Extension.h
//  HRWeiBo
//
//  Created by Yangwei on 15/11/30.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)barButtonItemWithTarget:(UIViewController *)target Image:(NSString *)image imageHighlighted:(NSString *)imageHighlighted action:(SEL)action;
@end
