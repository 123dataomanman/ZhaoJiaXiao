//
//  DataModel.h
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"

@interface DataModel : NSObject

@property (nonatomic,assign) NSInteger serial;


- (instancetype)initWithTableName:(NSString *)table serialNumber:(NSNumber *)serial;
- (void)configureWithFMResultSet:(FMResultSet *)set;

@end
