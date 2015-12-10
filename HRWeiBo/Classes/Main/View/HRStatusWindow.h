//
//  HRStatusWindow.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/10.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRStatusWindow : UIWindow

@property (nonatomic, copy) NSString *message;

- (void)show;
- (void)dismiss;

@end
