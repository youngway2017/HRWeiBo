//
//  NSString+Extension.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/7.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)boundingSizeWithSize:(CGSize)size font:(UIFont *)font {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:font forKey:NSFontAttributeName];
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

@end
