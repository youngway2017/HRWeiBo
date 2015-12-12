//
//  HREmotionKeyboardListView.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/11.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HREmotionKeyboardListView.h"
#import "HREmotionPageView.h"

@interface HREmotionKeyboardListView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIScrollView *scrollView;



@end

@implementation HREmotionKeyboardListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.backgroundColor = [UIColor whiteColor];
        pageControl.userInteractionEnabled = NO;
//        pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_keyboard_dot_normal"]];
//        pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_keyboard_dot_selected"]];
        // 设置内部的圆点图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];

        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.alwaysBounceVertical = NO;
        scrollView.alwaysBounceHorizontal = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    NSUInteger emotionsCount = emotions.count;
    NSUInteger count = (emotionsCount + HREmotionMaxCountPerPage - 1) / HREmotionMaxCountPerPage;
    self.pageControl.numberOfPages = count;
    
    for (NSUInteger i = 0; i < count; i++) {
        HREmotionPageView *page = [[HREmotionPageView alloc] init];
        NSRange range;
        range.location = i * HREmotionMaxCountPerPage;
        range.length = emotionsCount - range.location >20 ? 20 :emotionsCount - range.location;
        page.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:page];
    }
}

- (void)layoutSubviews {
    self.pageControl.width = self.width;
    self.pageControl.height = 20;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    self.scrollView.width = self.width;
    self.scrollView.height = self.height - self.pageControl.height;
    self.scrollView.x = 0;
    self.scrollView.y = 0;
    
    NSUInteger childCount = self.scrollView.subviews.count;
    for (NSUInteger i = 0; i < childCount; i++) {
        HREmotionPageView *page = (HREmotionPageView *)self.scrollView.subviews[i];
        page.width = self.scrollView.width;
        page.height = self.scrollView.height;
        page.x = self.scrollView.width * i;
        page.y = 0;
    }
    self.scrollView.contentSize = CGSizeMake(childCount * self.scrollView.width, 0);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSUInteger page = (NSUInteger)(scrollView.contentOffset.x / scrollView.width +0.5);
    self.pageControl.currentPage = page;
}

@end
