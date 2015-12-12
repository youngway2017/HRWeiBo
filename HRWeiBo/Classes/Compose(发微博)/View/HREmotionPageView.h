//
//  HREmotionPageView.h
//  HRWeiBo
//
//  Created by yangwei on 15/12/12.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#define HREmotionMargin 10
#define HREmotionMaxCountCols 7
#define HREmotionMaxCountRows 3
#define HREmotionMaxCountPerPage ((HREmotionMaxCountCols * HREmotionMaxCountRows) - 1)

@interface HREmotionPageView : UIView

@property (nonatomic, strong) NSArray *emotions;


@end
