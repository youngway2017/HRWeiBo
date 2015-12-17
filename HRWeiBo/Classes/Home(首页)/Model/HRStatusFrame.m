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
#import "HRPhotosView.h"


@implementation HRStatusFrame

- (void)setStatus:(HRStatus *)status {
     _status = status;
    [self setOriginalStatus:status];
    
    if (status.retweeted_status) {
        [self setRetweetedStatus:status.retweeted_status];
        
    } else {
        self.cellHeight = CGRectGetMaxY(self.originalF) + 10;
        
    }
    
    [self setToolbar:status];
}

- (void)setOriginalStatus:(HRStatus *)status {
    HRUser *user = status.user;
    
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
    
    CGSize  contentSize = [status.AttributedText boundingRectWithSize:CGSizeMake(cellWith - 2*StatusCellMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    self.contentF = (CGRect){{contentX,contentY},contentSize};
    
    CGFloat originalH = CGRectGetMaxY(self.contentF) + StatusCellMargin;
    if (status.pic_urls.count) {
        CGFloat photosX = StatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(self.contentF) + StatusCellChildMargin;
        CGSize photosSize = [HRPhotosView photosViewSizeWithCount:(int)status.pic_urls.count];
        self.photosViewF = CGRectMake(photosX, photosY, photosSize.width, photosSize.height);
        originalH = CGRectGetMaxY(self.photosViewF) + StatusCellMargin;
    }
    
    self.originalF = CGRectMake(0, 0, cellWith, originalH);
    
}

- (void)setRetweetedStatus:(HRStatus *)retweetedStatus {
    HRUser *retweetedUser = retweetedStatus.user;

    //转发正文
    CGFloat retweetedContentX = StatusCellMargin;
    CGFloat retweetedContentY = StatusCellMargin;
    
    retweetedStatus.text = [NSString stringWithFormat:@"@%@:%@",retweetedUser.screen_name,retweetedStatus.text];
    CGSize  retweetedContentSize = [retweetedStatus.AttributedText boundingRectWithSize:CGSizeMake(cellWith - 2 * StatusCellMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;

    self.retweetedContentF = (CGRect){{retweetedContentX,retweetedContentY},retweetedContentSize};
    
    CGFloat retweetedH = CGRectGetMaxY(self.retweetedContentF) + StatusCellMargin;
    if (retweetedStatus.pic_urls.count) {
        CGFloat photosX = StatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(self.retweetedContentF) + StatusCellChildMargin;
        CGSize photosSize = [HRPhotosView photosViewSizeWithCount:(int)retweetedStatus.pic_urls.count];
        self.retweetedPhotosViewF = CGRectMake(photosX, photosY, photosSize.width, photosSize.height);
        retweetedH = CGRectGetMaxY(self.retweetedPhotosViewF) + StatusCellMargin;
    }
    
    self.retweetedF = CGRectMake(0, CGRectGetMaxY(self.originalF), cellWith, retweetedH);
    
    
}

- (void)setToolbar:(HRStatus *)status {

    
    CGFloat toolbarX = 0;
    CGFloat toolbarY = 0;
    CGFloat toolbarW = cellWith;
    CGFloat toolbarH = 35;
    
    if (status.retweeted_status) {
        toolbarY = CGRectGetMaxY(self.retweetedF);
    } else {
        toolbarY = CGRectGetMaxY(self.originalF);
    }
    
    self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    self.cellHeight = CGRectGetMaxY(self.toolbarF) + 10;
}

@end
