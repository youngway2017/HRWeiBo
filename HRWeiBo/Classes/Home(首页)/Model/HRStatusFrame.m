//
//  HRStatusFrame.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/7.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRStatusFrame.h"
#import "HRStatus.h"
#import "HRUser.h"


@implementation HRStatusFrame

- (void)setStatus:(HRStatus *)status {
    _status = status;
    [self setOriginalStatus:status];
    
    if (status.retweeted_status) {
        [self setRetweetedStatus:status.retweeted_status];
        
        self.cellHeight = CGRectGetMaxX(self.retweetedF) + 10;
    } else {
        self.cellHeight = CGRectGetMaxX(self.originalF) + 10;
    }
    
    
}

- (void)setOriginalStatus:(HRStatus *)status {
    HRUser *user = status.user;
    
    CGFloat cellWith = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat headIconX = StatusCellMargin;
    CGFloat headIconY = StatusCellMargin;
    CGFloat headIconWH = 35;
    self.headIconF = CGRectMake(headIconX, headIconY, headIconWH, headIconWH);
    //昵称
    CGFloat screenNameX = CGRectGetMaxX(self.headIconF) + StatusCellChildMargin;
    CGFloat screenNameY = headIconY;
    
    CGSize  screenNameSize = [user.screen_name boundingSizeWithSize:CGSizeMake(cellWith, MAXFLOAT) font:StatusCellScreenNameFont];
    
    self.screenNameF = (CGRect){{screenNameX,screenNameY},screenNameSize};
    
    //vipF
    
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.screenNameF) + StatusCellChildMargin;
        CGFloat vipY = screenNameY;
        CGFloat vipWH = 15;
        self.vipF = CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    
    
    //创建时间
    CGFloat createdTimeX = CGRectGetMaxX(self.headIconF) + StatusCellChildMargin;
    CGFloat createdTimeY = CGRectGetMaxY(self.screenNameF);
    
    CGSize  createdTimeSize = [status.created_at boundingSizeWithSize:CGSizeMake(cellWith, MAXFLOAT) font:StatusCellCreateTimeFont];
    
    self.createdTimeF = (CGRect){{createdTimeX,createdTimeY},createdTimeSize};
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(self.createdTimeF) + StatusCellChildMargin;
    CGFloat sourceY = createdTimeY;
    
    CGSize  sourceSize = [status.source boundingSizeWithSize:CGSizeMake(cellWith, MAXFLOAT) font:StatusCellSourceFont];
    
    self.sourceF = (CGRect){{sourceX,sourceY},sourceSize};
    
    //正文
    CGFloat contentX = StatusCellMargin;
    CGFloat contentY = MAX(CGRectGetMaxY(self.headIconF), CGRectGetMaxY(self.createdTimeF)) + StatusCellChildMargin;
    
    CGSize  contentSize = [status.text boundingSizeWithSize:CGSizeMake(cellWith - 2*StatusCellMargin, MAXFLOAT) font:StatusCellContentFont];
    
    self.contentF = (CGRect){{contentX,contentY},contentSize};
    
    CGFloat originalH = CGRectGetMaxY(self.contentF) + StatusCellMargin;
    if (status.pic_urls.count) {
        CGFloat photoX = StatusCellMargin;
        CGFloat photoY = CGRectGetMaxY(self.contentF) + StatusCellChildMargin;
        CGFloat photoWH = 100;
        self.photoF = CGRectMake(photoX, photoY, photoWH, photoWH);
        originalH = CGRectGetMaxY(self.photoF) + StatusCellMargin;
    }
    
    self.originalF = CGRectMake(0, 0, cellWith, originalH);
}

- (void)setRetweetedStatus:(HRStatus *)retweetedStatus {
    HRUser *retweetedUser = retweetedStatus.user;
    
    CGFloat cellWith = [UIScreen mainScreen].bounds.size.width;

    //转发正文
    CGFloat retweetedContentX = StatusCellMargin;
    CGFloat retweetedContentY = StatusCellMargin;
    
    NSString *retweetedContent = [NSString stringWithFormat:@"%@:%@",retweetedUser.screen_name,retweetedStatus.text];
    CGSize  retweetedContentSize = [retweetedContent boundingSizeWithSize:CGSizeMake(cellWith - 2*StatusCellMargin, MAXFLOAT) font:StatusCellRetweetedContentFont];
    
    self.retweetedContentF = (CGRect){{retweetedContentX,retweetedContentY},retweetedContentSize};
    
    CGFloat retweetedH = CGRectGetMaxY(self.retweetedContentF) + StatusCellMargin;
    if (retweetedStatus.pic_urls.count) {
        CGFloat photoX = StatusCellMargin;
        CGFloat photoY = CGRectGetMaxY(self.retweetedContentF) + StatusCellChildMargin;
        CGFloat photoWH = 100;
        self.photoF = CGRectMake(photoX, photoY, photoWH, photoWH);
        retweetedH = CGRectGetMaxY(self.photoF) + StatusCellMargin;
    }
    
    self.originalF = CGRectMake(0, CGRectGetMaxY(self.originalF), cellWith, retweetedH);
}

@end
