//
//  AccountTool.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/3.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "AccountTool.h"

@implementation AccountTool

+ (NSString *)path {
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return [filePath stringByAppendingPathComponent:@"account.data"];
}

+ (void)saveAccount:(HRAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:[self path]];
}

+ (HRAccount *)account {
    HRAccount *account = (HRAccount *)[NSKeyedUnarchiver unarchiveObjectWithFile:[self path]];
    long long expires_in = [account.expires_in longLongValue];
    NSDate *createTime = account.create_time;

    NSDate *expiresDate = [createTime dateByAddingTimeInterval:expires_in];
    NSDate *now = [NSDate date];
    NSComparisonResult result= [expiresDate compare:now];

    if (result != NSOrderedDescending) {
        return nil;
    }
    return account;
}

@end
