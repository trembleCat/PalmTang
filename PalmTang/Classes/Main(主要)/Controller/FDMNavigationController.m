//
//  FDMNavigationController.m
//  PalmTang
//
//  Created by 发抖的喵 on 2018/9/23.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import "FDMNavigationController.h"

@interface FDMNavigationController ()<UIGestureRecognizerDelegate>

//测设测试测试
@end

@implementation FDMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
//    实现边框/全屏滑动返回
    self.interactivePopGestureRecognizer.delegate = self;

}
#pragma mark -pushViewController
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //判断是否为根控制器，根控制器不隐藏tabbar
    
    if ( self.childViewControllers.count > 0) {
        //非根控制器
        viewController.hidesBottomBarWhenPushed = YES;
        //修改返回样式
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backButton addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
        
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView: backButton];
        viewController.navigationItem.leftBarButtonItem = leftButtonItem;
    };
    
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    
    [self popViewControllerAnimated:YES];
    
}

#pragma mark -实现边框滑动返回（当滑动的时候是否返回）避免跟控制器返回假死
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    return self.childViewControllers.count >1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
