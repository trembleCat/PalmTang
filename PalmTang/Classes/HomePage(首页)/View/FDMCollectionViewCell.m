//
//  FDMCollectionViewCell.m
//  PalmTang
//
//  Created by 发抖喵 on 2018/10/31.
//  Copyright © 2018年 fdm. All rights reserved.
//

#import "FDMCollectionViewCell.h"

#import <UIImageView+WebCache.h>

@interface FDMCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end
@implementation FDMCollectionViewCell

- (void)setModel:(FDMCollectionModel *)model{
    
    [_icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.107:8080/tsxyService/%@",model.pic]]];
    _textLabel.text = model.title;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor colorWithRed:130.0f/255.0f green:130.0f/255.0f blue:130.0f/255.0f alpha:0.5] CGColor];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    
    
    
}

@end
