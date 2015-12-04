//
//  Account.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/3.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "Account.h"

@implementation Account

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    Account *account = [[Account alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.remind_in = dict[@"remind_in"];
    account.uid = dict[@"uid"];
    account.create_time = [NSDate date];
    
    return account;
}


- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.access_token forKey:@"access_token"];
    [coder encodeObject:self.expires_in forKey:@"expires_in"];
    [coder encodeObject:self.remind_in forKey:@"remind_in"];
    [coder encodeObject:self.uid forKey:@"uid"];
    [coder encodeObject:self.create_time forKey:@"create_time"];
    [coder encodeObject:self.nick_name forKey:@"nick_name"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self.access_token = [decoder decodeObjectForKey:@"access_token"];
    self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
    self.remind_in = [decoder decodeObjectForKey:@"remind_in"];
    self.uid = [decoder decodeObjectForKey:@"uid"];
    self.create_time = [decoder decodeObjectForKey:@"create_time"];
    self.nick_name = [decoder decodeObjectForKey:@"nick_name"];
    
    return self;
}


@end
