//
//  HRHomeViewController.m
//  HRWeibo
//
//  Created by yangwei on 15/11/29.
//  Copyright © 2015年 yangwei. All rights reserved.
//

#import "HRHomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "HRDropdownMenu.h"
#import "HRTitleMenuController.h"
#import "TitleButton.h"
#import "AFNetworking.h"
#import "AccountTool.h"


@interface HRHomeViewController ()<HRDropdownMenuDelegate>

@property (nonatomic, strong) HRDropdownMenu *menu;
@property (nonatomic, strong) TitleButton *btnTitle;

@end

@implementation HRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItem];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    Account *account = [AccountTool account];
    
    if (!account) {
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:account.access_token forKey:@"access_token" ];
    [dict setObject:account.uid forKey:@"uid"];
    
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary *userInfo) {
        NSLog(@"JSON: %@", userInfo);
        account.nick_name = userInfo[@"screen_name"];
        TitleButton *btn = (TitleButton *)self.navigationItem.titleView;
        [btn setTitle:account.nick_name forState:UIControlStateNormal];
        [AccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];

}

- (void)setNavigationItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self Image:@"navigationbar_friendsearch" imageHighlighted:@"navigationbar_friendsearch_highlighted"  action:@selector(btnLeftClick:)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self Image:@"navigationbar_pop" imageHighlighted:@"navigationbar_pop_highlighted"  action:@selector(btnRightClick:)];
    Account *account = [AccountTool account];
    TitleButton *btnTitle = [[TitleButton alloc] init];
    [btnTitle setTitle:account.nick_name?account.nick_name:@"首页" forState:UIControlStateNormal];
    [btnTitle addTarget:self action:@selector(btnTitleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btnTitle;
    _btnTitle = btnTitle;
}

- (HRDropdownMenu *)menu {
    if(_menu == nil) {
        _menu = [HRDropdownMenu menu];
    }
    return _menu;
}
- (void)btnLeftClick:(UIButton *)sender {
//    [self popViewControllerAnimated:YES];
}

- (void)btnRightClick:(UIButton *)sender {
//    [self popToRootViewControllerAnimated:YES];
}

- (void)btnTitleClick:(UIButton *)sender {
    HRLog(@"xx");
//    UIButton *btn = [[UIButton alloc] init];
//    btn.size = CGSizeMake(200, 200);
//    btn.backgroundColor = [UIColor redColor];
//    self.menu.contentView = btn;

    HRTitleMenuController *menuController = [[HRTitleMenuController alloc] init];
    menuController.view.width = 200;
    menuController.view.height = 44*3;
    self.menu.contentController = menuController;
    self.menu.delegate = self;
    [self.view addSubview:self.menu];
    [self.menu showMenuFrom:sender];

    sender.selected = !sender.isSelected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dropdownMenuDiddismiss:(HRDropdownMenu *)menu {
    _btnTitle.selected = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
