//
//  SettingItemCell.m
//  网易彩票
//
//  Created by yangwei on 15/11/21.
//  Copyright © 2015年 yangwei. All rights reserved.
//

#import "HRSettingItemCell.h"
#import "HRSettingItem.h"
#import "HRSwitchItem.h"
#import "HRLabelItem.h"
#import "HRSettingDataTool.h"
#import "HRArrowItem.h"

@interface HRSettingItemCell()

@end

@implementation HRSettingItemCell

#pragma mark - 重写
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}
//56558e2167e58e53ca001943
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}


#pragma mark - Setters
- (void)setItem:(HRSettingItem *)item {
    _item = item;
    self.textLabel.text = item.title;
    if (item.icon.length) {
        self.imageView.image = [UIImage imageNamed:item.icon];
    }

    if(item.subTitle.length) {
        self.detailTextLabel.text = item.subTitle;
    }
    
    
    
    if ([item isKindOfClass:[HRArrowItem class]]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if ([item isKindOfClass:[HRSwitchItem class]]) {
        HRSwitchItem *sItem = (HRSwitchItem *)item;
        [self.switchBtn addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
        [self.switchBtn setOn:[HRSettingDataTool boolForKey:sItem.title] animated:YES];
        self.accessoryView = _switchBtn;
        
    }
    
    if ([item isKindOfClass:[HRLabelItem class]]) {
        self.accessoryView = self.label;
        HRLabelItem *labelItem = (HRLabelItem *)item;
        self.label.text = labelItem.label;
    }
}

- (void)switchClick:(UISwitch *)sender {
    HRSwitchItem *sItem = (HRSwitchItem *)self.item;
    if(sItem.switchBlock) {
        sItem.switchBlock(sender);
    }
}

#pragma mark - 懒加载
- (UISwitch *)switchBtn {
    if (_switchBtn == nil) {
        _switchBtn = [[UISwitch alloc] init];
    }
    return _switchBtn;
}

- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.bounds = CGRectMake(0, 0, 100, 44);
        _label.textColor = [UIColor redColor];
        _label.textAlignment = NSTextAlignmentRight;
    }
    return _label;
}

@end
