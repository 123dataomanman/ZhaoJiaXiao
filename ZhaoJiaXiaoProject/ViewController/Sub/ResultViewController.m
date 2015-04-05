//
//  ResultViewController.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "ResultViewController.h"
#import "DataBaseManager.h"
#import "DataSource.h"
#import "ResultTableViewCell.h"
#import "LeafLevelModel.h"
#import "AnswerViewController.h"
#import "NSString+ChangeBR.h"
#import "TestResultModel.h"

@interface ResultViewController ()

@property (strong,nonatomic) DataBaseManager *db;
@property (strong,nonatomic) DataSource *dataSource;
@property (strong,nonatomic) NSDictionary *result;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结果";
    _db = [DataBaseManager shareDataBaseManager];
    
    ResultViewController *__weak weakSelf = self;
    
    self.tableView.rowHeight = 50;
    UINib *nib = [UINib nibWithNibName:@"ResultTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:leaflevel];
    _dataSource = [[DataSource alloc] initWithTableName:leaflevel indexArry:_indexArry configureBlock:^(LeafLevelModel *item, ResultTableViewCell *cell) {
        NSString *htmlStr = [item.mquestion changeBrToEnter];
        cell.question.text = htmlStr;
        cell.tanswer.text = item.manswer;
        cell.manswer.text = weakSelf.answerDict[[NSNumber numberWithInteger:item.serial]];
    }];
    self.tableView.rowHeight = 100;
    self.tableView.dataSource = _dataSource;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"试题" style:UIBarButtonItemStylePlain target:self action:@selector(viewBackExam:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"首页" style:UIBarButtonItemStylePlain target:self action:@selector(viewBackIndex:)];
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"错题保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveWrongExam:)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.toolbarItems = @[space,save,space];
    _result = [_db examinationResult:_answerDict];
    TestResultModel *model = [[TestResultModel alloc] initWithResultDict:_result];
    [_db saveTestResult:model];
}



- (void)saveWrongExam:(id)sender
{
    for (NSNumber *serial in _result) {
        NSNumber *num = _result[serial];
        if (!num.boolValue) {
            [_db saveMistakeForSerialNumber:serial configureMarea:_answerDict[serial]];
        }
    }
}


- (void)viewBackExam:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewBackIndex:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerViewController *answer = [[AnswerViewController alloc] init];
    answer.selectDict = _selectDict;
    answer.answerDict = _answerDict;
    answer.indexArry = _indexArry;
    answer.rowNum = indexPath.row;
    [self.navigationController pushViewController:answer animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
