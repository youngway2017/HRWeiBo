//
//  Status.h
//  HRWeiBo
//
//  Created by yangwei on 15/12/5.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRUser.h"

@interface HRStatus : NSObject

/*id字符串*/
@property (nonatomic, copy) NSString *idstr;

/*创建时间*/
@property (nonatomic, copy) NSString *created_at;

/*内容*/
@property (nonatomic, copy) NSString *text;

/*用户*/
@property (nonatomic, strong) HRUser *user;
//
//"created_at": "Sat Dec 05 11:17:17 +0800 2015",
//"id": 3916649357300690,
//"mid": "3916649357300690",
//"idstr": "3916649357300690",
//"text": "【冬天，坐火车去看林海雪原[雪]】①牙林线：可充分领略大兴安岭的北国风光；②哈大高铁：途经东北3省；③滨洲铁路-满洲里：保留有老车站以及多座俄式建筑；④南疆铁路：沿天山山麓一直向西，有荒漠戈壁、草原雪山；⑤富西铁路：是中国最北端的铁路线，经过我国最北端的漠河县。",
//"source_allowclick": 0,
//"source_type": 1,
//"source": "<a href=\"http://weibo.com/\" rel=\"nofollow\">微博 weibo.com</a>",
//"favorited": false,
//"truncated": false,
//"in_reply_to_status_id": "",
//"in_reply_to_user_id": "",
//"in_reply_to_screen_name": "",
//"pic_urls": [ ],
//"geo": null,
//"user": {},

@end
