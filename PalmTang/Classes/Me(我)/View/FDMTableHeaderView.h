//
//  FDMTableHeaderView.h
//  PalmTang
//
//  Created by 发抖喵 on 2018/10/30.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FDMTableHeaderModel.h"

@interface FDMTableHeaderView : UIView

@property (nonatomic, weak) IBOutlet UIButton *clickHeaderView;
@property (nonatomic, strong) FDMTableHeaderModel *headerModel;

+(instancetype)loadHeaderView;

@end
