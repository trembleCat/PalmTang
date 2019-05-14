//
//  FDMCollectionViewCell.h
//  PalmTang
//
//  Created by 发抖喵 on 2018/10/31.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDMCollectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FDMCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) FDMCollectionModel *model;

@end

NS_ASSUME_NONNULL_END
