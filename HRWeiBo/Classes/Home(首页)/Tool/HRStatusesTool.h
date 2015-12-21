//
//  HRStatusesTool.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/21.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HRStatusesTool : NSObject

+ (void)saveStatuses:(NSArray *)statues;

+ (NSArray *)getStatusesWithParameter:(NSDictionary *)dict;

@end
