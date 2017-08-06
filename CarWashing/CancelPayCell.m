//
//  CancelPayCell.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/4.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CancelPayCell.h"

@implementation CancelPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.orderLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    
    self.washTypeLabel.textColor = [UIColor colorFromHex:@"#3a3a3a"];
    
    self.timesLabel.textColor = [UIColor colorFromHex:@"#999999"];
    
    self.stateLabel.textColor = [UIColor colorFromHex:@"#ff525a"];
    
    self.priceLabel.textColor = [UIColor colorFromHex:@"#ff525a"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
