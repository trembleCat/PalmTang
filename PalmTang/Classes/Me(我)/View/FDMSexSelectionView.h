//
//  FDMSexSelectionView.h
//  PalmTang
//
//  Created by 发抖喵 on 2018/11/7.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FDMSexSelectionView : UIView

@property (nonatomic, copy) NSString *sex;

+ (instancetype)loadSexSelectionView;

@end

NS_ASSUME_NONNULL_END
