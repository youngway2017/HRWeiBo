//
//  Account.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/3.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>

@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, copy) NSString *expires_in;
@property (nonatomic, copy) NSString *remind_in;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, strong) NSDate *create_time;
@property (nonatomic, copy) NSString *nick_name;


+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
