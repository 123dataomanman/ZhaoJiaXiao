//
//  TestResultModel.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-4.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "TestResultModel.h"

@implementation TestResultModel

- (instancetype)initWithResultDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _numOfTest = dict.count;
        _numOfWrong = 0;
        for (id key in dict) {
            NSNumber *num = dict[key];
            if (!num.boolValue) {
                _numOfWrong++;
            }
        }
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"yyyy-MM-dd hh:mm EEEE";
        _date = [df stringFromDate:[NSDate date]];
    }
    return self;
}

- (void)configureWithFMResultSet:(FMResultSet *)set
{
    while ([set next]) {
        self.serial = [set intForColumn:@"serial"];
        _numOfTest = [set intForColumn:@"numOfTest"];
        _numOfWrong = [set intForColumn:@"numOfWrong"];
        _date = [set stringForColumn:@"testdate"];
    }
}



@end
