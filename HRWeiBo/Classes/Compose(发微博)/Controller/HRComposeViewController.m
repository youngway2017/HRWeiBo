//
//  HRComposeViewController.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/10.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRComposeViewController.h"
#import "HRPlaceholderTextView.h"
#import "AccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "HRStatusWindow.h"
#import "HRComposeKeyboardToolBar.h"
#import "HRComposePhotosView.h"
#import "MBProgressHUD+MJ.h"
#import "HREmotionKeyboard.h"
#import "HREmotion.h"
#import "NSString+Emoji.h"
#import "HREmotionAttachment.h"
#import "HREmotionTextView.h"
#import "HRConst.h"
#import "HttpTool.h"

@interface HRComposeViewController ()<HRComposeKeyboardToolBarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) HREmotionTextView *textView;
@property (nonatomic, strong) HRComposeKeyboardToolBar *keyboardToolBar;
@property (nonatomic, strong) HRComposePhotosView *photosView;
@property (nonatomic, strong) HREmotionKeyboard *emotionKeyboard;
@property (nonatomic, strong) HRAccount *account;
@property (nonatomic, assign) BOOL isSwitchingKeyboard;



@end

@implementation HRComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItem];
    
    [self setTextView];
    [self setPhotosView];
    self.keyboardToolBar.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (HRComposeKeyboardToolBar *)keyboardToolBar {
    if (_keyboardToolBar == nil) {
        _keyboardToolBar = [[HRComposeKeyboardToolBar alloc] init];
        _keyboardToolBar.width = self.view.width;
        _keyboardToolBar.height = 44;
        _keyboardToolBar.x = 0;
        _keyboardToolBar.y = self.view.height - _keyboardToolBar.height;
        
        [self.view addSubview:_keyboardToolBar];
    }
    return _keyboardToolBar;
}

- (HREmotionKeyboard *)emotionKeyboard {
    if (_emotionKeyboard == nil) {
        _emotionKeyboard = [[HREmotionKeyboard alloc] init];
        _emotionKeyboard.width = self.view.width;
        _emotionKeyboard.height = 216;
        _emotionKeyboard.x = 0;
    }
    return _emotionKeyboard;
}

- (HRAccount *)account {
    return [AccountTool account];
}

#pragma mark - 设置导航栏
- (void)setNavigationItem {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    
    NSString *name = self.account ? self.account.nick_name : @"";
    NSString *title = @"发微博";
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.bounds = CGRectMake(0, 0, 200, 44);
    NSString *content = [NSString stringWithFormat:@"%@\n%@",title,name];
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:content];
    NSDictionary *dictTitle = @{NSForegroundColorAttributeName:[UIColor blackColor],
                           NSFontAttributeName:[UIFont boldSystemFontOfSize:14]};
    [attrs setAttributes:dictTitle range:[content rangeOfString:title]];
    
    NSDictionary *dictName = @{NSForegroundColorAttributeName:[UIColor blackColor],
                           NSFontAttributeName:[UIFont systemFontOfSize:13]};
    [attrs setAttributes:dictName range:[content rangeOfString:name]];
    
    [titleLabel setAttributedText:attrs];
    self.navigationItem.titleView = titleLabel;
}

- (void)setTextView {
    self.textView = [[HREmotionTextView alloc] init];
    self.textView.font = [UIFont systemFontOfSize:18];
    self.textView.frame = self.view.bounds;
    self.textView.placeholder = @"分享新鲜事...";
    self.textView.alwaysBounceVertical = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self.textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionButtonDidSelect:) name:HREmotionButtonDidSelectNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteButtonDidSelect) name:HREmotionButtonDidDeleteNotification object:nil];
    
    
    [self.view addSubview:self.textView];
}

#pragma mark - textView Notification

- (void)textDidChange {
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

- (void)deleteButtonDidSelect {
    [self.textView deleteBackward];
}

- (void)emotionButtonDidSelect:(NSNotification *)noti {
    NSDictionary *userinfo = noti.userInfo;
    HREmotion *emotion = (HREmotion *)userinfo[HREmotionButtonDidSelectNotificationKey];
    
    if (emotion.code) {
        [self.textView insertText:emotion.code.emoji];
    } else if (emotion.png) {
        [self.textView insertEmotion:emotion settingBlock:^(NSMutableAttributedString *content) {
            NSDictionary *attrDict = @{NSFontAttributeName:self.textView.font,NSBaselineOffsetAttributeName:@-3};
            [content addAttributes:attrDict range:NSMakeRange(0,content.length)];
        }];
    }
    
}

- (void)setPhotosView{
    self.photosView = [[HRComposePhotosView alloc] init];
    self.photosView.frame = CGRectMake(0, 150, self.view.width, 200);
    [self.view addSubview:self.photosView];
}


#pragma mark - 导航栏事件

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {
    if(self.photosView.photos.count) {
        [self sendComposeWithImage];
    } else {
        [self sendComposeWithoutImage];
    }
}

- (void)sendComposeWithoutImage {
//        https://api.weibo.com/2/statuses/update.json发送微博
    HRStatusWindow *window = [[HRStatusWindow alloc] init];
    window.message = @"正在发送...";
    [window show];

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.account.access_token forKey:@"access_token" ];
    [dict setObject:[self.textView getFullText] forKey:@"status"];
    
    [HttpTool post:@"https://api.weibo.com/2/statuses/update.json" parameters:dict success:^(id json) {
        NSLog(@"JSON: %@", json);
        [window dismiss];
        [MBProgressHUD showSuccess:@"发送成功"];
        [self dismissViewControllerAnimated:YES completion:nil];

    } failure:^(NSError *error) {
        [window dismiss];
        [MBProgressHUD showError:@"发送失败"];
        NSLog(@"Error: %@", error);

    }];
}

- (void)sendComposeWithImage {
    UIImage *image = (UIImage *)self.photosView.photos[0];
    
    NSData *data = UIImagePNGRepresentation(image);
    NSLog(@"%ld",data.length);
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.account.access_token forKey:@"access_token" ];
    [dict setObject:[self.textView getFullText] forKey:@"status"];
//    [dict setObject:data forKey:@"pic"];
    
    [HttpTool post:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:dict success:^(id json) {
        NSLog(@"JSON: %@", json);
        [MBProgressHUD showSuccess:@"发送成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
        [MBProgressHUD showError:@"发送失败"];
    }];
}


- (void)keyboardWillChange:(NSNotification *)info {
    if (self.isSwitchingKeyboard) return;
    
    NSDictionary *dict = info.userInfo;
    CGRect rect = [(NSValue *)dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double durationTime = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:durationTime animations:^{
        self.keyboardToolBar.y = rect.origin.y - self.keyboardToolBar.height;
    }];
    
}

#pragma mark - 键盘toolbar按钮点击代理

- (void)composeKeyboardToolBar:(HRComposeKeyboardToolBar *)toolBar didClickButton:(HRComposeKeyboardToolBarButtonType)buttonType {
    switch (buttonType) {
        case HRComposeKeyboardToolBarPicture: {
            UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            ipc.delegate = self;
            [self presentViewController:ipc animated:YES completion:nil];
            HRLog(@"picture");
            break;
        }
            
        case HRComposeKeyboardToolBarCamera:
            HRLog(@"camera");
            break;
        case HRComposeKeyboardToolBarMention:
            HRLog(@"Mention");
            break;
        case HRComposeKeyboardToolBarTrend:
            HRLog(@"#");
            break;
        case HRComposeKeyboardToolBarEmoticon: {
            HRLog(@"Emoticon表情");
            toolBar.showEmotion = !toolBar.isShowEmotion;
            self.isSwitchingKeyboard = YES;
            if (self.textView.inputView) {
                self.textView.inputView = nil;
            } else  {
                self.textView.inputView = self.emotionKeyboard;
            }
            [UIView animateWithDuration:0.25 animations:^{
                [self.view endEditing:YES];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.25 animations:^{
                    
                    [self.textView becomeFirstResponder];
                }];
            }];
            self.isSwitchingKeyboard = NO;
            
            break;
        }
        default:
            break;
    }
}

#pragma mark -UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    HRLog(@"%@",info);
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = (UIImage *)info[UIImagePickerControllerOriginalImage];
    [self.photosView addImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
