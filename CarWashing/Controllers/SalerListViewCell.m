//
//  SalerListViewCell.m
//  商家
//
//  Created by 时建鹏 on 2017/7/18.
//  Copyright © 2017年 mm. All rights reserved.
//

#import "SalerListViewCell.h"

@interface SalerListViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopAdressLabel;

@property (weak, nonatomic) IBOutlet UILabel *freeTestLabel;

@property (weak, nonatomic) IBOutlet UILabel *qualityLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeShopLabel;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UIView *separateLine;

@property (weak, nonatomic) IBOutlet UIImageView *starView;

@end

@implementation SalerListViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}


- (void)setupUI {
    
    self.shopAdressLabel.textColor = [UIColor colorFromHex:@"#999999"];
    self.separateLine.backgroundColor = [UIColor colorFromHex:@"#e6e6e6"];
    
    self.freeTestLabel.layer.cornerRadius = 7.5;
    self.freeTestLabel.clipsToBounds = YES;
    self.freeTestLabel.backgroundColor = [UIColor colorFromHex:@"#517ab6"];
    self.qualityLabel.layer.cornerRadius = 7.5;
    self.qualityLabel.clipsToBounds = YES;
    self.qualityLabel.backgroundColor = [UIColor colorFromHex:@"#f85460"];
    
    self.typeShopLabel.textColor = [UIColor colorFromHex:@"#868686"];
    self.distanceLabel.textColor = [UIColor colorFromHex:@"#868686"];
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
