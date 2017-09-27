//
//  CYCardTableViewCell.m
//  CarWashing
//
//  Created by apple on 2017/9/26.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYCardTableViewCell.h"

@implementation CYCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)configCell:(CardBag*)model
{
    if (model.Type ==1) {
        self.typeLabel.text = @"购买卡";
         self.leftNumLabel.text = [NSString stringWithFormat:@"洗车卡(%ld)",model.Counts];
    }else if (model.Type ==2) {
        self.typeLabel.text = @"赠送卡";
        self.leftNumLabel.text = [NSString stringWithFormat:@"洗车卡(%ld)",model.Counts];
    }else if (model.Type ==3) {
        self.typeLabel.text = @"领取卡";
        self.leftNumLabel.text = [NSString stringWithFormat:@"洗车卡(%ld)",model.Counts];
    }
   
}

@end
