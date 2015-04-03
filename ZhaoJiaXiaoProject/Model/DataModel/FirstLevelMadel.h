//
//  FirstLevelMadel.h
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "DataModel.h"


//CREATE TABLE firstlevel (
//                         serial integer PRIMARY KEY AUTOINCREMENT,
//                         pid integer,
//                         pname text(1024) DEFAULT(NULL),
//                         pcount integer
//                         );


@interface FirstLevelMadel : DataModel

@property (nonatomic,assign) NSInteger pid;
@property (nonatomic,copy) NSString *pname;
@property (nonatomic,assign) NSInteger pcount;

@end
