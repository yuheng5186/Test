//
//  PurchaseCardViewCell.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/24.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "PurchaseCardViewCell.h"
#import <Masonry.h>


@implementation PurchaseCardViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    
    UIView *containView = [[UIView alloc] init];
    containView.backgroundColor = [UIColor whiteColor];
    containView.layer.cornerRadius = 5;
    containView.clipsToBounds = YES;
    [self.contentView addSubview:containView];
    
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(10);
        make.right.equalTo(self.contentView).mas_offset(-10);
        make.top.equalTo(self.contentView).mas_offset(5);
        make.bottom.equalTo(self.contentView).mas_offset(-5);
    }];
    
    
    UILabel *cardLabel = [[UILabel alloc] init];
    cardLabel.text = @"洗车年卡";
    [containView addSubview:cardLabel];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.text = @"¥800";
    [containView addSubview:priceLabel];
    
    UIButton *buyButton = [[UIButton alloc] init];
    [buyButton setTitle:@"购买" forState:UIControlStateNormal];
    buyButton.backgroundColor = [UIColor blueColor];
    [buyButton addTarget:self action:@selector(clickPurchaseCard) forControlEvents:UIControlEventTouchUpInside];
    [containView addSubview:buyButton];
    
    [cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(containView.mas_bottom).mas_offset(-60);
        make.left.equalTo(containView.mas_left).mas_offset(10);
    }];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(containView.mas_bottom).mas_offset(-20);
        make.left.equalTo(containView.mas_left).mas_offset(10);
    }];
    
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containView.mas_right).mas_offset(-20);
        make.bottom.equalTo(containView.mas_bottom).mas_offset(-10);
        make.width.mas_equalTo(80);
    }];
}

//点击购卡
- (void)clickPurchaseCard{
    
    
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
