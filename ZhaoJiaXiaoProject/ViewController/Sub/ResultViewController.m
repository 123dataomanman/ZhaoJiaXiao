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

@interface ResultViewController ()

@property (strong,nonatomic) DataBaseManager *db;
@property (strong,nonatomic) DataSource *dataSource;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _db = [DataBaseManager shareDataBaseManager];
    
    ResultViewController *__weak weakSelf = self;
    
    self.tableView.rowHeight = 50;
    UINib *nib = [UINib nibWithNibName:@"ResultTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:leaflevel];
    _dataSource = [[DataSource alloc] initWithTableName:leaflevel indexArry:_indexArry configureBlock:^(LeafLevelModel *item, ResultTableViewCell *cell) {
        NSString *htmlStr = [item.mquestion stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
        cell.question.text = htmlStr;
        cell.tanswer.text = item.manswer;
        cell.manswer.text = weakSelf.answerDict[[NSNumber numberWithInteger:item.serial]];
    }];
    self.tableView.rowHeight = 100;
    self.tableView.dataSource = _dataSource;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<试题" style:UIBarButtonItemStylePlain target:self action:@selector(viewBackExam:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"首页>" style:UIBarButtonItemStylePlain target:self action:@selector(viewBackIndex:)];
}

- (void)viewBackExam:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewBackIndex:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
