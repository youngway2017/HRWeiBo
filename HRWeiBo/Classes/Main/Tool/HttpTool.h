//
//  HttpTool.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/17.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject

+ (void)get:(NSString *)URLString parameters:(id)parameters success:(void (^)(id json)) success failure:(void (^) (NSError *error))failure;

+ (void)post:(NSString *)URLString parameters:(id)parameters success:(void (^) (id json))success failure:(void (^) (NSError *error)) failure;

@end
