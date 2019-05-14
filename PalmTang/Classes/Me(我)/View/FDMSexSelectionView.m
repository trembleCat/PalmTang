//
//  FDMSexSelectionView.m
//  PalmTang
//
//  Created by 发抖喵 on 2018/11/7.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import "FDMSexSelectionView.h"

@interface FDMSexSelectionView()
@property (weak, nonatomic) IBOutlet UIImageView *manImage;
@property (weak, nonatomic) IBOutlet UIImageView *womanImage;
@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;

@end

@implementation FDMSexSelectionView

- (void)setSex:(NSString *)sex{
    
    if ([sex  isEqualToString:@"男" ]) {
        self.manBtn.selected = YES;
        self.manImage.image = [UIImage imageNamed:@"Already_selected"];
    }else if ([sex  isEqualToString:@"女" ]) {
        self.womanBtn.selected = YES;
         [self.womanImage setImage:[UIImage imageNamed:@"Already_selected"]];
    }
}

+ (instancetype)loadSexSelectionView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FDMSexSelectionView class]) owner:nil options:nil] firstObject];
}

//设置按钮的选中状态
- (IBAction)clickBtn:(UIButton *)sender {
    
    if (sender.tag == 1) {
        //男按钮
        sender.selected = YES;
        self.manImage.image = [UIImage imageNamed:@"Already_selected"];
        _sex = @"男";
        [self judgeSex:self.womanBtn];

    }else if (sender.tag == 2){
        //女按钮
        sender.selected = YES;
        [self.womanImage setImage:[UIImage imageNamed:@"Already_selected"]];
        _sex = @"女";
        [self judgeSex:self.manBtn];
    }
}

//取消另一个按钮的选中状态
- (void)judgeSex:(UIButton *)btn{
    
    if (btn.tag == 1) {
        //男按钮
        btn.selected = NO;
        [self.manImage setImage:[UIImage imageNamed:@"Unchecked"]];
        
    }else if (btn.tag == 2){
        //女按钮
        btn.selected = NO;
        [self.womanImage setImage:[UIImage imageNamed:@"Unchecked"]];
    }
    
}

@end
