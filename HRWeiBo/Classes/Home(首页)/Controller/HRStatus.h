//
//  Status.h
//  HRWeiBo
//
//  Created by yangwei on 15/12/5.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRUser.h"

@interface HRStatus : NSObject

/**id字符串*/
@property (nonatomic, copy) NSString *idstr;

/**创建时间*/
@property (nonatomic, copy) NSString *created_at;

/**来自*/
@property (nonatomic, copy) NSString *source;

/**内容*/
@property (nonatomic, copy) NSString *text;

/**用户*/
@property (nonatomic, strong) HRUser *user;

/**原创配图*/
@property (nonatomic, strong) NSArray *pic_urls;

/**转发微博*/
@property (nonatomic, strong) HRStatus *retweeted_status;



@end
