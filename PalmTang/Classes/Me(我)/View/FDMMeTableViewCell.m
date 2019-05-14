//
//  FDMMeTableViewCell.m
//  PalmTang
//
//  Created by 发抖喵 on 2018/10/30.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import "FDMMeTableViewCell.h"

@interface FDMMeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *cellIcon;
@property (weak, nonatomic) IBOutlet UILabel *cellText;

@end

@implementation FDMMeTableViewCell

- (void)setModel:(FDMMeListModel *)model{
    
//    [self.cellIcon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",model.icon]]];
    self.cellText.text = model.text;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
