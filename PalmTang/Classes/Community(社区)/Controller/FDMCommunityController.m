//
//  FDMCommunityController.m
//  PalmTang
//
//  Created by 发抖的喵 on 2018/9/23.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import "FDMCommunityController.h"
#import "FDMInterflowController.h"
#import "FDMConfessionController.h"
#import "FDMMarketController.h"

@interface FDMCommunityController ()

@end

@implementation FDMCommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置的导航栏隐藏
    [self.navigationController setNavigationBarHidden:YES];
    //重新计算控制器位置
    [self setUpBase];
    
    [self addSegmentController];
}

#pragma mark - 设置父子控制器
- (void)addSegmentController {
    
    [self setUpAllChildViewController];
    
    [self setUpDisplayStyle:^(UIColor *__autoreleasing *titleScrollViewBgColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIColor *__autoreleasing *proColor, UIFont *__autoreleasing *titleFont, BOOL *isShowProgressView, BOOL *isOpenStretch, BOOL *isOpenShade) {
        *titleScrollViewBgColor = [UIColor whiteColor]; //标题View背景色（默认标题背景色为白色）
        *norColor = [UIColor darkGrayColor];            //标题未选中颜色（默认未选中状态下字体颜色为黑色）
        *selColor = [UIColor orangeColor];              //标题选中颜色（默认选中状态下字体颜色为红色）
        *proColor = [UIColor redColor];              //滚动条颜色（默认为标题选中颜色）
        *titleFont = [UIFont systemFontOfSize:14];      //字体尺寸 (默认fontSize为15)
        
        /*
         以下BOOL值默认都为NO
         */
        *isShowProgressView = YES;                      //是否开启标题下部Pregress指示器
        *isOpenStretch = YES;                           //是否开启指示器拉伸效果
        *isOpenShade = YES;                             //是否开启字体渐变
    }];
    
    
    [self setUpTitleScale:^(CGFloat *titleScale) { //titleScale范围在0到1之间  <0 或者 > 1 则默认不缩放 默认设置titleScale就开启缩放，不设置则关闭
        *titleScale = 0.2;
    }];
    
    
    [self setUpProgressAttribute:^(CGFloat *progressLength, CGFloat *progressHeight) {//progressLength 设置底部progress指示器的长度，有默认值为按钮的宽度的百分之56  progressHeight默认高度4(并且不能大于10)
        *progressLength = 115;
        *progressHeight = 2;
    }];
    
}

#pragma mark - 添加所有子控制器
- (void)setUpAllChildViewController
{
    
    FDMInterflowController *interflowVC = [[FDMInterflowController alloc]init];
    interflowVC.title = @"唐院社区";
    FDMConfessionController *confessionVC = [[FDMConfessionController alloc]init];
    confessionVC.title = @"唐院表白墙";
    FDMMarketController *marketVC = [[FDMMarketController alloc]init];
    marketVC.title = @"唐院市场";
    
    [self addChildViewController:interflowVC];
    [self addChildViewController:confessionVC];
    [self addChildViewController:marketVC];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
