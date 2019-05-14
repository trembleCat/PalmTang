//
//  FDMTableHeaderModel.h
//  PalmTang
//
//  Created by 发抖喵 on 2018/11/2.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FDMTableHeaderModel : NSObject

@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *uid;
@property (nonatomic ,copy) NSString *iconUrl;
//name下边的提示文字
@property (nonatomic ,copy) NSString *userAutograph;

@end

NS_ASSUME_NONNULL_END
