//
//  LeafLevelModel.h
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "DataModel.h"

@interface LeafLevelModel : DataModel

@property (nonatomic,copy) NSString *mquestion;
@property (nonatomic,copy) NSString *mdesc;
@property (nonatomic,assign) NSInteger mid;
@property (nonatomic,copy) NSString *manswer;
@property (nonatomic,copy) NSString *mimage;
@property (nonatomic,assign) NSInteger pid;
@property (nonatomic,copy) NSString *pname;
@property (nonatomic,assign) NSInteger sid;
@property (nonatomic,copy) NSString *sname;
@property (nonatomic,assign) NSInteger mstatus;
@property (nonatomic,copy) NSString *marea;
@property (nonatomic,assign) NSInteger mtype;
@property (nonatomic,copy) NSString *munknow;
@property (nonatomic,assign) NSInteger myear;
@property (nonatomic,assign) NSInteger ecount;




@end
