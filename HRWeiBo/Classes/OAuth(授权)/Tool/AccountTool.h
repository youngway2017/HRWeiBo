//
//  AccountTool.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/3.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRAccount.h"

@interface AccountTool : NSObject

+ (HRAccount *)account;

+ (void)saveAccount:(HRAccount *)account;

@end
