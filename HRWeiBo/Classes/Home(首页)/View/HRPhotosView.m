//
//  HRPhotosView.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/9.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRPhotosView.h"
#import "HRPhoto.h"
#import "HRPhotoView.h"
#define maxCountPerRow(count) (count==4?2:3)

@implementation HRPhotosView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos {
    _photos = photos;
    int photosCount = (int)photos.count;
    
    while (self.subviews.count < photosCount) {
        HRPhotoView *imageView = [[HRPhotoView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
    }
    
    for (int i = 0; i < self.subviews.count; i++) {
        HRPhotoView *imageView = (HRPhotoView *)self.subviews[i];
        if (i < photosCount) {
            HRPhoto *photo = photos[i];
            [imageView setPhoto:photo];
            imageView.hidden = NO;
        } else {
            imageView.hidden = YES;
        }
    }
}

- (void)layoutSubviews {
    
    int cols = 0;
    int rows = 0;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = photoWH;
    CGFloat h = photoWH;
    int count = (int)self.photos.count;
    for (int i = 0; i < count; i++) {
        HRPhotoView *imageView = (HRPhotoView *)self.subviews[i];
        cols = i % maxCountPerRow(count);
        rows = i / maxCountPerRow(count);
        x = cols * (photoWH + photoMargin);
        y = rows * (photoWH + photoMargin);
        imageView.frame = CGRectMake(x, y, w, h);
    }
}

+ (CGSize)photosViewSizeWithCount:(int) count {
    int cols = 0;
    int rows = 0;
    cols = count > maxCountPerRow(count) ? maxCountPerRow(count) : count;
    rows = (count + maxCountPerRow(count) - 1 ) / maxCountPerRow(count);
    
    CGFloat photosW = cols * photoWH + (cols - 1) * photoMargin;
    CGFloat photosH = rows * photoWH + (rows - 1) * photoMargin;
    return CGSizeMake(photosW, photosH);
}

@end
