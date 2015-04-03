//
//  LeafLevelViewController.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "LeafLevelViewController.h"
#import "DataBaseManager.h"
#import "SecondLevelModel.h"
#import "LeafLevelModel.h"

@interface LeafLevelViewController ()

@property (strong,nonatomic) DataBaseManager *db;
@property (strong,nonatomic) NSArray *indexArry;
@property (strong,nonatomic) LeafLevelModel *leafItem;
@property (strong,nonatomic) UITextView *tittle;
@property (assign,nonatomic) NSInteger indexNum;

@property (strong,nonatomic) UISegmentedControl *segmentedControl;
@property (assign,nonatomic) BOOL isSelectType;
@property (strong,nonatomic) UILabel *answer;
@property (strong,nonatomic) NSArray *segmentedControlItem;

@end

@implementation LeafLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _db = [DataBaseManager shareDataBaseManager];
    
    _indexArry = [_db createIndexForTable:leaflevel withQuery:[NSString stringWithFormat:@"sid = '%@'",_secondItem.sid]];
    _indexNum = 0;
    
    CGRect rect = self.view.frame;
    rect.size.height /= 2.0;
    _tittle = [[UITextView alloc] initWithFrame:rect];
    _tittle.font = [UIFont systemFontOfSize:13];
    _tittle.editable = NO;
    _isSelectType = [(NSString *)_secondItem.sid hasSuffix:@".2"];

    rect.origin.y += (rect.size.height + 10);
    rect.size.height = 20;
    _answer = [[UILabel alloc] initWithFrame:rect];
    _answer.text = @"按确认键确认结果";
    _answer.textAlignment = NSTextAlignmentCenter;
    _answer.textColor = [UIColor darkGrayColor];
    _answer.font = [UIFont systemFontOfSize:14];
    
    
    rect.origin.y += (rect.size.height + 30);
    rect.size.height = 40;
    rect.origin.x = (rect.size.width - 200)/2.0;
    rect.size.width = 200;
    
    [self setUpToolBarItem];
    [self setUpSegmentedControlWithFrame:rect];
    [self changeText];
    [self.view addSubview:_tittle];
    [self.view addSubview:_answer];
    [self.view addSubview:_segmentedControl];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.toolbarHidden = NO;
}

- (void)setUpToolBarItem
{
    UIBarButtonItem *befor = [[UIBarButtonItem alloc] initWithTitle:@"上一条" style:UIBarButtonItemStylePlain target:self action:@selector(beforItem:)];
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"下一条" style:UIBarButtonItemStylePlain target:self action:@selector(nextItem:)];
    UIBarButtonItem *commit = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(commitItem:)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    self.toolbarItems = @[space,befor,space,commit,space,next,space];
    
}

- (void)setUpSegmentedControlWithFrame:(CGRect)frame
{
    if (!_isSelectType) {
        _segmentedControlItem = @[@"A",@"B",@"C",@"D"];
    } else {
        _segmentedControlItem = @[@"对",@"错"];
    }
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:_segmentedControlItem];
    _segmentedControl.tintColor = [UIColor darkGrayColor];
    _segmentedControl.frame = frame;
}

- (void)changeText
{
    self.title = [NSString stringWithFormat:@"%ld/%ld",(long)_indexNum+1,(long)(_indexArry.count)];
    _answer.text = @"按确认键确认结果";
    _leafItem = [[LeafLevelModel alloc] initWithTableName:leaflevel serialNumber:_indexArry[_indexNum]];
    NSString *str = [(NSString *)_leafItem.mquestion stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
    _tittle.text = str;
}


- (void)beforItem:(id)sender
{
    if (_indexNum == 0) {
    }else
    {
        _indexNum --;
    }
    [self changeText];
}

- (void)nextItem:(id)sender
{
    if (_indexNum == (_indexArry.count-1)) {
    }else
    {
        _indexNum ++;
    }
    [self changeText];
}

- (void)commitItem:(id)sender
{
    if ([_segmentedControlItem[_segmentedControl.selectedSegmentIndex] isEqualToString:_leafItem.manswer]) {
        _answer.text = @"回答正确";
    }else
    {
        _answer.text = @"回答错误";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
