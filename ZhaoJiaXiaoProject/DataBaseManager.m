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
#define SELECTFROMTABLE @"SELECT * FROM %@ WHERE Serial = ?;"
#define COUNTTABLEROW   @"SELECT COUNT(*) AS COUNT FROM %@ WHERE %@;"

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



@end
