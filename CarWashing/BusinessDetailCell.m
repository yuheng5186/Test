//
//  BusinessDetailCell.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BusinessDetailCell.h"

@interface BusinessDetailCell ()


@end

@implementation BusinessDetailCell


+ (instancetype)businessDetailCell {
  
    return [[NSBundle mainBundle] loadNibNamed:@"BusinessDetailCell" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
