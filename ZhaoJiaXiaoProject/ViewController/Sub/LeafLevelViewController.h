//
//  LeafLevelViewController.h
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecondLevelModel;
@class LeafLevelModel;

@interface LeafLevelViewController : UIViewController

@property (nonatomic,strong) SecondLevelModel *secondItem;
@property (strong,nonatomic) NSArray *indexArry;
@property (assign,nonatomic) NSInteger indexNum;

@property (strong,nonatomic) LeafLevelModel *leafItem;
@property (strong,nonatomic) UITextView *detial;


@property (strong,nonatomic) UISegmentedControl *selectSegmented;
@property (strong,nonatomic) UISegmentedControl *judgeSegmented;
@property (strong,nonatomic) UISegmentedControl *segmentNow;

@property (strong,nonatomic) NSArray *selectSegmentedControlItem;
@property (strong,nonatomic) NSArray *judgeSegmentedControlItem;
@property (strong,nonatomic) NSArray *segmentNowArry;

@property (strong,nonatomic) UILabel *answer;
@property (assign,nonatomic) BOOL isSelectType;


- (void)beforItem:(id)sender;
- (void)nextItem:(id)sender;
- (void)commitItem:(id)sender;
- (void)changeText;
- (void)changeImage;
- (void)changeSegment;
- (void)showAnswer;
- (void)segmentValueChange:(UISegmentedControl *)segment;

@end
