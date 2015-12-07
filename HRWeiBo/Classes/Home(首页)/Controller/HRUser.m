//
//  User.m
//  HRWeiBo
//
//  Created by yangwei on 15/12/5.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRUser.h"

@implementation HRUser

- (void)setMbrank:(NSString *)mbrank {
    _mbrank = mbrank;
    if ([mbrank intValue] > 2) {
        _isVip = YES;
    } else {
        _isVip = NO;
    }
}

@end
