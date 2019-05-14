//
//  FDMModifyController.h
//  PalmTang
//
//  Created by 发抖喵 on 2018/11/6.
//  Copyright © 2018年 fdm. All rights reserved.
//
#pragma mark- 修改信息控制器

#import <UIKit/UIKit.h>
@class FDMUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface FDMModifyController : UITableViewController

@property (nonatomic , strong) FDMUserModel *userM;
@property (nonatomic , copy) NSString *IconUrl;

@end

NS_ASSUME_NONNULL_END
