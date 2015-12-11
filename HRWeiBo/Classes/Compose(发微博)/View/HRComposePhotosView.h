//
//  HRComposePhotosView.h
//  HRWeiBo
//
//  Created by Yangwei on 15/12/11.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRComposePhotosView : UIView

@property (nonatomic, strong,readonly) NSArray *photos;

- (void)addImage:(UIImage *)image;

@end
