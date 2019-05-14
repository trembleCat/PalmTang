//
//  FDMModifyController.m
//  PalmTang
//
//  Created by 发抖喵 on 2018/11/6.
//  Copyright © 2018年 fdm. All rights reserved.
//


#import "FDMModifyController.h"

#import "FDMSexSelectionView.h"

#import "FDMUserModel.h"

#import <AVFoundation/AVFoundation.h>
#import <UIButton+WebCache.h>

@interface FDMModifyController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UIView *sexView;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UITextField *majorTF;
@property (weak, nonatomic) UIButton *headerBtn;
@property (weak, nonatomic) FDMSexSelectionView *sexSelectionView;

@property (strong, nonatomic) NSMutableDictionary *modifyDic;

@end

@implementation FDMModifyController

- (NSMutableDictionary *)modifyDic{
    
    if (_modifyDic == nil) {
        _modifyDic = [NSMutableDictionary dictionary];
    }
    return  _modifyDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"编辑个人信息";
    self.tableView.rowHeight = 60;
    
    [self addBasicsView];
    [self setModify];
    
    //收起键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTableView)];
    [self.tableView addGestureRecognizer:tap];
}


- (void)addBasicsView{
    
    //设置保存按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(saveModify) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightItem setStyle:UIBarButtonItemStylePlain];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //设置性别View
    FDMSexSelectionView *sexSelectionView = [FDMSexSelectionView loadSexSelectionView];
    [sexSelectionView setFrame:self.sexView.bounds];
    self.sexSelectionView = sexSelectionView;
    [self.sexView addSubview:sexSelectionView];
    
    //设置表头
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 160)];
    self.tableView.tableHeaderView = headerView;
    //表头头像框
    UIButton *headerBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [headerBtn setBackgroundImage:[UIImage imageNamed:@"defaultUserIcon"] forState:UIControlStateNormal];
    headerBtn.layer.cornerRadius = 45;
    headerBtn.layer.masksToBounds = YES;
    headerBtn.layer.borderWidth = 2;
    headerBtn.layer.borderColor = [[UIColor colorWithRed:130.0f/255.0f green:130.0f/255.0f blue:130.0f/255.0f alpha:1.0] CGColor];
    [headerBtn addTarget:self action:@selector(clickHeaderBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:headerBtn];
    self.headerBtn = headerBtn;
    
    [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@90);
        make.centerX.equalTo(headerView.mas_centerX);
        make.centerY.equalTo(headerView.mas_centerY);
    }];
    //表头小相机
    UIImageView *cameraV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"camera"]];
    [headerView addSubview:cameraV];
    
    [cameraV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerBtn.mas_right);
        make.bottom.equalTo(headerBtn.mas_bottom);
        make.width.height.equalTo(@25);
    }];
}

//设置默认信息
- (void)setModify{
    
    self.nameTF.text = [NSString stringWithFormat:@"%@",self.userM.name];
    self.sexSelectionView.sex = self.userM.sex;
    self.ageTF.text = [NSString stringWithFormat:@"%ld",self.userM.age];
    self.majorTF.text = [NSString stringWithFormat:@"%@",self.userM.major];
    [self.headerBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.IconUrl] forState:UIControlStateNormal];
}

#pragma mark- 保存信息
- (void)saveModify{
    
    if (self.nameTF.text.length <= 0 ) {
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"error"] status:@"昵称不能为空"];
        [SVProgressHUD dismissWithDelay:1.5f];
    }else{

        //弹出确定框
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定保存" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            //上传信息-更新信息
            [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
            [SVProgressHUD showWithStatus:@"正在上传"];
            
            [self setParameters];
            [self upLoadModify];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDestructive) handler:nil];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

//设置上传参数
- (void)setParameters{
    
    self.modifyDic[@"uid"] = [NSString stringWithFormat:@"%@",self.userM.uid];
    self.modifyDic[@"name"]  = [NSString stringWithFormat:@"%@",self.nameTF.text];
    self.modifyDic[@"sex"]  = [NSString stringWithFormat:@"%@",self.sexSelectionView.sex];
    self.modifyDic[@"age"]  = [NSString stringWithFormat:@"%@",self.ageTF.text];
    self.modifyDic[@"major"]  = [NSString stringWithFormat:@"%@",self.majorTF.text];
}

#pragma mark- 上传信息-更新信息
- (void)upLoadModify{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:modify parameters:_modifyDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleCustom)];
        [SVProgressHUD showImage:[UIImage imageNamed:@"yes"] status:@"修改成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"upLoadModify" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD dismissWithDelay:1.5f];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"error"] status:@"修改失败,请检查网络"];
        [SVProgressHUD dismissWithDelay:1.5f];
    }];
    
}

//点击修改图片
- (void)clickHeaderBtn:(UIButton *)sender{
    
    //判断相机权限
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self; //设置代理
    imagePicker.allowsEditing = YES;
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"选择" preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *actionA = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
    
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *actionB = [UIAlertAction actionWithTitle:@"从相册选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];

    }];
    UIAlertAction *actionC = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDestructive) handler:nil];
    
    [alertC addAction:actionA];
    [alertC addAction:actionB];
    [alertC addAction:actionC];
    [self presentViewController:alertC animated:YES completion:nil];
    
}

#pragma mark- 从相册选择图片+上传图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.headerBtn setBackgroundImage:img forState:UIControlStateNormal];
    
    [self uploadIcon:img];
}

//上传图片
- (void)uploadIcon:(UIImage *)img{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"uid"] = [NSString stringWithFormat:@"%@",self.userM.uid];
    
    [manager POST:upload parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *data = UIImagePNGRepresentation(img);
        [formData appendPartWithFileData:data name:@"mag" fileName:@"mag.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"yes"] status:@"上传成功"];
        [SVProgressHUD dismissWithDelay:1.5f];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"upLoadModify" object:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.headerBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.IconUrl] forState:UIControlStateNormal];
        [SVProgressHUD showImage:[UIImage imageNamed:@"error"] status:@"上传失败，图片大小不能超过5M"];
        [SVProgressHUD dismissWithDelay:2.0f];
    }];
}

//点击TableView
- (void)tapTableView{
    [self.tableView endEditing:YES];
}

@end
