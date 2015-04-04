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
#import "TestResultModel.h"

static DataBaseManager *_mainManager = nil;

#define CREATEINDEX     @"SELECT serial FROM %@ WHERE %@;"
#define SELECTFROMTABLE @"SELECT * FROM %@ WHERE serial = ?;"
#define COUNTTABLEROW   @"SELECT COUNT(*) AS COUNT FROM %@ WHERE %@;"
#define RESULTCHECK     @"SELECT manswer FROM leaflevel WHERE serial = ?"
#define MAXSERIALNUM    @"SELECT MAX(serial) AS MAXNUM FROM %@;"
#define SAVEWRONG       @"INSERT INTO studytable SELECT * FROM  leaflevel WHERE serial = ?;"
#define CHANGESAVE      @"UPDATE studytable SET marea = ? WHERE serial = ?;"
#define DELETEWRONG     @"DELETE FROM studytable WHERE serial = ?;"
#define TESTTABLE       @"CREATE TABLE IF NOT EXISTS MYTEST(serial integer PRIMARY KEY AUTOINCREMENT,numOfTest integer,numOfWrong integer,testdate text);"
#define INSERTTEST      @"INSERT INTO MYTEST(numOfTest,numOfWrong,testdate) VALUES(?,?,?);"
#define DELETETEST      @"DELETE FROM MYTEST;"

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
    NSArray *pathArry = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbPath = [NSString stringWithFormat:@"%@/data.sqlite",pathArry[0]];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:dbPath]) {
        NSError *error;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"sqlite"];
        [fm copyItemAtPath:path toPath:dbPath error:&error];
        if (error != nil) {
            NSLog(@"%@",error);
        }
        [[NSUserDefaults standardUserDefaults] setInteger:10 forKey:@"numValue"];
    }
    NSLog(@"%@",dbPath);
    _db = [FMDatabase databaseWithPath:dbPath];
    [_db open];
    [_db executeUpdate:TESTTABLE];
    [_db close];
    
    
}

- (void)selectFromTable:(NSString *)table serialNumber:(NSNumber *)serial configureDataModel:(DataModel *)data
{
    [_db open];
    NSString *query = [NSString stringWithFormat:SELECTFROMTABLE,table];
    FMResultSet *set = [_db executeQuery:query,serial];
    [data configureWithFMResultSet:set];
    [_db close];
}

- (void)saveMistakeForSerialNumber:(NSNumber *)serial configureMarea:(NSString *)marea
{
    [_db open];
    [_db executeUpdate:SAVEWRONG,serial];
    [_db executeUpdate:CHANGESAVE,marea,serial];
    [_db close];
    
}

- (BOOL)saveTestResult:(TestResultModel *)model
{
    [_db open];
    BOOL save = [_db executeUpdate:INSERTTEST,[NSNumber numberWithInteger:model.numOfTest],[NSNumber numberWithInteger:model.numOfWrong],model.date];
    [_db close];
    return save;
}

- (BOOL)deleteMistakeForSerialNumber:(NSNumber *)seria
{
    [_db open];
    BOOL delete = [_db executeUpdate:DELETEWRONG,seria];
    [_db close];
    return delete;
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

- (NSDictionary *)examinationResult:(NSDictionary *)answer
{
    [_db open];
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    for (NSNumber *serial in answer) {
        FMResultSet *set = [_db executeQuery:RESULTCHECK,serial];
        NSString *resultStr;
        while ([set next]) {
            resultStr = [set stringForColumn:@"manswer"];
        }
        if ([answer[serial] isEqualToString:resultStr]) {
            [result setObject:[NSNumber numberWithBool:YES] forKey:serial];
        }else
        {
            [result setObject:[NSNumber numberWithBool:NO] forKey:serial];
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

- (void)cleanAllTestResult
{
    [_db open];
    [_db executeUpdate:DELETETEST];
    [_db close];
}

- (void)saveTestResult
{
    
}


@end
