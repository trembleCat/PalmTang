//
//  DCPagerController.h
//  CDDPagerController
//
//  Created by apple on 2017/9/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//



#import <UIKit/UIKit.h>

#import "DCPagerMacros.h"

@interface DCPagerController : UIViewController


/**
 根据角标，跳转到对应的控制器（viewWillAppear方法里实现）
 */
@property (nonatomic, assign) NSInteger selectIndex;

/**
 字体缩放
 */
- (void)setUpTitleScale:(void(^)(CGFloat *titleScale))titleScaleBlock;

/**
 设置导航栏隐藏后需重新调用此方法才有效(自定义方法)
 */
- (void)setUpBase;
/**
 progress设置
 *progressLength        设置progress长度
 *progressHeight        设置progress高度
 */
- (void)setUpProgressAttribute:(void(^)(CGFloat *progressLength, CGFloat *progressHeight))settingProgressBlock;

/**
 初始化
 
 *titleScrollViewBgColor 标题背景色
 *norColor               标题字体未选中状态下颜色
 *selColor               标题字体选中状态下颜色
 *proColor               字体下方指示器颜色
 *titleFont              标题字体大小
 *isShowPregressView     是否开启字体下方指示器
 *isOpenStretch          是否开启指示器拉伸效果
 *isOpenShade            是否开启字体渐变效果

 @param BaseSettingBlock 设置基本属性
 */
- (void)setUpDisplayStyle:(void(^)(UIColor **titleScrollViewBgColor,UIColor **norColor,UIColor **selColor,UIColor **proColor,UIFont **titleFont,BOOL *isShowPregressView,BOOL *isOpenStretch,BOOL *isOpenShade))BaseSettingBlock;

@end
