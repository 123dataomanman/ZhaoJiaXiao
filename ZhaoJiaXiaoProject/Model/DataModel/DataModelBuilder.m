//
//  DataModelBuilder.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "DataModelBuilder.h"
#import "DataBaseManager.h"
#import "FirstLevelMadel.h"
#import "LeafLevelModel.h"
#import "SecondLevelModel.h"
#import "StudentModel.h"
#import "TestModel.h"

@implementation DataModelBuilder

+ (DataModel *)buildDataModelWithTableName:(NSString *)tableName serialNumber:(NSNumber *)serial
{
    if ([tableName isEqualToString:firstlevel]) {
        return [[FirstLevelMadel alloc] initWithTableName:tableName serialNumber:serial];
    }else if ([tableName isEqualToString:leaflevel])
    {
        return [[LeafLevelModel alloc] initWithTableName:tableName serialNumber:serial];
    }else if ([tableName isEqualToString:secondlevel])
    {
        return [[SecondLevelModel alloc] initWithTableName:tableName serialNumber:serial];
    }else if ([tableName isEqualToString:studytable])
    {
        return [[StudentModel alloc] initWithTableName:tableName serialNumber:serial];
    }else if ([tableName isEqualToString:testtable])
    {
        return [[TestModel alloc] initWithTableName:tableName serialNumber:serial];
    }else
    {
        return nil;
    }
}



@end
