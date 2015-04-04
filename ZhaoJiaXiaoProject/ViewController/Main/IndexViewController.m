//
//  IndexViewController.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-4.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "IndexViewController.h"
#import "TableViewController.h"
#import "ExaminationViewController.h"
#import "WrongViewController.h"
#import "TestResultViewController.h"
#import "SettingTableViewController.h"

#import "DataBaseManager.h"

@interface IndexViewController ()


@property (nonatomic,strong) NSMutableArray *button;
@property (nonatomic,strong) DataBaseManager *db;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    _db = [DataBaseManager shareDataBaseManager];
    CGFloat width = self.view.frame.size.width/3.0;
    CGFloat height = 40;
    CGFloat xValue = width;
    CGFloat yValue = self.view.frame.size.height/4.0;
    CGRect rect = CGRectMake(xValue,yValue, width, height);
    _button = [[NSMutableArray alloc] init];
    NSArray *tittleArry = @[@"交规学习",@"模拟考试",@"我的错题",@"考试成绩"];
    for (NSString *tittle in tittleArry) {
        UIButton *button = [self buildIndexButtonWithFrame:rect withTittle:tittle];
        [button addTarget:self action:@selector(indexPushToViewController:) forControlEvents:UIControlEventTouchUpInside];
        [_button addObject:button];
        [self.view addSubview:button];
        rect.origin.y += 60;
    }
    UIImageView *logo =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    logo.contentMode = UIViewContentModeCenter;
    rect.origin.y = yValue/2.0;
    logo.frame = rect;
    [self.view addSubview:logo];
    [self setUpToolBarButton];
    

}

- (void)setUpToolBarButton
{
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(indexPushToViewController:)];
    setting.tag = 10004;
    self.toolbarItems = @[space,setting,space];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.toolbarHidden = NO;
}



- (UIButton *)buildIndexButtonWithFrame:(CGRect)frame withTittle:(NSString *)tittle
{
    static NSInteger tagInteger = 10000;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:tittle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [button setBackgroundColor:[UIColor colorWithWhite:0.9f alpha:1]];
    button.frame = frame;
    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.tag = tagInteger;
    tagInteger ++;
    return button;
}

- (void)indexPushToViewController:(UIButton *)sender
{
    switch (sender.tag) {
        case 10000:
        {
            TableViewController *view = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 10001:
        {
            ExaminationViewController *view = [[ExaminationViewController alloc] init];
            view.examCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"numValue"];
            view.maxNum = [_db maxSerialNumberFromTable:leaflevel];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 10002:
        {
            WrongViewController *view = [[WrongViewController alloc] initWithStyle:UITableViewStylePlain];
            [self.navigationController pushViewController:view animated:YES];
            
        }
            break;
        case 10003:
        {
            TestResultViewController *view = [[TestResultViewController alloc] initWithStyle:UITableViewStylePlain];
            [self.navigationController pushViewController:view animated:YES];
            
        }
            break;
        case 10004:
        {
            SettingTableViewController *view = [[SettingTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:view animated:YES];
            
        }
        default:
            break;
    }
    
}

@end
