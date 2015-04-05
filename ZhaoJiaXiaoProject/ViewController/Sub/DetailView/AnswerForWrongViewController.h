//
//  AnswerForWrongViewController.h
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-5.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "LeafLevelViewController.h"

@class DataSource;

@interface AnswerForWrongViewController : LeafLevelViewController

@property (nonatomic,assign) NSInteger rowNum;
@property (nonatomic,assign) NSInteger rowCount;
@property (nonatomic,strong) DataSource *dataSource;

@end
