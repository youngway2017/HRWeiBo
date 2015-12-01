//
//  HRSeachBar.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/1.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRSeachBar.h"

@implementation HRSeachBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        leftView.contentMode = UIViewContentModeCenter;
        self.leftView = leftView;
        self.leftView.size = CGSizeMake(30, 30);
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.placeholder = @"请输入搜索条件";
    }
    return self;
}

+ (instancetype)seachBar {
    return [[self alloc] init];
}



@end
