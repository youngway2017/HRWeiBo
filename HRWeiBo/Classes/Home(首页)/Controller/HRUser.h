//
//  User.h
//  HRWeiBo
//
//  Created by yangwei on 15/12/5.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HRUserVerifiedTypeNone = -1, // 没有任何认证
    
    HRUserVerifiedTypePersonal = 0,  // 个人认证
    
    HRUserVerifiedTypeOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    HRUserVerifiedTypeOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    HRUserVerifiedTypeOrgWebsite = 5, // 网站官方：猫扑
    
    HWUserVerifiedTypeDaren = 220 // 微博达人
    
} HRUserVerifiedType;

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


@property (nonatomic, assign) HRUserVerifiedType verified_type;

@end
