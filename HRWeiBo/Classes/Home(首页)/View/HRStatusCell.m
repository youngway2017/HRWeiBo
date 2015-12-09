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
#import "HRStatusToolbar.h"
#import "HRStatusToolbar.h"

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

/***************************************************/
/**转发微博正文 对应 HRStatus text*/
@property (nonatomic, strong) UILabel *retweetedContentLabel;

/**转发微博配图 对应 HRStatus pic_urls*/
@property (nonatomic, strong) UIImageView *retweetedPhoto;

/**转发微博整体*/
@property (nonatomic, strong) UIView *retweetedView;

/***************************************************/
/**toolbarView*/
@property (nonatomic, strong) HRStatusToolbar *toolbarView;

@end


@implementation HRStatusCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCellComponent];
    }
    
    return self;
}

- (void)setStatusFrame:(HRStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    //设置原创微博
    [self setOriginalStatus:statusFrame];
    if (statusFrame.status.retweeted_status) {
        self.retweetedView.hidden = NO;
        //设置转发微博        
        [self setRetweetedStatus:statusFrame];
        
    } else {
        self.retweetedView.hidden = YES;
    }
    
    [self setToolbarStatus:statusFrame];
    
}

//设置原创微博Frame
- (void)setOriginalStatus:(HRStatusFrame *)statusFrame {
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
    
    NSString *createdTime = status.created_at;
    
    //创建时间Frame重新计算
    CGFloat createdTimeX = CGRectGetMaxX(statusFrame.headIconF) + StatusCellChildMargin;
    CGFloat createdTimeY = CGRectGetMaxY(statusFrame.screenNameF);
    CGSize  createdTimeSize = [createdTime boundingSizeWithSize:CGSizeMake(cellWith, MAXFLOAT) font:StatusCellCreateTimeFont];
    statusFrame.createdTimeF = (CGRect){{createdTimeX,createdTimeY},createdTimeSize};
    
    //创建时间
    self.createdTimeLabel.text = createdTime;
    self.contentLabel.numberOfLines = 1;
    self.createdTimeLabel.font = StatusCellCreateTimeFont;
    self.createdTimeLabel.frame = statusFrame.createdTimeF;
    
    //来源Frame重新计算
    CGFloat sourceX = CGRectGetMaxX(statusFrame.createdTimeF) + StatusCellChildMargin;
    CGFloat sourceY = createdTimeY;
    
    CGSize  sourceSize = [status.source boundingSizeWithSize:CGSizeMake(cellWith, MAXFLOAT) font:StatusCellSourceFont];
    
    statusFrame.sourceF = (CGRect){{sourceX,sourceY},sourceSize};
    
    //来源
    self.sourceLabel.text = status.source;
    self.contentLabel.numberOfLines = 1;
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

//设置转发微博Frame
- (void)setRetweetedStatus:(HRStatusFrame *)statusFrame {
    HRStatus *status = statusFrame.status;
    HRStatus *retweetedStatus = status.retweeted_status;
    HRUser *retweetedUser = retweetedStatus.user;
    
    //正文
    self.retweetedContentLabel.text = [NSString stringWithFormat:@"@%@:%@",retweetedUser.screen_name,retweetedStatus.text];
    self.retweetedContentLabel.numberOfLines = 0;
    self.retweetedContentLabel.font = StatusCellRetweetedContentFont;
    self.retweetedContentLabel.frame = statusFrame.retweetedContentF;
    
    if (retweetedStatus.pic_urls.count) {
        self.retweetedPhoto.hidden = NO;
        HRPhoto *photo = [retweetedStatus.pic_urls firstObject];
        [self.retweetedPhoto sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.retweetedPhoto.frame = statusFrame.retweetedPhotoF;
    } else {
        self.retweetedPhoto.hidden = YES;
    }
    
    self.retweetedView.frame = statusFrame.retweetedF;
}

//设置工具条Frame
- (void)setToolbarStatus:(HRStatusFrame *)statusFrame {
    HRStatus *status = statusFrame.status;
    [self.toolbarView setStatus:status];
    self.toolbarView.frame = statusFrame.toolbarF;
}


- (void)createCellComponent {
    /**原创微博*/
    UIView *originalView = [[UIView alloc] init];
    self.originalView = originalView;
    
    [self.contentView addSubview:self.originalView];
    
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
    
    /**转发微博*/
    UIView *retweetedView = [[UIView alloc] init];
    self.retweetedView = retweetedView;
    [self.contentView addSubview:self.retweetedView];
    
    UILabel *retweetedContentLabel = [[UILabel alloc] init];
    self.retweetedContentLabel = retweetedContentLabel;
    [self.retweetedView addSubview:self.retweetedContentLabel];
    
    UIImageView *retweetedPhoto = [[UIImageView alloc] init];
    self.retweetedPhoto = retweetedPhoto;
    [self.retweetedView addSubview:self.retweetedPhoto];
    
    /**toolbar*/
    HRStatusToolbar *toolbarView = [HRStatusToolbar toolbar];
    self.toolbarView = toolbarView;
    self.toolbarView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.toolbarView];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.originalView.backgroundColor = [UIColor whiteColor];
    self.retweetedView.backgroundColor = HRRgba(230, 230, 230, 0.5);
}

@end
