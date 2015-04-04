//
//  DataBaseManager.h
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import <Foundation/Foundation.h>

#define firstlevel  @"firstlevel"
#define leaflevel   @"leaflevel"
#define secondlevel @"secondlevel"
#define studytable  @"studytable"
#define testtable   @"testtable"
#define mytest      @"MYTEST"

@class DataModel;
@class TestResultModel;

@interface DataBaseManager : NSObject

+ (instancetype)shareDataBaseManager;

- (NSInteger)countRowFromTable:(NSString *)table
                     withQuery:(NSString *)queryStr;

- (void)selectFromTable:(NSString *)table serialNumber:(NSNumber *)serial configureDataModel:(DataModel *)data;

- (NSArray *)createIndexForTable:(NSString *)table withQuery:(NSString *)queryStr;

- (NSDictionary *)examinationResult:(NSDictionary *)answer;

- (NSInteger)maxSerialNumberFromTable:(NSString *)table;
- (void)saveMistakeForSerialNumber:(NSNumber *)serial configureMarea:(NSString *)marea;
- (BOOL)deleteMistakeForSerialNumber:(NSNumber *)seria;
- (BOOL)saveTestResult:(TestResultModel *)model;
- (void)cleanAllTestResult;


@end
