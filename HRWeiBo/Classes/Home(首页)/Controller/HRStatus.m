//
//  Status.m
//  HRWeiBo
//
//  Created by yangwei on 15/12/5.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRStatus.h"
#import "HRPhoto.h"
#import "MJExtension.h"

@implementation HRStatus

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"pic_urls" : [HRPhoto class]};
}

@end
