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
#import "HRTitleButton.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "MJExtension.h"
#import "HRUser.h"
#import "HRStatus.h"
#import "UIImageView+WebCache.h"
#import "HRLoadMoreFooter.h"
#import "HRStatusCell.h"
#import "HRStatusFrame.h"

@interface HRHomeViewController ()<HRDropdownMenuDelegate>

@property (nonatomic, strong) HRDropdownMenu *menu;
@property (nonatomic, strong) HRTitleButton *btnTitle;
@property (nonatomic, strong) NSMutableArray *statusFrames;


@end

static NSString *const cellReuseIdentifier = @"StatusCellIdentifier";
@implementation HRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = HRRgba(230, 230, 230, 0.9);
        
    [self setNavigationItem];
    
    [self.tableView registerClass:[HRStatusCell class] forCellReuseIdentifier:cellReuseIdentifier];
    [self getNickName];
    
    [self setupDownRefresh];
    
    [self setupUpRefresh];
    
    [self setupUnreadCount];
    
}

- (void)setupUnreadCount {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(getUnreadStatusCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)setupUpRefresh {
    HRLoadMoreFooter *footer = [HRLoadMoreFooter footerView];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

- (void)setupDownRefresh {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl beginRefreshing];
    [self refreshData:self.refreshControl];
}

- (void)refreshData:(UIRefreshControl *)sender{
    [self getNewStatues];
}

- (NSMutableArray *)statusFrames {
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)getUnreadStatusCount {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    HRAccount *account = [AccountTool account];
    
    if (!account) {
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:account.access_token forKey:@"access_token" ];
    [dict setObject:account.uid forKey:@"uid"];
    HRLog(@"-----getUnreadStatusCount------");
    [manager GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary *userInfo) {
        NSLog(@"JSON: %@", userInfo);
        
        NSString *count = [userInfo[@"status"] description];
        if ([count isEqualToString:@"0"]) {
            [[self navigationController] tabBarItem].badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else {
            [[self navigationController] tabBarItem].badgeValue = count;
            
            [UIApplication sharedApplication].applicationIconBadgeNumber = [count integerValue];
        }
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

//获取昵称
- (void)getNickName {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    HRAccount *account = [AccountTool account];
    
    if (!account) {
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:account.access_token forKey:@"access_token" ];
    [dict setObject:account.uid forKey:@"uid"];
    
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary *userInfo) {
        NSLog(@"JSON: %@", userInfo);
        account.nick_name = userInfo[@"screen_name"];
        HRTitleButton *btn = (HRTitleButton *)self.navigationItem.titleView;
        [btn setTitle:account.nick_name forState:UIControlStateNormal];
        [AccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}


/**
 *  获取当前登录用户及其所关注（授权）用户的最新微博
 *  access_token		string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *  since_id            int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *  max_id              int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *  count               int     单页返回的记录条数，最大不超过100，默认为20。
 */
- (void)getNewStatues {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    HRAccount *account = [AccountTool account];
    
    if (!account) {
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:account.access_token forKey:@"access_token" ];
    
    HRStatus *fristStatus = [[self.statusFrames firstObject] status];
    NSString *since_id = fristStatus.idstr ? fristStatus.idstr : @"0";
    [dict setObject:since_id forKey:@"since_id" ];
    
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary *userInfo) {
//        https://api.weibo.com/2/statuses/friends_timeline.json?access_token=2.00SZEWrBB8fKJD244ef9b3f80_w7Hq
        NSArray *statuses = [HRStatus mj_objectArrayWithKeyValuesArray:userInfo[@"statuses"]];
        
        NSMutableArray *statusFrames = [self statusFramesWithStatusArray:statuses];
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, statusFrames.count)];
        [self.statusFrames insertObjects:statusFrames atIndexes:indexSet];
        
        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        [self.refreshControl endRefreshing];
    }];
}
/**
 *  @param statuses statuses数组
 *
 *  @return statusFrames
 */
- (NSMutableArray *)statusFramesWithStatusArray:(NSArray *)statuses {
    NSMutableArray *statusFrames = [NSMutableArray array];
    for (HRStatus *status in statuses) {
        HRStatusFrame *statusFrame = [[HRStatusFrame alloc] init];
        statusFrame.status = status;
        [statusFrames addObject:statusFrame];
    }
    return statusFrames;
}


/**
 *  获取当前登录用户及其所关注（授权）用户的最新微博
 *  access_token		string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *  since_id            int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *  max_id              int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *  count               int     单页返回的记录条数，最大不超过100，默认为20。
 */
- (void)loadMoreStatues {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    HRAccount *account = [AccountTool account];
    
    if (!account) {
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:account.access_token forKey:@"access_token" ];
    
    HRStatus *lastStatus = [[self.statusFrames lastObject] status];

    long long maxID = [lastStatus.idstr ? lastStatus.idstr : @"0" longLongValue] - 1;
    NSString *max_id = [NSString stringWithFormat:@"%lld",maxID];
    [dict setObject:max_id forKey:@"max_id" ];
    
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary *userInfo) {
        
        
        NSArray *statuses = [HRStatus mj_objectArrayWithKeyValuesArray:userInfo[@"statuses"]];
        NSMutableArray *statusFrames = [self statusFramesWithStatusArray:statuses];
        [self.statusFrames addObjectsFromArray:statusFrames];
        
        [self showStatuesCount:(int)statusFrames.count];
        
        [self.tableView reloadData];
        self.tableView.tableFooterView.hidden = YES;
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        self.tableView.tableFooterView.hidden = YES;
    }];
}


- (void)showStatuesCount:(int)count {
    UILabel *showLabel = [[UILabel alloc] init];
    showLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    HRLog(@"%@",NSStringFromCGRect(showLabel.frame));
    
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.font = [UIFont systemFontOfSize:14];
    showLabel.textColor = [UIColor whiteColor];
    if (count <= 0) {
        showLabel.text = @"没有新的微博数据，请稍后再试";
    } else {
        showLabel.text = [NSString stringWithFormat:@"共有%d条新的微博数据",count];
    }
    CGFloat showLabelW = self.navigationController.view.width;
    CGFloat showLabelH = 35;
    showLabel.frame = CGRectMake(0, 64 - showLabelH, showLabelW, showLabelH);
    [self.navigationController.view insertSubview:showLabel belowSubview:self.navigationController.navigationBar];
    CGFloat duration = 1;
    [UIView animateWithDuration:duration animations:^{
        showLabel.transform = CGAffineTransformMakeTranslation(0, showLabelH);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:duration options:(UIViewAnimationOptionCurveLinear) animations:^{
            showLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [showLabel removeFromSuperview];
        }];
    }];
}

#pragma mark - 设置导航栏
- (void)setNavigationItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self Image:@"navigationbar_friendsearch" imageHighlighted:@"navigationbar_friendsearch_highlighted"  action:@selector(btnLeftClick:)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self Image:@"navigationbar_pop" imageHighlighted:@"navigationbar_pop_highlighted"  action:@selector(btnRightClick:)];
    HRAccount *account = [AccountTool account];
    HRTitleButton *btnTitle = [[HRTitleButton alloc] init];
    [btnTitle setTitle:account.nick_name?account.nick_name:@"首页" forState:UIControlStateNormal];
    [btnTitle addTarget:self action:@selector(btnTitleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btnTitle;
    _btnTitle = btnTitle;
}

#pragma mark - 导航栏事件
- (HRDropdownMenu *)menu {
    if(_menu == nil) {
        _menu = [HRDropdownMenu menu];
    }
    return _menu;
}

- (void)dropdownMenuDiddismiss:(HRDropdownMenu *)menu {
    _btnTitle.selected = NO;
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.statusFrames.count <= 0 || (self.tableView.tableFooterView.isHidden == NO)) {
        return;
    }
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeBottomY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= judgeBottomY) {
        HRLog(@"该显示了");
        self.tableView.tableFooterView.hidden = NO;
        [self loadMoreStatues];
    }
    
//    NSLog(@"self.tableView.frame=%@",NSStringFromCGRect(self.tableView.frame));
//    NSLog(@"self.tableView.bounds=%@",NSStringFromCGRect(self.tableView.bounds));
//    NSLog(@"scrollView.contentOffset.x=%f",scrollView.contentOffset.x);
//    NSLog(@"scrollView.contentOffset.y=%f",scrollView.contentOffset.y);
//    NSLog(@"scrollView.contentSize.width=%f",scrollView.contentSize.width);
//    NSLog(@"scrollView.contentSize.height=%f",scrollView.contentSize.height);
//    NSLog(@"scrollView.contentInset.left=%f",scrollView.contentInset.left);
//    NSLog(@"scrollView.contentInset.right=%f",scrollView.contentInset.right);
//    NSLog(@"scrollView.contentInset.top=%f",scrollView.contentInset.top);
//    NSLog(@"scrollView.contentInset.bottom=%f",scrollView.contentInset.bottom);
//    NSLog(@"scrollView.height=%f",scrollView.height);
//    NSLog(@"self.tableView.tableFooterView.height=%f",self.tableView.tableFooterView.height);
}

#pragma mark - 表格数据相关

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HRStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    HRStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    cell.statusFrame = statusFrame;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HRStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

@end
