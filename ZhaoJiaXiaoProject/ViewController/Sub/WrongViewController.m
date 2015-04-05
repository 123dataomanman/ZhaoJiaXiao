//
//  WrongViewController.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-4.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "WrongViewController.h"
#import "ResultViewController.h"
#import "DataBaseManager.h"
#import "DataSource.h"
#import "ResultTableViewCell.h"
#import "StudentModel.h"
#import "AnswerViewController.h"
#import "NSString+ChangeBR.h"
#import "AnswerForWrongViewController.h"

@interface WrongViewController ()<DataSource>

@property (strong,nonatomic) DataBaseManager *db;
@property (strong,nonatomic) DataSource *dataSource;
@property (strong,nonatomic) NSArray *indexArry;

@end

@implementation WrongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的错题";
    _db = [DataBaseManager shareDataBaseManager];
    self.tableView.rowHeight = 50;
    UINib *nib = [UINib nibWithNibName:@"ResultTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:studytable];
    _indexArry = [_db createIndexForTable:studytable withQuery:@"serial != 0"];
    _dataSource = [[DataSource alloc] initWithTableName:studytable indexArry:_indexArry configureBlock:^(StudentModel *item, ResultTableViewCell *cell) {
        NSString *htmlStr = [item.mquestion changeBrToEnter];
        cell.question.text = htmlStr;
        cell.tanswer.text = item.manswer;
        cell.manswer.text = item.marea;
    }];
    _dataSource.tableCanEdit = YES;
    _dataSource.delegate = self;
    self.tableView.rowHeight = 100;
    self.tableView.dataSource = _dataSource;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeafLevelModel *model = (LeafLevelModel *)[_dataSource findDataModelWithIndexPath:indexPath];
    [_db deleteMistakeForSerialNumber:[NSNumber numberWithInteger:model.serial]];
    _dataSource.indexArry = [_db createIndexForTable:studytable withQuery:@"serial != 0"];
    [_dataSource.itemDict removeAllObjects];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerForWrongViewController *view = [[AnswerForWrongViewController alloc] init];
    view.rowNum = indexPath.row;
    view.rowCount = [tableView numberOfRowsInSection:0];
    view.dataSource = _dataSource;
    [self.navigationController pushViewController:view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
