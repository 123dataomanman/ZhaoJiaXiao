//
//  LeafLevelModel.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "LeafLevelModel.h"

@implementation LeafLevelModel

- (void)configureWithFMResultSet:(FMResultSet *)set
{
    while ([set next]) {
        self.serial = [set intForColumn:@"serial"];
        _mquestion = [set stringForColumn:@"mquestion"];
        _mdesc = [set stringForColumn:@"mdesc"];
        _mid = [set intForColumn:@"mid"];
        _manswer = [set stringForColumn:@"manswer"];
        _mimage = [set stringForColumn:@"mimage"];
        _pid = [set intForColumn:@"pid"];
        _pname = [set stringForColumn:@"pname"];
        _sid = [set intForColumn:@"sid"];
        _sname = [set stringForColumn:@"sname"];
        _mstatus = [set intForColumn:@"mstatus"];
        _marea = [set stringForColumn:@"marea"];
        _mtype = [set intForColumn:@"mtype"];
        _munknow = [set stringForColumn:@"munknow"];
        _myear = [set intForColumn:@"myear"];
        _ecount = [set intForColumn:@"ecount"];
    }
    
}


@end
