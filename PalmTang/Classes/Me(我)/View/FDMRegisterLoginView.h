//
//  FDMRegisterLoginView.h
//  PalmTang
//
//  Created by 发抖喵 on 2018/11/1.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FDMRegisterLoginViewDelegate <NSObject>

- (void)loadLoginData;

@end

@interface FDMRegisterLoginView : UIView

@property (nonatomic ,copy) NSString *account;
@property (nonatomic ,copy) NSString *passWord;

@property (nonatomic,weak) id <FDMRegisterLoginViewDelegate> delegate;

+ (instancetype)RegisterLoginView;

@end

NS_ASSUME_NONNULL_END
