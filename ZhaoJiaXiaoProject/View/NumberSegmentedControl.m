//
//  NumberSegmentedControl.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-4.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "NumberSegmentedControl.h"

@implementation NumberSegmentedControl

- (void)configureNumberSegmented
{
    if (_isCongfigure) {
        return;
    }
    _numValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"numValue"];
    NSString *temp = [NSString stringWithFormat:@"%ld",(long)_numValue];
    [self removeSegmentAtIndex:0 animated:NO];
    [self removeSegmentAtIndex:0 animated:NO];
    [self insertSegmentWithTitle:@"-" atIndex:0 animated:NO];
    [self insertSegmentWithTitle:temp atIndex:1 animated:NO];
    [self insertSegmentWithTitle:@"+" atIndex:2 animated:NO];
    [self setEnabled:NO forSegmentAtIndex:1];
    [self addTarget:self action:@selector(segmentValueChange:) forControlEvents:UIControlEventValueChanged];
    self.tintColor = [UIColor grayColor];
    _isCongfigure = YES;
    self.selectedSegmentIndex = 1;
}

- (void)segmentValueChange:(id)sender
{
    if (self.selectedSegmentIndex == 1) {
        return;
    }
    if (self.selectedSegmentIndex == 0 && _numValue > 0) {
        self.numValue = _numValue-1;
    }else if (self.selectedSegmentIndex == 2)
    {
        self.numValue = _numValue+1;
    }
    NSString *tittle = [NSString stringWithFormat:@"%ld",(long)_numValue];
    [self setTitle:tittle forSegmentAtIndex:1];
    self.selectedSegmentIndex = 1;
}

- (void)setNumValue:(NSInteger)numValue
{
    _numValue = numValue;
    [[NSUserDefaults standardUserDefaults] setInteger:numValue forKey:@"numValue"];
}


@end
