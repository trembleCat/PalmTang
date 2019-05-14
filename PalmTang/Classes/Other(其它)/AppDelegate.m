//
//  AppDelegate.m
//  PalmTang
//
//  Created by 发抖的喵 on 2018/9/22.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import "AppDelegate.h"
#import "FDMTabBarController.h"


@interface AppDelegate ()
/*
 当前的网络状态
 */
@property(nonatomic,assign)int netWorkStatesCode;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    FDMTabBarController *vc = [[FDMTabBarController alloc]init];
    self.window.rootViewController = vc;
    [UITabBar appearance].translucent = NO; //恢复tabbar文字图片偏移
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    //网络监控-检测网络状态变化
    [self netWorkChangeEvent];
    
    return YES;
}

#pragma mark- 检测网络状态变化
-(void)netWorkChangeEvent
{
//    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    //设置默认网络为未知网络状态
    self.netWorkStatesCode =AFNetworkReachabilityStatusUnknown;
    //判断网络状态
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //设置默认网络为当前网络状态
        self.netWorkStatesCode = status;
        //判断网络状态
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
//                NSLog(@"当前使用的是流量模式");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
//                NSLog(@"当前使用的是wifi模式");
                break;
            case AFNetworkReachabilityStatusNotReachable:
//                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusUnknown:
//                NSLog(@"变成了未知网络状态");
                break;
                
            default:
                break;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"netWorkChangeEventNotification" object:@(status)];
    }];
    [manager.reachabilityManager startMonitoring];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
