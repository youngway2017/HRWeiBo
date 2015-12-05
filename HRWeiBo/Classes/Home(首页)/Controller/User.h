//
//  User.h
//  HRWeiBo
//
//  Created by yangwei on 15/12/5.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

/*id字符串*/
@property (nonatomic, copy) NSString *idstr;

/*昵称*/
@property (nonatomic, copy) NSString *screen_name;

/*头像url*/
@property (nonatomic, copy) NSString *profile_image_url;

//"id": 2803301701,
//"idstr": "2803301701",
//"class": 1,
//"screen_name": "人民日报",
//"name": "人民日报",
//"province": "11",
//"city": "1000",
//"location": "北京",
//"description": "人民日报法人微博。参与、沟通、记录时代。",
//"url": "",
//"profile_image_url": "http://tp2.sinaimg.cn/2803301701/50/40094657657/1",
//"cover_image": "http://ww4.sinaimg.cn/crop.0.0.920.300/a716fd45jw1ewb3bphum0j20pk08cn25.jpg",
//"cover_image_phone": "http://ww2.sinaimg.cn/crop.0.0.0.0/a716fd45jw1ewb3acsa9kj20yi0yi4b7.jpg",
//"profile_url": "rmrb",
//"domain": "rmrb",
//"weihao": "",
//"gender": "m",

@end
