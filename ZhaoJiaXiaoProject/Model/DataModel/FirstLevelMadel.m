//
//  FirstLevelMadel.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "FirstLevelMadel.h"

@implementation FirstLevelMadel

- (void)configureWithFMResultSet:(FMResultSet *)set
{
    while ([set next]) {
        self.serial = [set intForColumn:@"serial"];
        _pid = [set intForColumn:@"pid"];
        _pname = [set stringForColumn:@"pname"];
        _pcount = [set intForColumn:@"pcount"];
    }
    
}


@end
