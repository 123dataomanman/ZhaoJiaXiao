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


@protocol DataSource <NSObject>

@optional
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface DataSource : NSObject<UITableViewDataSource>


@property (nonatomic,assign) BOOL tableCanEdit;
@property (nonatomic,weak) id<DataSource> delegate;
@property (nonatomic,strong) NSArray *indexArry;
@property (nonatomic,strong) NSMutableDictionary *itemDict;

- (instancetype)initWithTableName:(NSString *)tableName indexArry:(NSArray *)arry configureBlock:(ConfigureCell)block;

- (DataModel *)findDataModelWithIndex:(NSInteger)index;
- (DataModel *)findDataModelWithIndexPath:(NSIndexPath *)indexPath;


@end
