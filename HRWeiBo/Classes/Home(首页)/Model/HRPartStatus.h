//
//  HRPartStatus.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/17.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HRPartStatusTypeNormal = 0,
    HRPartStatusTypeAt,
    HRPartStatusTypeTopic,
    HRPartStatusTypeEmotion,
    HRPartStatusTypeURL
}HRPartStatusType;

@interface HRPartStatus : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSRange range;
/**显示在界面的range*/
@property (nonatomic, assign) NSRange showRange;
@property (nonatomic, assign) HRPartStatusType partStatusType;
@end
