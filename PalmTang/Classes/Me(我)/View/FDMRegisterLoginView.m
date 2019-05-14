//
//  FDMRegisterLoginView.m
//  PalmTang
//
//  Created by 发抖喵 on 2018/11/1.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import "FDMRegisterLoginView.h"

@interface FDMRegisterLoginView()

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;

@end

@implementation FDMRegisterLoginView

+ (instancetype)RegisterLoginView{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([FDMRegisterLoginView class]) owner:nil options:nil]firstObject];
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.titleImageView.layer.cornerRadius = 7;
    self.titleImageView.layer.masksToBounds = YES;
    
    //账号
    NSMutableAttributedString *accountAttr = [[NSMutableAttributedString alloc]initWithString:@"请输入账号"];
    [accountAttr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, accountAttr.length)];
    [self.accountTF setAttributedPlaceholder:accountAttr];
    self.accountTF.tintColor = [UIColor whiteColor];
    
    //密码
    NSMutableAttributedString *passWorldAttr = [[NSMutableAttributedString alloc]initWithString:@"请输入密码"];
    [passWorldAttr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, passWorldAttr.length)];
    [self.passWordTF setAttributedPlaceholder:passWorldAttr];
    self.passWordTF.tintColor = [UIColor whiteColor];
    self.passWordTF.secureTextEntry = YES;
    
    
}

//点击登录按钮
- (IBAction)clickLoginBtn:(UIButton *)sender {
    
    self.account = self.accountTF.text;
    self.passWord = self.passWordTF.text;
    
        //提示控制器加载登录数据
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadLoginData)]) {
            
            [self.delegate loadLoginData];
            
        };
    
    
}



@end
