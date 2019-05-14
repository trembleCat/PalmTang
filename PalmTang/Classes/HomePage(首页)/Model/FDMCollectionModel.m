//
//  FDMCollectionModel.m
//  PalmTang
//
//  Created by 发抖喵 on 2018/11/2.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import "FDMCollectionModel.h"
#import <MJExtension/MJExtension.h>

@implementation FDMCollectionModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ids":@"id"};
}

@end
