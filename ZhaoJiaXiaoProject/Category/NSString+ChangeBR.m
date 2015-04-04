//
//  NSString+ChangeBR.m
//  ZhaoJiaXiaoProject
//
//  Created by TBXark on 15-4-4.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "NSString+ChangeBR.h"

@implementation NSString (ChangeBR)

- (NSString *)changeBrToEnter
{
    return [self stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
}
@end
