//
//  DataBaseManager.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "DataBaseManager.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "DataModel.h"

static DataBaseManager *_mainManager;
#define CREATEINDEX     @"SELECT serial FROM %@ WHERE %@;"
#define SELECTFROMTABLE @"SELECT * FROM %@ WHERE serial = ?;"
#define COUNTTABLEROW   @"SELECT COUNT(*) AS COUNT FROM %@ WHERE %@;"
#define RESULTCHECK     @"SELECT manswer FROM leaflevel WHERE serial = ?"
#define MAXSERIALNUM   @"SELECT MAX(serial) AS MAXNUM FROM %@;"

@interface DataBaseManager ()

@property (nonatomic,strong) FMDatabase *db;

@end

@implementation DataBaseManager


+ (instancetype)shareDataBaseManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_mainManager == nil) {
            _mainManager = [[DataBaseManager alloc] init];
            [_mainManager configureDataBase];
        }
    });
    return _mainManager;
}

- (void)configureDataBase
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"sqlite"];
    _db = [FMDatabase databaseWithPath:path];
}

- (void)selectFromTable:(NSString *)table serialNumber:(NSNumber *)serial configureDataModel:(DataModel *)data
{
    [_db open];
    NSString *query = [NSString stringWithFormat:SELECTFROMTABLE,table];
    FMResultSet *set = [_db executeQuery:query,serial];
    [data configureWithFMResultSet:set];
    [_db close];
}

- (NSInteger)countRowFromTable:(NSString *)table withQuery:(NSString *)queryStr
{
    [_db open];
    NSString *query = [NSString stringWithFormat:COUNTTABLEROW,table,queryStr];
    FMResultSet *set = [_db executeQuery:query];
    NSInteger count = 0;
    while ([set next]) {
        count = [set intForColumn:@"COUNT"];
    }
    [_db close];
    return count;
}

- (NSArray *)createIndexForTable:(NSString *)table withQuery:(NSString *)queryStr
{
    [_db open];
    NSMutableArray *indexArry = [[NSMutableArray alloc] init];
    NSString *query = [NSString stringWithFormat:CREATEINDEX,table,queryStr];
    FMResultSet *set = [_db executeQuery:query];
    while ([set next]) {
        NSInteger serial = [set intForColumn:@"serial"];
        [indexArry addObject:[NSNumber numberWithInteger:serial]];
    }
    [_db close];
    return indexArry;
}

- (NSArray *)examinationResult:(NSDictionary *)answer
{
    [_db open];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSNumber *serial in answer) {
        FMResultSet *set = [_db executeQuery:RESULTCHECK,serial];
        NSString *resultStr;
        while ([set next]) {
            resultStr = [set stringForColumn:@"manswer"];
        }
        if ([answer[serial] isEqualToString:resultStr]) {
            [result addObject:[NSNumber numberWithBool:YES]];
        }else
        {
            [result addObject:[NSNumber numberWithBool:NO]];
        }
    }
    [_db close];
    return result;
}

- (NSInteger)maxSerialNumberFromTable:(NSString *)table
{
    [_db open];
    NSInteger maxNum = 0;
    NSString *query = [NSString stringWithFormat:MAXSERIALNUM,table];
    FMResultSet *set = [_db executeQuery:query];
    while ([set next]) {
        maxNum = [set intForColumn:@"MAXNUM"];
    }
    [_db close];
    return maxNum;
}


@end
