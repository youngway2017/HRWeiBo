//
//  HRTabBar.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/1.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRTabBar.h"
#define childCount 5
@interface HRTabBar()
@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation HRTabBar


+ (instancetype)tabBar {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        UIButton *addBtn = [[UIButton alloc] init];
        UIImage *image = [UIImage imageNamed:@"tabbar_compose_button_highlighted"];
        [addBtn setBackgroundImage:image forState:UIControlStateHighlighted];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [addBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [addBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        addBtn.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
        [self addSubview:addBtn];
        [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _addBtn = addBtn;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    HRLog(@"%@",self.subviews);
    int index = 0;
    CGFloat perWidth = self.width / childCount;
    for (int i = 0; i < self.subviews.count; i++) {
        Class clz = NSClassFromString(@"UITabBarButton");
        UIView *child = self.subviews[i];
        
        if([child isKindOfClass:clz]) {
            if(index == 2) {
                index++;
            }
            child.frame = CGRectMake(index * perWidth, 0, perWidth, self.height);
            HRLog(@"%@",NSStringFromCGRect(child.frame));
            index++;
        }
    }
    _addBtn.centerX = self.centerX;
    _addBtn.y = 3;
}

- (void)addBtnClick:(UIButton *)sender {
    HRLog(@"addBtnClick");
    if([self.delegate respondsToSelector:@selector(tabBarDidClickAddBtn:)]) {
        [self.delegate tabBarDidClickAddBtn:self];
    }
}
@end
