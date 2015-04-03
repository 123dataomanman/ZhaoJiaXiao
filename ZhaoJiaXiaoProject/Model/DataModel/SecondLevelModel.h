//
//  SecondLevelModel.h
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "DataModel.h"




@interface SecondLevelModel : DataModel

@property (nonatomic,assign) NSString *sid;
@property (nonatomic,copy) NSString *sname;
@property (nonatomic,assign) NSInteger pid;
@property (nonatomic,assign) NSInteger scount;
@property (nonatomic,assign) NSInteger rcount;

@end
