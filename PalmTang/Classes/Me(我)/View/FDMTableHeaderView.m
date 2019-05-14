//
//  FDMTableHeaderView.m
//  PalmTang
//
//  Created by 发抖喵 on 2018/10/30.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import "FDMTableHeaderView.h"
#import "FDMRegisterLoginController.h"
#import <UIImageView+WebCache.h>

@interface FDMTableHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userAutograph;
@end

@implementation FDMTableHeaderView

-(void)setHeaderModel:(FDMTableHeaderModel *)headerModel{
    
    self.userName.text = headerModel.name;
    self.userAutograph.text = headerModel.userAutograph;
    
    if (headerModel.iconUrl.length > 4) {
        [self.userIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",headerModel.iconUrl]]];
    }else{
        [self.userIcon setImage:[UIImage imageNamed:@"defaultUserIcon"]];
    }
}

//初始化
+(instancetype)loadHeaderView{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([FDMTableHeaderView class]) owner:nil options:nil]firstObject];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //圆形头像
    self.userIcon.layer.cornerRadius = self.userIcon.bounds.size.width *0.5;
    self.userIcon.layer.masksToBounds = YES;
    self.userIcon.layer.borderWidth = 2;
    self.userIcon.layer.borderColor = [[UIColor colorWithRed:130.0f/255.0f green:130.0f/255.0f blue:130.0f/255.0f alpha:1.0] CGColor];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

@end
