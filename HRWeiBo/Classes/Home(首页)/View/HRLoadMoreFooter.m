//
//  FooterView.m
//  HRWeiBo
//
//  Created by yangwei on 15/12/6.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRLoadMoreFooter.h"

@implementation HRLoadMoreFooter

+ (instancetype)footerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"HRLoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
