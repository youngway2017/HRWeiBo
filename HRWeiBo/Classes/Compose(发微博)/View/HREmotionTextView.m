//
//  HREmotionTextView.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/14.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HREmotionTextView.h"
#import "HREmotionAttachment.h"
#import "HREmotion.h"
#import "NSString+Emoji.h"

@implementation HREmotionTextView


- (void)insertEmotion:(HREmotion *)emotion settingBlock:(void (^)(NSMutableAttributedString *content))settingBlock{
    HREmotionAttachment *emotionAtt = [[HREmotionAttachment alloc] init];
    emotionAtt.emotion = emotion;
    emotionAtt.bounds = CGRectMake(0, -4, self.font.lineHeight, self.font.lineHeight);
    NSAttributedString *att = [NSAttributedString attributedStringWithAttachment:emotionAtt];
    
    NSMutableAttributedString *contentAtt = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    [contentAtt replaceCharactersInRange:self.selectedRange withAttributedString:att];
    
    if(settingBlock) {
        settingBlock(contentAtt);
    }

    
    self.attributedText = contentAtt;
    [self setNeedsDisplay];
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];
}

- (NSString *)getFullText {
    NSMutableString *content = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        HREmotionAttachment *emotionAtt = (HREmotionAttachment *)attrs[@"NSAttachment"];
        if(emotionAtt.emotion.png) {
            [content appendString:emotionAtt.emotion.chs];
        } else if(emotionAtt.emotion.code) {
            [content appendString:emotionAtt.emotion.code.emoji];
        }
    }];
    return content;
}


@end
