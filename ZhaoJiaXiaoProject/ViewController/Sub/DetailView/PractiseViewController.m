//
//  PractiseViewController.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "PractiseViewController.h"
#import "LeafLevelModel.h"
#import "NSString+ChangeBR.h"

@interface PractiseViewController ()

@property (nonatomic,assign) BOOL isShowAnswer;

@end

@implementation PractiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isShowAnswer = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)commitItem:(id)sender
{
    if (self.segmentNow.selectedSegmentIndex == UISegmentedControlNoSegment) {
        return;
    }
    NSString *str  = @"回答错误";
    if ([self.segmentNowArry[self.segmentNow.selectedSegmentIndex] isEqualToString:self.leafItem.manswer]) {
        str = @"回答正确";
    }
    self.answer.text = str;
    
    if (!_isShowAnswer) {
        [self showAnswer];
        _isShowAnswer = YES;
    }
}



- (void)beforItem:(id)sender
{
    [super beforItem:sender];
    self.segmentNow.selectedSegmentIndex = UISegmentedControlNoSegment;
    _isShowAnswer = NO;
}

- (void)nextItem:(id)sender
{
    [super nextItem:sender];
    self.segmentNow.selectedSegmentIndex = UISegmentedControlNoSegment;
    _isShowAnswer = NO;
}


@end
