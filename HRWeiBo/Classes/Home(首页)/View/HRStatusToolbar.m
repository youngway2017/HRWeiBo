//
//  HRStatusToolbar.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/8.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRStatusToolbar.h"
#import "HRStatus.h"

#define HRStatusToolbarFont [UIFont systemFontOfSize:12]



@interface HRStatusToolbar()

@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) NSMutableArray *dividerArray;

@property (nonatomic, strong) UIButton *repostsBtn;

@property (nonatomic, strong) UIButton *commentsBtn;

@property (nonatomic, strong) UIButton *attitudesBtn;

@end

@implementation HRStatusToolbar

+ (instancetype)toolbar {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        
        self.repostsBtn = [self addButtonWithTitle:@"转发" imageName:@"timeline_icon_retweet"];
        self.commentsBtn = [self addButtonWithTitle:@"评论" imageName:@"timeline_icon_comment"];
        self.attitudesBtn = [self addButtonWithTitle:@"赞" imageName:@"timeline_icon_unlike"];
        
        [self addDividerLine];
        
    }
    return self;
}

- (void)setStatus:(HRStatus *)status {
    
    [self setBtnCount:status.reposts_count sender:self.repostsBtn title:@"转发"];
    [self setBtnCount:status.comments_count sender:self.commentsBtn title:@"评论"];
    [self setBtnCount:status.attitudes_count sender:self.attitudesBtn title:@"赞"];
}

- (void)setBtnCount:(int)count sender:(UIButton *)sender title:(NSString *)title {
    if(count > 0) {
        if(count < 10000) {
            title = [NSString stringWithFormat:@"%d",count];
        } else {
            double num = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",num];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
        
    [sender setTitle:title forState:UIControlStateNormal];

}

- (NSMutableArray *)btnArray {
    if(_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (NSMutableArray *)dividerArray {
    if(_dividerArray == nil) {
        _dividerArray = [NSMutableArray array];
    }
    return _dividerArray;

}

- (UIButton *)addButtonWithTitle:(NSString *)title imageName:(NSString *)imageName {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    btn.titleLabel.font = HRStatusToolbarFont;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.btnArray addObject:btn];
    [self addSubview:btn];
    return btn;
}

- (void)addDividerLine {
    for (int i=0; i<2; i++) {
        UIView *divider = [[UIView alloc] init];
        divider.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self.dividerArray addObject:divider];
        [self addSubview:divider];
    }
}

- (void)layoutSubviews {
    
    CGFloat perW = self.width / self.btnArray.count;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = perW;
    CGFloat btnH = self.height;
    
    for (int i = 0; i < self.btnArray.count;  i++) {
        UIButton *btn = (UIButton *)self.btnArray[i];
        btnX = i * perW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    CGFloat dividerX = 0;
    CGFloat dividerY = 0;
    CGFloat dividerW = 1;
    CGFloat dividerH = self.height;
    for (int i = 0; i < self.dividerArray.count;  i++) {
        UIView *divider = (UIView *)self.dividerArray[i];
        dividerX = (i + 1) * perW -1;
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}

@end
