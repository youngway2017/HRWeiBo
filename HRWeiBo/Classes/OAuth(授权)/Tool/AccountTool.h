//
//  AccountTool.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/3.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface AccountTool : NSObject

+ (Account *)account;

+ (void)saveAccount:(Account *)account;

@end
