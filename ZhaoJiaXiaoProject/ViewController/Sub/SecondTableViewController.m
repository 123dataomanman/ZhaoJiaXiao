//
//  SecondTableViewController.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "SecondTableViewController.h"
#import "FirstLevelMadel.h"
#import "SecondLevelModel.h"
#import "DataBaseManager.h"
#import "PractiseViewController.h"
#import "DataSource.h"

@interface SecondTableViewController ()

@property (strong,nonatomic) DataBaseManager *db;
@property (strong,nonatomic) DataSource *dataSource;

@end

@implementation SecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _db = [DataBaseManager shareDataBaseManager];
    
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:secondlevel];
    NSArray *arry = [_db createIndexForTable:secondlevel withQuery:[NSString stringWithFormat:@"pid = %ld",(long)_firstItem.pid]];
    _dataSource = [[DataSource alloc] initWithTableName:secondlevel indexArry:arry configureBlock:^(DataModel *item, UITableViewCell *cell) {
        SecondLevelModel *model = (SecondLevelModel *)item;
        cell.textLabel.text = model.sname;
    }];
    self.tableView.dataSource = _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.toolbarHidden = YES;
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PractiseViewController *leafLevel = [[PractiseViewController alloc] init];
    SecondLevelModel *secondItem =(SecondLevelModel *)[_dataSource findDataModelWithIndexPath:indexPath];
    leafLevel.secondItem = secondItem;
    leafLevel.indexArry = [_db createIndexForTable:leaflevel withQuery:[NSString stringWithFormat:@"sid = '%@'",secondItem.sid]];
    [self.navigationController pushViewController:leafLevel animated:YES];
}


@end
