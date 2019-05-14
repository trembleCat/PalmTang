//
//  FDMVoiceViewCell.m
//  PalmTang
//
//  Created by 发抖喵 on 2018/11/11.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import "FDMVoiceViewCell.h"
#import <UIImageView+WebCache.h>

@interface FDMVoiceViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundV;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *browseCount;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *favulousCount;

@end

@implementation FDMVoiceViewCell

- (void)setImageUrl:(NSString *)imageUrl{
    
    [self.backgroundV sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundV.layer.cornerRadius = 12.5;
    self.backgroundV.layer.masksToBounds = YES;
    self.backgroundV.layer.borderWidth = 1;
    self.backgroundV.layer.borderColor = [[UIColor lightTextColor] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
