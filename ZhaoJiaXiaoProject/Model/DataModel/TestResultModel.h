//
//  TestResultModel.h
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-4.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "DataModel.h"

@interface TestResultModel : DataModel

@property (nonatomic,assign) NSInteger numOfTest;
@property (nonatomic,assign) NSInteger numOfWrong;
@property (nonatomic,copy) NSString *date;


- (instancetype)initWithResultDict:(NSDictionary *)dict;


@end
