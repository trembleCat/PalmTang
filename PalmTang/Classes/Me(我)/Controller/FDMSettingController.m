//
//  FDMSettingController.m
//  PalmTang
//
//  Created by 发抖喵 on 2018/11/8.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import "FDMSettingController.h"

@interface FDMSettingController ()

@end

@implementation FDMSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
                [self clearData];
                
                break;
            case 1:
                [self aboutVersion];
                break;
                
            default:
                break;
        }
    }
    if (indexPath.section == 1) {
    
        switch (indexPath.row) {
            case 0:
                [self exitLogon];
                break;
            default:
                break;
        }
    }
}

#pragma mark- 清除数据
- (void)clearData{
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"警告" message:[NSString stringWithFormat:@"是否清除%ldM缓存",[self getSize]] preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *actionA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self clearFile];
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"yes"] status:@"清除成功"];
    }];
    UIAlertAction *actionB = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
    
    [alertC addAction:actionA];
    [alertC addAction:actionB];
    [self presentViewController:alertC animated:YES completion:nil];
}

#pragma mark- 关于版本
- (void)aboutVersion{
    

}

#pragma mark- 退出登录
- (void)exitLogon{
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef removeObjectForKey:@"user"];
    [userDef removeObjectForKey:@"pass"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"exitLogon" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

// 获取缓存大小
- (NSUInteger)getSize{
    NSUInteger size = 0;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtPath:cachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [fileManager attributesOfItemAtPath:filePath error:nil];
        size += [attrs fileSize];
    }
    return size/(1024.0*1024.0);
}

// 清除缓存
- (void)clearFile{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtPath:cachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

@end
