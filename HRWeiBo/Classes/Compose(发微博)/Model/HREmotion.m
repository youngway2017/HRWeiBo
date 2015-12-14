//
//  HREmotion.m
//  HRWeiBo
//
//  Created by yangwei on 15/12/12.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HREmotion.h"
#import "MJExtension.h"

@implementation HREmotion

- (void)encodeWithCoder:(NSCoder *)encoder {
//    [encoder encodeObject:self.code forKey:@""];
//    [encoder encodeObject:self.chs forKey:@"chs"];
//    [encoder encodeObject:self.png forKey:@"png"];
    [self mj_encode:encoder];
}

- (nullable instancetype)initWithCoder:(NSCoder *)decoder {
//    self.code = [decoder decodeObjectForKey:@"code"];
//    self.chs = [decoder decodeObjectForKey:@"chs"];
//    self.png = [decoder decodeObjectForKey:@"png"];
    [self mj_decode:decoder];
    return self;
    
}



- (BOOL)isEqual:(HREmotion *)other {
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];
}

@end
