//
//  NumTableViewCell.h
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-4.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NumberSegmentedControl;

@interface NumTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NumberSegmentedControl *numSegment;

@end
