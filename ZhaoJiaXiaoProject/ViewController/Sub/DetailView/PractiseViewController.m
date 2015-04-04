//
//  PractiseViewController.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "PractiseViewController.h"
#import "LeafLevelModel.h"

@interface PractiseViewController ()

@end

@implementation PractiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)commitItem:(id)sender
{
    NSString *str  = @"回答错误";
    if ([self.segmentNowArry[self.segmentNow.selectedSegmentIndex] isEqualToString:self.leafItem.manswer]) {
        str = @"回答正确";
    }
    self.answer.text = str;
}

- (void)beforItem:(id)sender
{
    self.segmentNow.selectedSegmentIndex = UISegmentedControlNoSegment;
}

- (void)nextItem:(id)sender
{
    self.segmentNow.selectedSegmentIndex = UISegmentedControlNoSegment;
}


@end
