//
//  HRStatusTextView.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/18.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRStatusTextView.h"
#import "HRPartStatus.h"

@implementation HRStatusTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.editable = NO;
        self.scrollEnabled = NO;
        self.textContainer.lineFragmentPadding = 0;
        self.textContainerInset = UIEdgeInsetsZero;
        self.font = [UIFont systemFontOfSize:18];
        
    }
    return self;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    NSArray *array = [self.attributedText attribute:@"StatusParts" atIndex:0 effectiveRange:nil];
    for (HRPartStatus *part in array) {
        switch (part.partStatusType) {
            case HRPartStatusTypeNormal: {
                break;
            }
            case HRPartStatusTypeAt: {
                if([self isPointInPartStatus:touchPoint partStatus:part]) {
                    [self setPartStatus:part color:HRRgba(5, 86, 253, 0.6)];
                }
                break;
            }
            case HRPartStatusTypeTopic: {
                if([self isPointInPartStatus:touchPoint partStatus:part]) {
                    [self setPartStatus:part color:HRRgba(5, 86, 253, 0.8)];
                }
                break;
            }
            case HRPartStatusTypeEmotion: {
                break;
            }
            case HRPartStatusTypeURL: {
                if([self isPointInPartStatus:touchPoint partStatus:part]) {
                    [self setPartStatus:part color:HRRgba(253, 113, 3, 1)];
                }

                break;
            }
            default:
                break;
        }

    }
//    HRLog(@"%@",array);
}

- (BOOL)isPointInPartStatus:(CGPoint)point partStatus:(HRPartStatus *)part {
    self.selectedRange = part.showRange;
    NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
    self.selectedRange = NSMakeRange(0, 0);
    for (UITextSelectionRect *selectionRect in rects) {
        if(selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) {
            continue;
        }
        if(CGRectContainsPoint(selectionRect.rect, point)) {
            return YES;
        }
    }
    return NO;
}

- (void)setPartStatus:(HRPartStatus *)part color:(UIColor *)color {
    self.selectedRange = part.showRange;
    NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
    self.selectedRange = NSMakeRange(0, 0);
    
    for (UITextSelectionRect *selectionRect in rects) {
        if(selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) {
            continue;
        }
        UIView *view = [[UIView alloc] init];
        view.tag = 100;
        view.backgroundColor = color;
        HRLog(@"selectionRect.rect=%@",NSStringFromCGRect(selectionRect.rect));
        view.frame = selectionRect.rect;
        [self insertSubview:view atIndex:0];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self touchesCancelled:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (UIView *view in self.subviews) {
            if(view.tag == 100) {
                [view removeFromSuperview];
                HRLog(@"touchesEnded");
            }
        }
    });

}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSArray *array = [self.attributedText attribute:@"StatusParts" atIndex:0 effectiveRange:nil];
    for (HRPartStatus *part in array) {
        switch (part.partStatusType) {
            case HRPartStatusTypeAt:
            case HRPartStatusTypeTopic:
            case HRPartStatusTypeURL: {
                if([self isPointInPartStatus:point partStatus:part]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

@end
