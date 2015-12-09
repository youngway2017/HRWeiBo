//
//  HRStatusFrame.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/7.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

#define cellWith [UIScreen mainScreen].bounds.size.width
#define StatusCellChildMargin 5
#define StatusCellMargin 10
#define StatusCellScreenNameFont [UIFont systemFontOfSize:15]
#define StatusCellCreateTimeFont [UIFont systemFontOfSize:10]
#define StatusCellSourceFont [UIFont systemFontOfSize:10]
#define StatusCellContentFont [UIFont systemFontOfSize:12]
#define StatusCellRetweetedContentFont [UIFont systemFontOfSize:12]
@class HRStatus;

@interface HRStatusFrame : NSObject

@property (nonatomic, strong) HRStatus *status;

@property (nonatomic, assign) CGFloat cellHeight;

/**原创微博头像Frame 对应 HRUser profile_image_url*/
@property (nonatomic, assign) CGRect headIconF;

/**原创微博用户昵称Frame 对应 HRUser screen_name*/
@property (nonatomic, assign) CGRect screenNameF;

/**原创微博用户会员icon 对应 HRUser mbrank*/
@property (nonatomic, assign) CGRect vipF;

/**原创微博创建时间Frame 对应 HRStatus created_at*/
@property (nonatomic, assign) CGRect createdTimeF;

/**原创微博来源Frame 对应 HRStatus source*/
@property (nonatomic, assign) CGRect sourceF;

/**原创微博正文 对应 HRStatus text*/
@property (nonatomic, assign) CGRect contentF;

/**原创微博配图 对应 HRStatus pic_urls*/
@property (nonatomic, assign) CGRect photosViewF;

/**原创微博整体*/
@property (nonatomic, assign) CGRect originalF;

/*********************************************/

/**转发微博正文 对应 HRStatus text*/
@property (nonatomic, assign) CGRect retweetedContentF;

/**转发微博配图 对应 HRStatus pic_urls*/
@property (nonatomic, assign) CGRect retweetedPhotosViewF;

/**转发微博整体*/
@property (nonatomic, assign) CGRect retweetedF;

/*********************************************/

/**工具条*/
@property (nonatomic, assign) CGRect toolbarF;


- (CGFloat)cellHeight;

@end
