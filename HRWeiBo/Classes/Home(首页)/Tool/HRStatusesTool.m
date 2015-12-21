//
//  HRStatusesTool.m
//  HRWeiBo
//
//  Created by Yangwei on 15/12/21.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRStatusesTool.h"
#import "FMDB.h"

@implementation HRStatusesTool


static FMDatabase *_hrdb;
+ (void)initialize {
    NSString *dbFileName = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"hrweibo.db"];
    _hrdb = [FMDatabase databaseWithPath:dbFileName];
    
    if(![_hrdb open]) {
        HRLog(@"数据库打开失败");
    }
    
    NSString *sql = @"create table if not exists statuses (id integer primary key autoincrement, status text,idstr text);";
    
    [_hrdb executeUpdate:sql];
}

+ (void)saveStatuses:(NSArray *)statues {
    NSString *insert;
    for(int i = 0;i < statues.count;i++) {
        NSData *dataStatus =  [NSKeyedArchiver archivedDataWithRootObject:statues[i]];
        insert = @"insert into statuses (status,idstr) values (%@,%@);";
        [_hrdb executeUpdateWithFormat:insert,dataStatus,statues[i][@"idstr"]];
    }
    
}

+ (NSArray *)getStatusesWithParameter:(NSDictionary *)dict {
    NSMutableArray *statuses = [NSMutableArray array];
    NSString *query = nil;
    if(dict[@"since_id"]) {
        query = [NSString stringWithFormat:@"select * from statuses where idstr > %@ order by idstr desc limit 20;",dict[@"since_id"]];
    } else if(dict[@"max_id"] ) {
        query = [NSString stringWithFormat:@"select * from statuses where idstr < %@ order by idstr desc limit 20;",dict[@"max_id"]];
    } else {
        query = @"select * from statuses order by idstr desc limit 20";
    }
    
    FMResultSet *result = [_hrdb executeQuery:query];

    while (result.next) {
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:[result dataForColumn:@"status"]];
        [statuses addObject:dict];
    }
    return statuses;
}

//




@end
