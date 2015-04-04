//
//  TableViewController.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "TableViewController.h"
#import "DataBaseManager.h"
#import "FirstLevelMadel.h"
#import "SecondTableViewController.h"
#import "DataSource.h"

@interface TableViewController ()

@property (strong,nonatomic) DataBaseManager *db;

@property (strong,nonatomic) DataSource *dataSource;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交规学习";
    _db = [DataBaseManager shareDataBaseManager];
    
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:firstlevel];
    NSArray *arry = [_db createIndexForTable:firstlevel withQuery:@"pid > 0"];
    _dataSource = [[DataSource alloc] initWithTableName:firstlevel indexArry:arry configureBlock:^(DataModel *item, UITableViewCell *cell) {
        FirstLevelMadel *model = (FirstLevelMadel *)item;
        cell.textLabel.text = model.pname;
    }];
    self.tableView.dataSource = _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.toolbarHidden = YES;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondTableViewController *second = [[SecondTableViewController alloc] initWithStyle:UITableViewStylePlain];
    second.firstItem = (FirstLevelMadel *)[_dataSource findDataModelWithIndexPath:indexPath];
    [self.navigationController pushViewController:second animated:YES];
}


@end
