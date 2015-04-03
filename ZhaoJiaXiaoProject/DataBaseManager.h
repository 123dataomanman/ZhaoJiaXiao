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

@class DataModel;

@interface DataBaseManager : NSObject

+ (instancetype)shareDataBaseManager;

- (NSInteger)countRowFromTable:(NSString *)table
                     withQuery:(NSString *)queryStr;

- (void)selectFromTable:(NSString *)table serialNumber:(NSNumber *)serial configureDataModel:(DataModel *)data;

- (NSArray *)createIndexForTable:(NSString *)table withQuery:(NSString *)queryStr;


@end
