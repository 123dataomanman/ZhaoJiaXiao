//
//  SecondLevelModel.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "SecondLevelModel.h"

@implementation SecondLevelModel

- (void)configureWithFMResultSet:(FMResultSet *)set
{
    while ([set next]) {
        self.serial = [set intForColumn:@"serial"];
        _sid = [set stringForColumn:@"sid"];
        _sname = [set stringForColumn:@"sname"];
        _pid = [set intForColumn:@"pid"];
        _scount = [set intForColumn:@"scount"];
        _rcount = [set intForColumn:@"rcount"];
    }
}

@end
