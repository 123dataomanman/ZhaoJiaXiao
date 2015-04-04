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
#import "DataSource.h"

@interface LeafLevelViewController ()

@property (strong,nonatomic) DataBaseManager *db;
@property (strong,nonatomic) DataSource *dataSource;

@property (strong,nonatomic) UITextView *detial;
@property (strong,nonatomic) UIImageView *imageView;

@property (assign,nonatomic) CGRect segmentedFrame;

@end

@implementation LeafLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _db = [DataBaseManager shareDataBaseManager];
    _dataSource = [[DataSource alloc] initWithTableName:leaflevel indexArry:_indexArry configureBlock:nil];
    
    _indexNum = 0;
    
    CGRect rect = self.view.frame;
    rect.size.height /= 3;
    
    
    _detial = [[UITextView alloc] initWithFrame:rect];
    _detial.font = [UIFont systemFontOfSize:14];
    _detial.editable = NO;
    
    rect.origin.y += (rect.size.height + 10);
    rect.size.height = 50;
    _imageView = [[UIImageView alloc] initWithFrame:rect];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    rect.origin.y += (rect.size.height + 50);
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
    
    [self.view addSubview:_detial];
    [self.view addSubview:_answer];
    [self.view addSubview:_imageView];
    [self.view addSubview:_selectSegmented];
    [self.view addSubview:_judgeSegmented];
    
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
    _selectSegmentedControlItem = @[@"A",@"B",@"C",@"D"];
    _judgeSegmentedControlItem = @[@"对",@"错"];
    
    _selectSegmented = [[UISegmentedControl alloc] initWithItems:_selectSegmentedControlItem];
    _selectSegmented.tintColor = [UIColor darkGrayColor];
    _selectSegmented.frame = frame;
    
    _judgeSegmented = [[UISegmentedControl alloc] initWithItems:_judgeSegmentedControlItem];
    _judgeSegmented.tintColor = [UIColor darkGrayColor];
    _judgeSegmented.frame = frame;
    
    _segmentedFrame = frame;
    [_judgeSegmented addTarget:self action:@selector(segmentValueChange:) forControlEvents:UIControlEventValueChanged];
    [_selectSegmented addTarget:self action:@selector(segmentValueChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)changeText
{
    self.title = [NSString stringWithFormat:@"%ld/%ld",(long)_indexNum+1,(long)(_indexArry.count)];
    _answer.text = @"按确认键确认结果";
    _leafItem = (LeafLevelModel *)[_dataSource findDataModelWithIndex:_indexNum];
    NSString *htmlStr = [_leafItem.mquestion stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
    _detial.text = htmlStr;
    [self changeImage];
    [self changeSegment];
}

- (void)changeImage
{
    if ([_leafItem.mimage isEqualToString:@""]) {
        _imageView = nil;
    }
    else
    {
        NSString *imgName = [_leafItem.mimage stringByReplacingOccurrencesOfString:@".gif" withString:@".png"];
        _imageView.image = [UIImage imageNamed:imgName];
    }
}

- (void)changeSegment
{
    if ([(NSString *)_leafItem.sid hasSuffix:@".2"]) {
        _selectSegmented.frame = CGRectZero;
        _judgeSegmented.frame = _segmentedFrame;
        _segmentNow = _judgeSegmented;
        _segmentNowArry = _judgeSegmentedControlItem;
        _isSelectType = NO;
    }else
    {
        _selectSegmented.frame = _segmentedFrame;
        _judgeSegmented.frame = CGRectZero;
        _segmentNow = _selectSegmented;
        _segmentNowArry = _selectSegmentedControlItem;
        _isSelectType = YES;
    }
}

- (void)beforItem:(id)sender
{
    if (_indexNum > 0) _indexNum --;
    [self changeText];
}

- (void)nextItem:(id)sender
{
    if (_indexNum < (_indexArry.count-1)) _indexNum ++;
    [self changeText];
}

- (void)commitItem:(id)sender
{
    
}

- (void)segmentValueChange:(UISegmentedControl *)segment
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
