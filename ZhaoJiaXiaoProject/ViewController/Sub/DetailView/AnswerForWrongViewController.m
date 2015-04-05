//
//  AnswerForWrongViewController.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-5.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "AnswerForWrongViewController.h"
#import "StudentModel.h"
#import "DataSource.h"
#import "NSString+ChangeBR.h"

@interface AnswerForWrongViewController ()

@end

@implementation AnswerForWrongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectSegmented.frame = CGRectZero;
    self.judgeSegmented.frame = CGRectZero;
    self.indexNum = _rowNum;
    self.answer.numberOfLines = 0;
    CGRect rect = self.answer.frame;
    rect.size.height *= 2;
    self.answer.frame = rect;
    [self changeText];
    // Do any additional setup after loading the view.
}


- (void)changeText
{
    self.title = [NSString stringWithFormat:@"%ld/%ld",(long)_rowNum+1,(long)_rowCount];
    self.leafItem = (StudentModel *)[_dataSource findDataModelWithIndex:_rowNum];
    NSString *detial = [self.leafItem.mquestion changeBrToEnter];
    self.detial.text = [detial stringByAppendingFormat:@"\n\n答案解析:\n%@",[self.leafItem.mdesc changeBrToEnter]];
    [self changeImage];
    self.answer.text = [NSString stringWithFormat:@"正确答案为:%@\n你的答案为:%@",self.leafItem.manswer,self.leafItem.marea];
}

- (void)beforItem:(id)sender
{
    if (_rowNum > 0) _rowNum --;
    [self changeText];
}

- (void)nextItem:(id)sender
{
    if (_rowNum < (_rowCount-1)) _rowNum ++;
    [self changeText];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
