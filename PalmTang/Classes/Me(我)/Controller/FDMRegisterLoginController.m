//
//  FDMRegisterController.m
//  PalmTang
//
//  Created by 发抖喵 on 2018/11/1.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import "FDMRegisterLoginController.h"

#import "FDMUserModel.h"

#import "FDMRegisterLoginView.h"

#import <MJExtension/MJExtension.h>

@interface FDMRegisterLoginController ()<FDMRegisterLoginViewDelegate>

//关闭按钮
@property (nonatomic,weak) UIButton *closeBtn;
//登录块
@property (nonatomic , weak) FDMRegisterLoginView *rlView;

@property (nonatomic , weak) AFHTTPSessionManager *manager;

@end

@implementation FDMRegisterLoginController

- (AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //添加基础视图
    [self addBasicsView];
    //布局基础视图
    [self lauoutBasicsView];

}

#pragma mark- 添加基础视图
- (void)addBasicsView{
    
    //背景图片
    UIButton *backGround = [UIButton buttonWithType:UIButtonTypeCustom];
    [backGround setFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [backGround setBackgroundImage:[UIImage imageNamed:@"register_background"] forState:UIControlStateNormal];
    [backGround setBackgroundImage:[UIImage imageNamed:@"register_background"] forState:UIControlStateHighlighted];
    [self.view addSubview:backGround];
    
    //返回按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeBtn setImage:[UIImage imageNamed:@"register_close"]forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(clickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
    self.closeBtn = closeBtn;
    [self.view addSubview:closeBtn];
    
    //登录块
    FDMRegisterLoginView *rlView = [FDMRegisterLoginView RegisterLoginView];
    rlView.delegate = self;
    self.rlView = rlView;
    [self.view addSubview:rlView];
    
}

#pragma mark- 布局基础视图
- (void)lauoutBasicsView{
    
    //返回按钮
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@30);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.top.equalTo(self.view.mas_top).offset(50);
    }];
    //登录块
    [self.rlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@150);
        make.height.equalTo(@400);
    }];
    
}

#pragma mark- 点击调用方法
- (void)clickCloseBtn{
    
    //返回上一界面
    [self dismissViewControllerAnimated:YES completion:^{
   
    }];
}

#pragma mark- 联网加载登录数据
- (void)loadLoginData{
    
    
    if (self.rlView.account.length > 0 && self.rlView.passWord.length > 0) {
        //NSLog(@"可以进行网络连接");
        
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        [SVProgressHUD setDefaultAnimationType:(SVProgressHUDAnimationTypeNative)];
        [SVProgressHUD showWithStatus:@"正在登陆"];
        
        [self loadData];
        
    }else{
        UIAlertController *errorVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的账号密码" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *errorA = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //NSLog(@"确定")
        }];
        
        [errorVC addAction:errorA];
        [self presentViewController:errorVC animated:YES completion:^{  }];
    }
    
}

- (void)loadData{
    
        NSMutableDictionary *para = [NSMutableDictionary dictionary];
        para[@"user"] = [NSString stringWithFormat:@"%@",self.rlView.account ];
        para[@"pass"] = [NSString stringWithFormat:@"%@",self.rlView.passWord ];
    
        [self.manager POST:loginUrl parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            FDMUserModel *userM = [FDMUserModel mj_objectWithKeyValues:responseObject];
            
            //收到的数据长度为0，说明账号密码不正确
            if (userM.ids.length <= 0) {
                [SVProgressHUD dismiss];
                
                UIAlertController *errorVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号密码不正确，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *errorA = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {  }];
                [errorVC addAction:errorA];
                [self presentViewController:errorVC animated:YES completion:^{  }];
                
            }else{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"FDMMeContrillerReloadData" object:userM];
                [self clickCloseBtn];
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
                [SVProgressHUD dismiss];
                [SVProgressHUD showImage:[UIImage imageNamed:@"error"] status:@"网络开小差啦，请稍后重试"];
                [SVProgressHUD dismissWithDelay:2.0f];
            
            }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

//界面即将消失时
- (void) viewWillDisappear:(BOOL)animated{
    
    //退出界面前关闭正在运行的HUD
    [SVProgressHUD dismiss];
    //取消之前的网络请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    self.rlView.delegate = nil;
    
}

@end
