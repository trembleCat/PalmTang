//
//  FDMMeController.m
//  PalmTang
//
//  Created by 发抖的喵 on 2018/9/23.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import "FDMMeController.h"
#import "FDMRegisterLoginController.h"
#import "FDMModifyController.h"
#import "FDMSettingController.h"

#import "FDMMeListModel.h"
#import "FDMUserModel.h"
#import "FDMTableHeaderModel.h"
#import "FDMListPicModel.h"

#import "FDMTableHeaderView.h"
#import "FDMMeTableViewCell.h"

#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>

@interface FDMMeController ()<UITableViewDelegate,UITableViewDataSource>

/**  tableView */
@property (nonatomic ,weak ) UITableView *meTableV;
@property (nonatomic ,weak ) FDMTableHeaderView *headerV;

@property (nonatomic ,strong) FDMUserModel *userM;
@property (nonatomic ,strong) FDMTableHeaderModel *headerM;
//列表
@property (nonatomic ,strong ) NSArray *aryList;

@end

@implementation FDMMeController

- (NSArray *)aryList{

    if (_aryList == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"FDMList" ofType:@"plist"];
        NSDictionary *diclist  = [NSDictionary dictionaryWithContentsOfFile:path];

        NSArray *ary = diclist[@"meList"];
        _aryList = [FDMMeListModel mj_objectArrayWithKeyValuesArray:ary];
    }
    return _aryList;
}

- (FDMTableHeaderModel *)headerM{
    
    if (_headerM == nil) {
        _headerM = [[FDMTableHeaderModel alloc]init];
    }
    return _headerM;
}

- (FDMUserModel *)userM{
    if (_userM == nil) {
        _userM = [[FDMUserModel alloc]init];
    }
    return _userM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    
    //添加基础视图
    [self addBasicsView];
    //视图自动布局
    [self layoutBasicsView];
    
    [self automaticLogin];
    //监听更新通知 - 信息更新 - 自动登录 - 退出登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FDMMeContrillerReloadData:) name:@"FDMMeContrillerReloadData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(automaticLogin) name:@"upLoadModify" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitLogon) name:@"exitLogon" object:nil];

}

#pragma mark- 添加基础视图
- (void)addBasicsView{
    
    //基础表
    UITableView *meTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:(UITableViewStyleGrouped)];
    meTableV.delegate = self;
    meTableV.dataSource = self;
    meTableV.rowHeight = 50;
    [self.view addSubview:meTableV];
    self.meTableV = meTableV;
    
    //表头View
    FDMTableHeaderView *headerV = [FDMTableHeaderView loadHeaderView];
    [headerV setFrame:CGRectMake(0, 0, screenWidth, 150)];
    [headerV.clickHeaderView addTarget:self action:@selector(clickHeaderV:) forControlEvents:UIControlEventTouchUpInside];
    self.headerV = headerV;
    [self.meTableV setTableHeaderView:headerV];
    
    //设置按钮
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [settingButton setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    [settingButton setFrame:CGRectMake(0, 0, 40, 30)];
    [settingButton addTarget:self action:@selector(clickSettingBtnItem) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView: settingButton];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
}

#pragma mark- 点击表头View
- (void)clickHeaderV:(UIButton *)sender{
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *user = [userDef objectForKey:@"user"];
    
    if (self.userM.name.length > 0 && user.length > 0) {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:NSStringFromClass([FDMModifyController class]) bundle:nil];
        FDMModifyController *modifyVC = [storyBoard instantiateInitialViewController];
        modifyVC.userM = self.userM;
        modifyVC.IconUrl = self.headerM.iconUrl;
        
        [self.navigationController pushViewController:modifyVC animated:YES];
    }else{
        
        FDMRegisterLoginController *registerVC = [[FDMRegisterLoginController alloc]init];
        [self presentViewController:registerVC animated:YES completion:^{
        }];
    }
}
#pragma mark- 点击设置按钮
- (void)clickSettingBtnItem{
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *user = [userDef objectForKey:@"user"];
    
    if (self.userM.name.length > 0 && user.length > 0) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([FDMSettingController class]) bundle:nil];
        FDMSettingController *settingVC = [storyboard instantiateInitialViewController];
        
        [self.navigationController pushViewController:settingVC animated:YES];
    }else{
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"error"] status:@"请先进行登录"];
        [SVProgressHUD dismissWithDelay:2.0f];
    }
}
#pragma mark- 视图自动布局
- (void)layoutBasicsView{
    
    //基础表
    [self.meTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark- 表数据和cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if (section == 0) {
        return 3;
        
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *const ID = @"Cell";                  //Cell注册ID
    
    FDMMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([FDMMeTableViewCell class]) owner:nil options:nil]firstObject];
        
    }
    //计算不同组的每一行在数组中的位置
    NSInteger index = 3 * indexPath.section;
    
    if (indexPath.section == 0) {
        FDMMeListModel *listModel = self.aryList[indexPath.row + index];  //第0组  index = 0 行数为数组下标 0 1 2
        cell.model = listModel;
    }else if(indexPath.section == 1){
        FDMMeListModel *listModel = self.aryList[indexPath.row + index];  //第1组   index = 1 行数为数组下标 3 4 5
        cell.model = listModel;
    }
    return cell;
}

#pragma mark- 表组间距
//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return 5.0f;
    }else{
        return 1.0f;
    }
}
//添加section头部View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    //自定义头部View
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 10)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}
//section尾部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 0) {
        return 9.0f;
    }else{
        return 10.0f;
    }
}
//添加section尾部View
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 1)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}

#pragma mark- 监听登录成功更新通知方法
- (void)FDMMeContrillerReloadData:(NSNotification *)sender{
    
    self.userM = sender.object;
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:[NSString stringWithFormat:@"%@",self.userM.user] forKey:@"user"];
    [userDef setObject:[NSString stringWithFormat:@"%@",self.userM.pass] forKey:@"pass"];

    self.headerM.name = self.userM.name;
    self.headerM.uid = self.userM.uid;
    self.headerM.userAutograph = @"查看或编辑个人信息";
    self.headerV.headerModel = self.headerM;

    [self downLoadIcon];
    [self.meTableV reloadData];
    
}
#pragma mark- 退出登录
- (void)exitLogon{
    FDMTableHeaderModel *headerModel =  [[FDMTableHeaderModel alloc]init];
    headerModel.name = @"登录后显示信息";
    headerModel.uid = @"";
    headerModel.iconUrl = @"";
    headerModel.userAutograph = @"";
    self.headerV.headerModel = headerModel;
}

#pragma mark- 自动登录
- (void)automaticLogin{
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    if ([userDef objectForKey:@"user"] && [userDef objectForKey:@"pass"]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSMutableDictionary *para = [NSMutableDictionary dictionary];
        para[@"user"] = [NSString stringWithFormat:@"%@",[userDef objectForKey:@"user"]];
        para[@"pass"] = [NSString stringWithFormat:@"%@",[userDef objectForKey:@"pass"]];
        
        [manager POST:loginUrl parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            self.userM = [FDMUserModel mj_objectWithKeyValues:responseObject];

            self.headerM.name = self.userM.name;
            self.headerM.uid = self.userM.uid;
            self.headerM.userAutograph = @"查看或编辑个人信息";
            self.headerV.headerModel = self.headerM;
            //下载头像
            [self downLoadIcon];
            [self.meTableV reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
}

#pragma mark- 加载头像
- (void)downLoadIcon{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"uid"] = [NSString stringWithFormat:@"%@",self.userM.uid];
    
    [manager POST:listpic parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *ary = [NSMutableArray array];
        ary = [FDMListPicModel mj_objectArrayWithKeyValuesArray:responseObject];
        if (ary.count > 0) {

                    FDMListPicModel *picM = ary[0];
                    NSString *iconUrl = [NSString stringWithFormat:@"%@/%@",Url,picM.url];
                    self.headerM.iconUrl = iconUrl;
                    self.headerV.headerModel = self.headerM;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
