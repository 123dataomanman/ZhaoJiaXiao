//
//  ResultTableViewCell.h
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UILabel *manswer;
@property (weak, nonatomic) IBOutlet UILabel *tanswer;

@end
