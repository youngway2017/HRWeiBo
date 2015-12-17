//
//  NewFeatureTool.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/2.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "NewFeatureTool.h"

@implementation NewFeatureTool

+ (BOOL)isShowNewFeature {
    
    NSDictionary *dict  = [NSBundle mainBundle].infoDictionary;
   
    NSString *currentVersion = dict[@"CFBundleVersion"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:@"CFBundleVersion"];
    if((!lastVersion) || ([currentVersion intValue] > [lastVersion intValue])) {
        [defaults setObject:dict[@"CFBundleVersion"] forKey:@"CFBundleVersion"];
        [defaults synchronize];
        return YES;
    }
    
    return NO;
}

@end
