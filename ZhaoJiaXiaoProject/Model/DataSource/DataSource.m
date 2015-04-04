//
//  DataSource.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "DataSource.h"
#import "DataModel.h"
#import "DataModelBuilder.h"

@interface DataSource ()

@property (nonatomic,copy) NSString *tableName;
@property (nonatomic,strong) NSArray *indexArry;
@property (nonatomic,strong) NSMutableDictionary *itemDict;
@property (nonatomic,copy) ConfigureCell configureBlock;

@end

@implementation DataSource

- (instancetype)initWithTableName:(NSString *)tableName indexArry:(NSArray *)arry configureBlock:(ConfigureCell)block
{
    self = [super init];
    if (self) {
        _tableName = tableName;
        _indexArry = arry;
        _itemDict = [[NSMutableDictionary alloc] init];
        _configureBlock = [block copy];
    }
    
    return self;
}
- (DataModel *)findDataModelWithIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    DataModel *model = [_itemDict objectForKey:indexPath];
    if (model == nil) {
        model = [DataModelBuilder buildDataModelWithTableName:_tableName serialNumber:_indexArry[index]];
    }
    return model;
}

- (DataModel *)findDataModelWithIndexPath:(NSIndexPath *)indexPath
{
    DataModel *model = [_itemDict objectForKey:indexPath];
    if (model == nil) {
        model = [DataModelBuilder buildDataModelWithTableName:_tableName serialNumber:_indexArry[indexPath.row]];
    }
    return model;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _indexArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_tableName forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.numberOfLines = 0;
    DataModel *model = [self findDataModelWithIndexPath:indexPath];
    _configureBlock(model,cell);
    return cell;
}

@end
