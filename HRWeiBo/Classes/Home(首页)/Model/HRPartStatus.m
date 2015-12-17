//
//  HRPartStatus.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/17.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRPartStatus.h"

@implementation HRPartStatus

- (NSString *)description {
    return [NSString stringWithFormat:@"text=%@,range=%@,type=%d,showRange=%@",self.text,NSStringFromRange(self.range),self.partStatusType,NSStringFromRange(self.showRange)];
}

@end
