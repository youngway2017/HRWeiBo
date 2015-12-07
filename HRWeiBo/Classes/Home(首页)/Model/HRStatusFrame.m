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

- (CGFloat)cellHeight {
    return self.originalF.size.height;
}


@end
