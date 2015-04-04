//
//  TestResultViewController.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-4.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "TestResultViewController.h"
#import "DataBaseManager.h"
#import "DataSource.h"
#import "TestResultTableViewCell.h"
#import "TestResultModel.h"

@interface TestResultViewController ()

@property (nonatomic,strong) DataBaseManager *db;
@property (nonatomic,strong) DataSource *dataSource;

@end

@implementation TestResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"考试成绩";
    _db = [DataBaseManager shareDataBaseManager];
    
    self.tableView.rowHeight = 50;
    UINib *nib = [UINib nibWithNibName:@"TestResultTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:mytest];
    NSArray *arry = [_db createIndexForTable:mytest withQuery:@"serial >= 0"];
    _dataSource = [[DataSource alloc] initWithTableName:mytest indexArry:arry configureBlock:^(TestResultModel *item, TestResultTableViewCell *cell) {
        cell.data.text = item.date;
        cell.right.text = [NSString stringWithFormat:@"%ld",(long)(item.numOfTest-item.numOfWrong)];
        cell.sum.text = [NSString stringWithFormat:@"%ld",(long)item.numOfTest];
    }];
    self.tableView.dataSource = _dataSource;
    UIBarButtonItem *clean = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStylePlain target:self action:@selector(cleanAllTestResult:)];
    self.navigationItem.rightBarButtonItem = clean;
}

- (void)cleanAllTestResult:(id)sender
{
    [_db cleanAllTestResult];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
