//
//  HRComposePhotosView.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/11.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRComposePhotosView.h"

@interface HRComposePhotosView()

@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation HRComposePhotosView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (NSMutableArray *)images {
    if(_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)addImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:image];
    [self addSubview:imageView];
    [self.images addObject:image];
    
}

- (NSArray *)photos {
    return self.images;
}

- (void)layoutSubviews {
    int maxCountPerRows = 4;
    int count = (int)self.subviews.count;
    CGFloat margin = 6;
    CGFloat wh = 70;
    
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = (UIImageView *)self.subviews[i];
        int cols = i % maxCountPerRows;
        int rows = i / maxCountPerRows;
        x = cols * (wh + margin);
        y = rows * (wh + margin);
        imageView.frame = CGRectMake(x, y, wh, wh);
    }
}

@end
