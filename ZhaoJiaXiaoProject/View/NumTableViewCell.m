//
//  NumTableViewCell.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-4.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "NumTableViewCell.h"
#import "NumberSegmentedControl.h"

@implementation NumTableViewCell

- (void)awakeFromNib {
    [_numSegment configureNumberSegmented];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
