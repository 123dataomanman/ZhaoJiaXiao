//
//  DataModel.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "DataModel.h"
#import "DataBaseManager.h"

@implementation DataModel

- (instancetype)initWithTableName:(NSString *)table serialNumber:(NSNumber *)serial
{
    self = [super init];
    if (self) {
        DataBaseManager *db = [DataBaseManager shareDataBaseManager];
        [db selectFromTable:table serialNumber:serial configureDataModel:self];
    }
    return self;
}

- (void)configureWithFMResultSet:(FMResultSet *)set
{
    
}

@end
