//
//  AnswerViewController.h
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-4.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "LeafLevelViewController.h"

@interface AnswerViewController : LeafLevelViewController

@property (nonatomic,strong) NSArray *indexArry;
@property (nonatomic,strong) NSDictionary *answerDict;
@property (nonatomic,strong) NSDictionary *selectDict;
@property (nonatomic,assign) NSInteger rowNum;

@end
