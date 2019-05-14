//
//  FDMHomePageController.m
//  PalmTang
//
//  Created by 发抖的喵 on 2018/9/23.
//  Copyright © 2018年 fdm. All rights reserved.


#pragma mark -当前为父子控制器总控制器


#import "FDMHomePageController.h"
#import "FDMFocusController.h"
#import "FDMVoiceController.h"


@interface FDMHomePageController ()

@end

@implementation FDMHomePageController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //界面即将显示的时候隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor redColor];
    
    //设置的导航栏隐藏
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    //重新计算控制器位置
    [self setUpBase];
    
    //添加子控制器
    [self addSegmentController];
    
    
    //网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NetWorkStatesChange:) name:@"netWorkChangeEventNotification" object:nil];
    
}

#pragma mark - 设置父子控制器
- (void)addSegmentController {
    
//            self.navigationController.navigationBar.translucent = NO;
    
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
//        *progressLength = 128;
        *progressHeight = 2;
    }];
    
}

#pragma mark - 添加所有子控制器
- (void)setUpAllChildViewController
{
    
    FDMFocusController *focusVC = [[FDMFocusController alloc]init];
    focusVC.title = @"唐院热点";
    FDMVoiceController *voiceVC = [[FDMVoiceController alloc]init];
    voiceVC.title = @"唐院之声";
    
    [self addChildViewController:focusVC];
    [self addChildViewController:voiceVC];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 网络状态发生变化通知方法
-(void)NetWorkStatesChange:(NSNotification *)sender{
    int networkState = [[sender object] intValue];
    switch (networkState) {
        case -1:
            //未知网络状态  
            break;
            
        case 0:
            //没有网络
            
            [SVProgressHUD showImage:[UIImage imageNamed:@"error"] status:@"当前没有网络,请检查网络设置"];
            [SVProgressHUD dismissWithDelay:1.5f];
            break;
            
        case 1:
            //3G或者4G，反正用的是流量

            break;
            
        case 2:
            //WIFI网络
            break;
            
        default:
            break;
    }
}



@end
