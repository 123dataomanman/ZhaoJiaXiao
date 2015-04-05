//
//  AnswerViewController.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-4.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "AnswerViewController.h"
#import "LeafLevelModel.h"

@interface AnswerViewController ()

@end

@implementation AnswerViewController

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)changeText
{
    [super changeText];
    self.answer.text = [NSString stringWithFormat:@"正确答案为:%@\n你的答案为:%@",self.leafItem.manswer,_answerDict[[NSNumber numberWithInteger:self.leafItem.serial]]];
}

- (void)changeSegment
{
}

- (void)beforItem:(id)sender
{
    [super beforItem:sender];
}

- (void)nextItem:(id)sender
{
    [super nextItem:sender];
}

@end
