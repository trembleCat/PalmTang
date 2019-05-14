//
//  FDMVoiceController.m
//  PalmTang
//
//  Created by 发抖的喵 on 2018/9/23.
//  Copyright © 2018年 fdm. All rights reserved.
//


#pragma mark -当前为唐院之声控制器


#import "FDMVoiceController.h"
#import "FDMArticleController.h"

#import "FDMVoiceViewCell.h"

@interface FDMVoiceController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableV;

@end

@implementation FDMVoiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:236.0f/255.0f blue:236.0f/255.0f alpha:1.0];
    
    [self addBasicsView];
}

#pragma mark- addBasicsView
- (void)addBasicsView{
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - screenTabBarH - screenNavH - 20)];
    tableV.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.rowHeight = 200;
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏分割线
    tableV.showsVerticalScrollIndicator = NO;
    tableV.showsHorizontalScrollIndicator = NO;
    [tableV registerNib:[UINib nibWithNibName:@"FDMVoiceViewCell" bundle:nil] forCellReuseIdentifier:@"VoiceCell"];
    [self.view addSubview:tableV];
    self.tableV = tableV;
    
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    tableV.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FDMVoiceViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VoiceCell"];
//    cell.imageUrl = @"http://img0.imgtn.bdimg.com/it/u=1486826859,4031998705&fm=200&gp=0.jpg";
    cell.imageUrl = @"https://ss0.baidu.com/7Po3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=0620f1c8dc43ad4bb92e40c0b2025a89/03087bf40ad162d92dc06e711cdfa9ec8a13cdb5.jpg";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FDMArticleController *ArticleC = [[FDMArticleController alloc]init];
    [self.navigationController pushViewController:ArticleC animated:YES];
}


#pragma mark- 下拉刷新
- (void)refreshHeader{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableV.mj_header endRefreshing];
    });
}

#pragma mark- 上拉加载
- (void)refreshFooter{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableV.mj_footer endRefreshing];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
