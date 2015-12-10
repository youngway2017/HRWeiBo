//
//  HRIconView.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/10.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRIconView.h"
#import "HRUser.h"
#import "UIImageView+WebCache.h"

@interface HRIconView()

@property (nonatomic, strong) UIImageView *typeImageView;

@end

@implementation HRIconView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        
    }
    return self;
}

- (UIImageView *)typeImageView {
    if(_typeImageView == nil) {
        _typeImageView = [[UIImageView alloc] init];
        [self addSubview:_typeImageView];
    }
    return _typeImageView;
}

- (void)setUser:(HRUser *)user {
    _user = user;
    
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];

    switch (user.verified_type) {
        case HRUserVerifiedTypeOrgMedia:
        case HRUserVerifiedTypeOrgWebsite:
        case HRUserVerifiedTypeOrgEnterprice:
            self.typeImageView.hidden = NO;
            [self.typeImageView setImage:[UIImage imageNamed:@"avatar_enterprise_vip"]];
            break;
        case HRUserVerifiedTypePersonal:
            self.typeImageView.hidden = NO;
            [self.typeImageView setImage:[UIImage imageNamed:@"avatar_vip"]];
            break;
        case HWUserVerifiedTypeDaren:
            self.typeImageView.hidden = NO;
            [self.typeImageView setImage:[UIImage imageNamed:@"avatar_grassroot"]];
            break;
        default:
            self.typeImageView.hidden = YES;
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    HRLog(@"--%@",NSStringFromCGRect(self.typeImageView.frame));
    self.typeImageView.size = self.typeImageView.image.size;
    self.typeImageView.x = self.width - self.typeImageView.width * 0.6;
    self.typeImageView.y = self.height - self.typeImageView.height * 0.6;
    
}

@end
