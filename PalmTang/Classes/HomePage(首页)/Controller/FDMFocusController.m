//
//  FDMFocusController.m
//  PalmTang
//
//  Created by 发抖的喵 on 2018/9/23.
//  Copyright © 2018年 fdm. All rights reserved.
//


#pragma mark- 当前为唐院热点控制器


#import "FDMFocusController.h"
#import "FDMFocusWebController.h"

#import "FDMCollectionViewCell.h"

#import "FDMCollectionModel.h"

#import <SDCycleScrollView/SDCycleScrollView.h>
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>

@interface FDMFocusController ()<UICollectionViewDelegate,UICollectionViewDataSource>

//无限轮播
@property (nonatomic ,weak ) SDCycleScrollView *loopSV;

@property (nonatomic ,weak) UICollectionView *colView;
@property (nonatomic ,strong) UICollectionViewFlowLayout *colLayout;

@property (nonatomic , weak) AFHTTPSessionManager *manager;

//列表数据
@property (nonatomic , strong) NSMutableArray *aryData;


@end

@implementation FDMFocusController

static NSString *const cellID = @"CollectionViewCell";    //注册CollectionViewCell
static NSString *const headerViewID = @"CollectionViewHeaderView";    //注册CollectionViewHeader

- (AFHTTPSessionManager *)manager{
    
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}

//列表数据
- (NSMutableArray *)aryData{
    
    if (_aryData == nil) {
        _aryData = [NSMutableArray array];
    }
    return  _aryData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加基础视图
    [self addBasicsView];
    //设置CollectionView视图
    [self setCollectionView];
    //上拉刷新加载网络数据
    [self MJRHeaderAction];
}
#pragma mark- 添加基础视图
- (void)addBasicsView{
    
/*
 *添加UICollectionView
 */
    UICollectionViewFlowLayout *colLayout = [[UICollectionViewFlowLayout alloc]init];
    self.colLayout = colLayout;
    
    UICollectionView *colView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - screenTabBarH - screenNavH - 20) collectionViewLayout:colLayout];
    self.colView = colView;
    
    [self.view addSubview:colView];
    
}
#pragma mark- 设置CollectionView视图
- (void)setCollectionView{

/*
 *  设置UICollectionView
 */
    self.colView.delegate = self;
    self.colView.dataSource = self;
    
    //隐藏滚动条
    self.colView.showsVerticalScrollIndicator = NO;
    self.colView.showsHorizontalScrollIndicator = NO;
   self. colView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    //布局
    self.colLayout.minimumInteritemSpacing = 5;
    self.colLayout.minimumLineSpacing = 8;
    self.colLayout.itemSize = CGSizeMake(screenWidth *0.5 - 10, screenWidth *0.5 - 30);
    self.colLayout.headerReferenceSize = CGSizeMake(screenWidth, 170);
    
    //注册cell和 header视图、footer视图
    [self.colView registerNib:[UINib nibWithNibName:NSStringFromClass([FDMCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier: cellID];
    [self.colView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewID];
    //    [colView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CollectionViewFooterView"];
    
    //设置CollectionView下拉刷新和上拉加载
    self.colView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MJRHeaderAction)];
    self.colView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(MJRFooterAction)];
    
}

#pragma mark- 下拉刷新加载
- (void)MJRHeaderAction{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"update"] = [NSString stringWithFormat:@"%ld",self.aryData.count];
    parameters[@"count"] = @"-1";
    
    if ([self.colView.mj_footer isHidden]) {
        [self.colView.mj_footer setHidden:NO];
    }
    
    //开始刷新
    [self.manager POST:newUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            self.aryData = [FDMCollectionModel mj_objectArrayWithKeyValuesArray:responseObject];
            [self.colView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self SVPHUDsetImage:[UIImage imageNamed:@"error"] status:@"网络开小差了，请重新刷新" delay:2.0];
    }];
    
    //延迟调用停止刷新，增加用户体验
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.colView.mj_header endRefreshing];
    });
}

#pragma mark- 上拉刷新加载
- (void)MJRFooterAction{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"count"] = [NSString stringWithFormat:@"%ld",self.aryData.count];
    parameters[@"update"] = @"-1";
        //开始刷新
    [self.manager POST:newUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *ary = [FDMCollectionModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        if (ary.count == 0) {
            //没有数据了
            [self SVPHUDsetImage:[UIImage imageNamed:@"yes"] status:@"已经全部加载完毕" delay:2.0];
            [self.colView.mj_footer setHidden:YES];
        }else{
            
            [self.aryData addObjectsFromArray:ary];
            [self.colView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self SVPHUDsetImage:[UIImage imageNamed:@"error"] status:@"网络开小差了，请重新刷新" delay:2.0];
    }];
    
    //延迟调用停止刷新，防止上拉多次刷新
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.colView.mj_footer endRefreshing];
    });
}

#pragma mark- UICollectionView数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

        return self.aryData.count;
}
//设置item Cell
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FDMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: cellID forIndexPath:indexPath];
    FDMCollectionModel *mod = self.aryData[indexPath.row];
    cell.model = mod;
    
    return cell;
    
}
//设置头部 或者 底部的view
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewID forIndexPath:indexPath];
    /**添加轮播图*/
    
    NSString *url1 = [Url stringByAppendingString:@"/indexPic/index1.jpg"];
    NSString *url2 = [Url stringByAppendingString:@"/indexPic/index2.jpg"];
    NSString *url3 = [Url stringByAppendingString:@"/indexPic/index3.jpg"];
    NSString *url4 = [Url stringByAppendingString:@"/indexPic/index4.jpg"];
    
    NSMutableArray *aryUrl = [NSMutableArray array];
    [aryUrl addObjectsFromArray:@[url1,url2,url3,url4]];
    
    SDCycleScrollView *loopSV = [SDCycleScrollView cycleScrollViewWithFrame:headerView.bounds imageURLStringsGroup:aryUrl];
    
    self.loopSV = loopSV;
    [headerView addSubview:loopSV];
    
    return headerView;
}

//设置每个collection的cell的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 5, 5);
}

//点击cell调用d方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FDMFocusWebController *webVC = [[FDMFocusWebController alloc]init];
    FDMCollectionModel *mod = self.aryData[indexPath.row];
    webVC.url = mod.url;
    webVC.webTitle = mod.title;
    [self.navigationController pushViewController:webVC animated:YES];
}




//快捷HUD
- (void)SVPHUDsetImage:(UIImage *)image status:(NSString *)status delay:(NSTimeInterval)time{
    
    [SVProgressHUD dismiss];
    [SVProgressHUD showImage:image status:status];
    [SVProgressHUD dismissWithDelay:time];
    
}


- (void)viewWillDisappear:(BOOL)animated{
    
    //清理轮播图缓存的图片
    [self.loopSV clearCache];
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    //清理轮播图缓存的图片
    [self.loopSV clearCache];
    
}




@end
