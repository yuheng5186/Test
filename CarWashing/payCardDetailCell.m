//
//  payCardDetailCell.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/24.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "payCardDetailCell.h"
#import <Masonry.h>

@implementation payCardDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UILabel *useCardLabel = [[UILabel alloc] init];
    useCardLabel.text = @"卡使用说明";
    [self.contentView addSubview:useCardLabel];
    
    UILabel *timesCardLabel = [[UILabel alloc] init];
    timesCardLabel.text = @"可免费洗车10次";
    timesCardLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:timesCardLabel];
    
    UILabel *brandCardLabel = [[UILabel alloc] init];
    brandCardLabel.text = @"金顶自动洗车可用";
    brandCardLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:brandCardLabel];
    
    
    //约束
    [useCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(10);
    }];
    
    [timesCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.top).mas_offset(30);
        make.right.equalTo(self.contentView).mas_offset(-10);
        make.width.mas_equalTo(200);
    }];
    
    [brandCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.bottom).mas_offset(-30);
        make.right.equalTo(self.contentView).mas_offset(-10);
        make.width.mas_equalTo(200);
    }];
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
