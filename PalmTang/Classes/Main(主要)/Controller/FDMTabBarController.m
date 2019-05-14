//
//  FDMTabBarController.m
//  PalmTang
//
//  Created by 发抖的喵 on 2018/9/23.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import "FDMTabBarController.h"
#import "FDMNavigationController.h"

#import "FDMHomePageController.h"
#import "FDMCommunityController.h"
#import "FDMFavourController.h"
#import "FDMMeController.h"

@interface FDMTabBarController ()

@end

@implementation FDMTabBarController

+(void)load{
    
    //修改tabBar字体颜色
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addNavigationBar];
    [self setNavigationBar];
    
}

- (void)addNavigationBar {
    
    FDMHomePageController *homePageVC = [[FDMHomePageController alloc]init];
    FDMCommunityController *communityVC = [[FDMCommunityController alloc]init];
    FDMFavourController *favourVC = [[FDMFavourController alloc]init];
    FDMMeController *meVC = [[FDMMeController alloc]init];
    
    FDMNavigationController *homePageNAV = [[FDMNavigationController alloc]initWithRootViewController: homePageVC];
    FDMNavigationController *communityNAV = [[FDMNavigationController alloc]initWithRootViewController: communityVC];
    FDMNavigationController *favourNAV = [[FDMNavigationController alloc]initWithRootViewController: favourVC];
    FDMNavigationController *meNAV = [[FDMNavigationController alloc]initWithRootViewController: meVC];
    
    [self addChildViewController:homePageNAV];
    [self addChildViewController:communityNAV];
    [self addChildViewController:favourNAV];
    [self addChildViewController:meNAV];
}

- (void)setNavigationBar {
    
    FDMNavigationController *nav0 = self.childViewControllers[0];
    nav0.tabBarItem.title = @"首页";
    nav0.tabBarItem.image = [UIImage imageNamed:@"tabBar_HomePage_icon"];
    nav0.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_HomePage_click_icon"];
    
    FDMNavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"社区";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_Community_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_Community_click_icon"];
    
    FDMNavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"消息";
    nav2.tabBarItem.image = [UIImage imageNamed:@"tabBar_Favour_icon"];
    nav2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_Favour_click_icon"];
    
    FDMNavigationController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"我的";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_Me_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_Me_click_icon"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
