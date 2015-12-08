//
//  HRStatusToolbar.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/8.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HRStatus;
@interface HRStatusToolbar : UIView

@property (nonatomic, strong) HRStatus *status;

+ (instancetype)toolbar;

@end
