//
//  ExaminationViewController.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "ExaminationViewController.h"
#import "ResultViewController.h"
#import "LeafLevelModel.h"

@interface ExaminationViewController ()<UIAlertViewDelegate>

@property (nonatomic,strong) NSMutableDictionary *dict;
@property (nonatomic,strong) NSMutableDictionary *answerDict;

@end

@implementation ExaminationViewController

- (void)viewDidLoad {
    [self createIndexArry];
    [super viewDidLoad];
    _dict = [[NSMutableDictionary alloc] init];
    _answerDict = [[NSMutableDictionary alloc] init];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
}

- (void)createIndexArry
{
    NSMutableArray *arry = [[NSMutableArray alloc] init];
    NSInteger space = _maxNum/_examCount;
    NSInteger serial = 0;
    for (NSInteger i = 0; i < _examCount; i ++) {
        NSInteger num = arc4random()%space;
        serial += num;
        [arry addObject:[NSNumber numberWithInteger:serial]];
    }
    self.indexArry = arry;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)beforItem:(id)sender
{
    [super beforItem:sender];
    [self resumeSegmentSelect];
}

- (void)nextItem:(id)sender
{
    [super nextItem:sender];
    [self resumeSegmentSelect];
}

- (void)saveSegmentSelect
{

    NSNumber *index = [NSNumber numberWithInteger:self.leafItem.serial];
    NSNumber *select = [NSNumber numberWithInteger:self.segmentNow.selectedSegmentIndex];
    [_dict setObject:select forKey:index];
    if (self.segmentNow.selectedSegmentIndex == UISegmentedControlNoSegment) {
        [_answerDict setObject:@"空" forKey:index];
    }else
    {
        [_answerDict setObject:[self.segmentNowArry objectAtIndex:self.segmentNow.selectedSegmentIndex] forKey:index];
    }
}

- (void)resumeSegmentSelect
{
    NSNumber *index = [NSNumber numberWithInteger:self.leafItem.serial];
    NSNumber *select = [_dict objectForKey:index];
    if (select) {
        self.segmentNow.selectedSegmentIndex = select.integerValue;
    }else
    {
        self.segmentNow.selectedSegmentIndex = UISegmentedControlNoSegment;
    }
    NSString *str = (self.segmentNow.selectedSegmentIndex == -1)?@"空":[_answerDict objectForKey:index];
    self.answer.text = [@"你的选择为:" stringByAppendingFormat:@"%@",str];
}

- (void)commitItem:(id)sender
{
    if (self.indexNum == self.indexArry.count) {
        [self saveSegmentSelect];
    }
    if (_answerDict.count < _examCount) {
        [self showAlert];
        return;
    }
    ResultViewController *result = [[ResultViewController alloc] initWithStyle:UITableViewStylePlain];
    result.indexArry = self.indexArry;
    result.answerDict = _answerDict;
    result.selectDict = _dict;
    [self.navigationController pushViewController:result animated:YES];
}

- (void)showAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"未完成所有题目" delegate:self cancelButtonTitle:@"继续答题" otherButtonTitles:@"放弃考试",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)segmentValueChange:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == UISegmentedControlNoSegment) {
        return;
    }
    self.answer.text = [@"你的选择为:" stringByAppendingFormat:@"%@",self.segmentNowArry[segment.selectedSegmentIndex]];
    [self saveSegmentSelect];
}


@end
