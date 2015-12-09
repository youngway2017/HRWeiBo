//
//  HRPhotosView.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/9.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRPhotosView : UIView
#define photoWH 80
#define photoMargin 6

@property (nonatomic, strong) NSArray *photos;

+ (CGSize)photosViewSizeWithCount:(int) count;

@end
