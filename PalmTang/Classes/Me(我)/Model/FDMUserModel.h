//
//  FDMUserModel.h
//  PalmTang
//
//  Created by 发抖喵 on 2018/11/2.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FDMUserModel : NSObject

@property (nonatomic ,copy) NSString *ids;
@property (nonatomic ,copy ) NSString *uid;
//账号
@property (nonatomic ,copy) NSString *user;
// 密码
@property (nonatomic ,copy) NSString *pass;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,assign) NSInteger age;
@property (nonatomic ,copy) NSString *sex;
@property (nonatomic ,copy) NSString *tel;
@property (nonatomic ,copy) NSString *address;
@property (nonatomic ,copy) NSString *major;

NS_ASSUME_NONNULL_END
@end

