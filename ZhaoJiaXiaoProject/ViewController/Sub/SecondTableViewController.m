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
#import "LeafLevelViewController.h"

@interface SecondTableViewController ()

@property (strong,nonatomic) DataBaseManager *db;
@property (strong,nonatomic) NSArray *indexArry;

@end

@implementation SecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _db = [DataBaseManager shareDataBaseManager];
    _indexArry = [_db createIndexForTable:secondlevel withQuery:[NSString stringWithFormat:@"pid = %ld",(long)_firstItem.pid]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TEST"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.toolbarHidden = YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _indexArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TEST" forIndexPath:indexPath];
    SecondLevelModel *item = [[SecondLevelModel alloc] initWithTableName:secondlevel serialNumber:_indexArry[indexPath.row]];
    cell.textLabel.text = item.sname;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeafLevelViewController *leafLevel = [[LeafLevelViewController alloc] init];
    leafLevel.secondItem = [[SecondLevelModel alloc] initWithTableName:secondlevel serialNumber:_indexArry[indexPath.row]];
    [self.navigationController pushViewController:leafLevel animated:YES];
}


@end
