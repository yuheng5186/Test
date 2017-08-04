//
//  BusinessEstimateCell.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/4.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BusinessEstimateCell.h"

@implementation BusinessEstimateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.commentLabel.textColor = [UIColor colorFromHex:@"#999999"];
    
    self.dateLabel.textColor = [UIColor colorFromHex:@"#999999"];
    self.timeLabel.textColor = [UIColor colorFromHex:@"#999999"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
