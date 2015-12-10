//
//  HRIconView.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/10.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HRUser;

@interface HRIconView : UIImageView

@property (nonatomic, strong) HRUser *user;

- (void)setUser:(HRUser *)user;

@end
