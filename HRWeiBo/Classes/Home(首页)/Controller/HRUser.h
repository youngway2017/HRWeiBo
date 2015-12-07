//
//  User.h
//  HRWeiBo
//
//  Created by yangwei on 15/12/5.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRUser : NSObject

/**id字符串*/
@property (nonatomic, copy) NSString *idstr;

/**昵称*/
@property (nonatomic, copy) NSString *screen_name;

/**头像url*/
@property (nonatomic, copy) NSString *profile_image_url;

/**vip类型*/
@property (nonatomic, copy) NSString *mbtype;

/**vip等级*/
@property (nonatomic, copy) NSString *mbrank;

@property (nonatomic, assign,getter=isVip) BOOL isVip;

@end
