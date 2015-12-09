//
//  HRPhotoView.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/9.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRPhotoView.h"
#import "UIImageView+WebCache.h"
#import "HRPhoto.h"

@interface HRPhotoView()

@property (nonatomic, strong) UIImageView *gif;
@end

@implementation HRPhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        
    }
    return self;
}

- (UIImageView *)gif {
    if (_gif == nil) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        _gif = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_gif];
    }
    return _gif;
}

- (void)setPhoto:(HRPhoto *)photo {
    _photo = photo;
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    if ([photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"]) {
        self.gif.hidden = NO;
    } else {
        self.gif.hidden = YES;
    }
}

- (void)layoutSubviews {
    self.gif.x = self.width - self.gif.width;
    self.gif.y = self.height - self.gif.height;
}


@end
