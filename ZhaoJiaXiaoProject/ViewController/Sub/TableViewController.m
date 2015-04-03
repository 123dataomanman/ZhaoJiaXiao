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

@interface TableViewController ()

@property (strong,nonatomic) DataBaseManager *db;
@property (strong,nonatomic) NSMutableDictionary *itemDict;
@property (assign,nonatomic) CGFloat width;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交规学习";
    _db = [DataBaseManager shareDataBaseManager];
    _itemDict = [[NSMutableDictionary alloc] init];
    _width = self.tableView.frame.size.width;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TEST"];
    self.tableView.rowHeight = 50;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [_db countRowFromTable:firstlevel withQuery:@"pid > 0"];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TEST" forIndexPath:indexPath];
    FirstLevelMadel *item = [_itemDict objectForKey:indexPath];
    if (item == nil) {
        item = [[FirstLevelMadel alloc] initWithTableName:firstlevel serialNumber:[NSNumber numberWithInteger:(indexPath.row + 1)]];
        [_itemDict setObject:item forKey:indexPath];
    }
    cell.textLabel.text = item.pname;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.numberOfLines = 0;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondTableViewController *second = [[SecondTableViewController alloc] initWithStyle:UITableViewStylePlain];
    second.firstItem = [[FirstLevelMadel alloc] initWithTableName:firstlevel serialNumber:[NSNumber numberWithInteger:(indexPath.row + 1)]];
    [self.navigationController pushViewController:second animated:YES];
}


@end
