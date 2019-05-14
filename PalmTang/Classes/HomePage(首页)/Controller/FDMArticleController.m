//
//  FDMArticleController.m
//  PalmTang
//
//  Created by 发抖喵 on 2018/11/11.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import "FDMArticleController.h"

@interface FDMArticleController ()

@end

@implementation FDMArticleController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addBasicsView];
}

- (void)addBasicsView{

    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:NO];
}


@end
