//
//  CYPurchaseTableViewCell.m
//  CarWashing
//
//  Created by apple on 2017/11/30.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYPurchaseTableViewCell.h"

@implementation CYPurchaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)configModel:(CYPurchaseModel*)model
{
    
    self.contentLabel.text=[NSString stringWithFormat:@"%@",model.Description];
    self.moneylabel.text = [NSString stringWithFormat:@"¥%@",model.PaymentPrice];
}

@end
