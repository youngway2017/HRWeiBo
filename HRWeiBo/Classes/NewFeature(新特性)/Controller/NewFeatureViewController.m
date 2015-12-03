//
//  NewFeatureViewController.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/2.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "HRTabBarController.h"

@interface NewFeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)  UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation NewFeatureViewController

- (UIScrollView *)scrollView {
    if(_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.bounds;
        _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(self.view.width * 4, self.view.height);
        _scrollView.delegate = self;
        [self.view addSubview: _scrollView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if(_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 4;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.frame = CGRectMake((self.view.width - 100) *0.5, self.view.height - 60, 100, 0);
        [self.view addSubview:_pageControl];
        
    }
    return _pageControl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addImageToScrollView];
    self.pageControl.currentPage = 0;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / self.view.width + 0.5);
}

- (void)addImageToScrollView {
    for (int i = 0; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d",i+1]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(self.view.width * i, 0, self.view.width, self.view.height);
        if(i == 3) {
            [self setButtonToImageView:imageView];
            
        }
        [self.scrollView addSubview:imageView];
    }
}

- (void)setButtonToImageView:(UIImageView *)imageView {
    imageView.userInteractionEnabled = YES;
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    [share setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [share setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [share setTitle:@"分享给大家" forState:UIControlStateNormal];
    [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    share.titleLabel.font = [UIFont systemFontOfSize:16];
    share.frame = CGRectMake((imageView.size.width - 150) * 0.5, imageView.size.height * 0.6, 150, 44);
    share.titleEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
    
    [share addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:share];
    
    UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
    [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [start setTitle:@"开始微博" forState:UIControlStateNormal];
    [start setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    start.titleLabel.font = [UIFont systemFontOfSize:20];
    start.frame = CGRectMake((imageView.size.width - 150) * 0.6, imageView.size.height * 0.7, 150, 44);
    
    [start addTarget:self action:@selector(startClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:start];
    
}

- (void)shareClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (void)startClick:(UIButton *)sender {
    HRTabBarController *tabController = [[HRTabBarController alloc] init];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.rootViewController = tabController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
