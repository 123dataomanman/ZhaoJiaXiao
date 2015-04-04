//
//  DataSource.h
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataModel;

typedef void(^ConfigureCell)(id item,id cell);

@interface DataSource : NSObject<UITableViewDataSource>

- (instancetype)initWithTableName:(NSString *)tableName indexArry:(NSArray *)arry configureBlock:(ConfigureCell)block;

- (DataModel *)findDataModelWithIndex:(NSInteger)index;
- (DataModel *)findDataModelWithIndexPath:(NSIndexPath *)indexPath;


@end
