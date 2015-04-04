//
//  DataModelBuilder.h
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-3.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataModel;
@interface DataModelBuilder : NSObject

+ (DataModel *)buildDataModelWithTableName:(NSString *)tableName serialNumber:(NSNumber *)serial;

@end
