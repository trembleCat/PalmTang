//
//  FDMFocusWebController.m
//  PalmTang
//
//  Created by 发抖喵 on 2018/11/2.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import "FDMFocusWebController.h"

#import <WebKit/WebKit.h>

@interface FDMFocusWebController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic , weak) WKWebView *webV;

@end

@implementation FDMFocusWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = self.webTitle;
    
    //刷新网页
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshWeb)];
    item.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = item;
    
    //添加基础视图
    [self addBasicsView];
    
}
//刷新网页
- (void)refreshWeb{
    
    [self.webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.url]]]];
}
//添加基础视图
- (void)addBasicsView{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    WKWebView *webV = [[WKWebView alloc]initWithFrame:self.view.bounds];

    [webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.url]]]];
    //开了支持滑动返回
    webV.allowsBackForwardNavigationGestures = YES;
    webV.navigationDelegate = self;
    webV.UIDelegate = self;
    
    
    self.webV = webV;
    [self.view addSubview:webV];
}

// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    [SVProgressHUD dismiss];
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变

}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [SVProgressHUD dismiss];
    [SVProgressHUD showImage:[UIImage imageNamed:@"error"] status:@"内容加载失败请重新加载"];
    [SVProgressHUD dismissWithDelay:2.0];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
    self.webV = nil;
}



@end
