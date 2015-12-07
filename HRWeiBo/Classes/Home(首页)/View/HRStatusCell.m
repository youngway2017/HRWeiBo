//
//  HRStatusCell.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/7.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRStatusCell.h"
#import "HRStatusFrame.h"
#import "HRStatus.h"
#import "HRUser.h"
#import "UIImageView+WebCache.h"
#import "HRPhoto.h"


@interface HRStatusCell()


/**原创微博头像 对应 HRUser profile_image_url*/
@property (nonatomic, strong) UIImageView *headIcon;

/**原创微博用户昵称 对应 HRUser screen_name*/
@property (nonatomic, strong) UILabel *screenNameLabel;

/**原创微博用户会员icon 对应 HRUser mbrank*/
@property (nonatomic, strong) UIImageView *vipIcon;


/**原创微博创建时间 对应 HRStatus created_at*/
@property (nonatomic, strong) UILabel *createdTimeLabel;


/**原创微博来源 对应 HRStatus source*/
@property (nonatomic, strong) UILabel *sourceLabel;


/**原创微博正文 对应 HRStatus text*/
@property (nonatomic, strong) UILabel *contentLabel;

/**原创微博配图 对应 HRStatus pic_urls*/
@property (nonatomic, strong) UIImageView *photo;


/**原创微博整体*/
@property (nonatomic, strong) UIView *originalView;


@end


@implementation HRStatusCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCellComponent];
    }
    
    return self;
}

- (void)setStatusFrame:(HRStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    HRStatus *status = statusFrame.status;
    HRUser *user = status.user;
    
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.headIcon.frame = statusFrame.headIconF;
    //昵称
    self.screenNameLabel.text = user.screen_name;
    self.screenNameLabel.font = StatusCellScreenNameFont;
    self.screenNameLabel.frame = statusFrame.screenNameF;
    
    //vip标示
    if (user.isVip) {
        self.vipIcon.hidden = NO;
        self.screenNameLabel.textColor = [UIColor orangeColor];
        NSString *vip = [NSString stringWithFormat:@"common_icon_membership_level%@", user.mbrank];
        [self.vipIcon setImage:[UIImage imageNamed:vip]];
        self.vipIcon.frame = statusFrame.vipF;
    } else {
        self.vipIcon.hidden = YES;
        self.screenNameLabel.textColor = [UIColor blackColor];
    }
    
    
    //创建时间
    self.createdTimeLabel.text = status.created_at;
    self.createdTimeLabel.font = StatusCellCreateTimeFont;
    self.createdTimeLabel.frame = statusFrame.createdTimeF;
    
    //来源
    self.sourceLabel.text = status.source;
    self.sourceLabel.font = StatusCellSourceFont;
    self.sourceLabel.frame = statusFrame.sourceF;
    
    //正文
    self.contentLabel.text = status.text;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = StatusCellContentFont;
    self.contentLabel.frame = statusFrame.contentF;
    
    
    if (status.pic_urls.count) {
        self.photo.hidden = NO;
        HRPhoto *photo = [status.pic_urls firstObject];
        [self.photo sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photo.frame = statusFrame.photoF;
    } else {
        self.photo.hidden = YES;
    }
    
    self.originalView.frame = statusFrame.originalF;
}

- (void)createCellComponent {
    UIView *originalView = [[UIView alloc] init];
    self.originalView = originalView;
    [self addSubview:self.originalView];
    
    UIImageView *headIcon = [[UIImageView alloc] init];
    self.headIcon = headIcon;
    [self.originalView addSubview:self.headIcon];
    
    UILabel *screenNameLabel = [[UILabel alloc] init];
    self.screenNameLabel = screenNameLabel;
    [self.originalView addSubview:self.screenNameLabel];
    
    UIImageView *vipIcon = [[UIImageView alloc] init];
    self.vipIcon = vipIcon;
    [self.originalView addSubview:self.vipIcon];
    
    UILabel *createdTimeLabel = [[UILabel alloc] init];
    self.createdTimeLabel = createdTimeLabel;
    [self.originalView addSubview:self.createdTimeLabel];
    
    UILabel *sourceLabel = [[UILabel alloc] init];
    self.sourceLabel = sourceLabel;
    [self.originalView addSubview:self.sourceLabel];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    self.contentLabel = contentLabel;
    [self.originalView addSubview:self.contentLabel];
    
    UIImageView *photo = [[UIImageView alloc] init];
    self.photo = photo;
    [self.originalView addSubview:self.photo];
    
}

@end
