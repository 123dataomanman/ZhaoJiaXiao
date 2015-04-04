//
//  NumberSegmentedControl.h
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-4.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberSegmentedControl : UISegmentedControl

@property (assign,nonatomic) NSInteger numValue;
@property (assign,nonatomic) BOOL isCongfigure;

- (void)configureNumberSegmented;

@end
