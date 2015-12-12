//
//  HREmotionKeyboardListView.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/11.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HREmotionKeyboardListView.h"

@interface HREmotionKeyboardListView()

@property (nonatomic, strong) UIPageControl *pageControl;


@end

@implementation HREmotionKeyboardListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = HRRandomColor;
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.backgroundColor = [UIColor whiteColor];
        pageControl.userInteractionEnabled = NO;
//        pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_keyboard_dot_normal"]];
//        pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_keyboard_dot_selected"]];
        // 设置内部的圆点图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        pageControl.numberOfPages = 5;
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)layoutSubviews {
    self.pageControl.width = self.width;
    self.pageControl.height = 20;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
}

@end
