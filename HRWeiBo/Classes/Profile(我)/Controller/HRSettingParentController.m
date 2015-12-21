//
//  SettingParentController.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/21.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRSettingParentController.h"
#import "HRSwitchItem.h"
#import "HRSettingItemCell.h"
#import "HRSettingDataTool.h"
#import "HRArrowItem.h"
#import "HRSettingGroup.h"

@interface HRSettingParentController ()


@end

static NSString *const CellReuseIdentifier = @"CellReuseIdentifier";

@implementation HRSettingParentController

- (NSMutableArray *)settingGroups {
    if (_settingGroups == nil) {
        _settingGroups = [NSMutableArray array];
    }
    return _settingGroups;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)switchValueChange:(UISwitch *)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(HRSettingItemCell *)sender.superview];
    NSArray *items = [self.settingGroups[indexPath.section] items];
    HRSwitchItem *item = items[indexPath.row];
    [HRSettingDataTool setBool:sender.isOn forKey:item.title];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 在这里注册cell
    [self.tableView registerClass:[HRSettingItemCell class] forCellReuseIdentifier:CellReuseIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.settingGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.settingGroups[section] items].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = [self.settingGroups[indexPath.section] items];
    HRSettingItem *item = items[indexPath.row];
    // 获取cell
    HRSettingItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    
    cell.item = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = [self.settingGroups[indexPath.section] items];
    HRSettingItem *item = items[indexPath.row];
    if (item.option) {
        item.option(item);
        return;
    }
    
    if ([item isKindOfClass:[HRArrowItem class]]) {
        HRArrowItem *arrow = (HRArrowItem *)item;
        UIViewController *vc = [[arrow.descVC alloc] init];
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.settingGroups[section] header];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [self.settingGroups[section] footer];
}

@end