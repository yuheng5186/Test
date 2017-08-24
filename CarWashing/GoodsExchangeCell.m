//
//  GoodsExchangeCell.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/14.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "GoodsExchangeCell.h"
#import <Masonry.h>

@implementation GoodsExchangeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI {
    
    UIImageView *backImgV = [[UIImageView alloc] init];
    _backImgV = backImgV;
    backImgV.image = [UIImage imageNamed:@"bg_card"];
    [self.contentView addSubview:backImgV];
    
    UILabel *nameLab = [[UILabel alloc] init];
    _nameLab = nameLab;
    //nameLab.textColor = [UIColor colorFromHex:@"#ffffff"];
    nameLab.text = @"体验卡";
    nameLab.font = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
    [self.contentView addSubview:nameLab];
    
    UILabel *introLab = [[UILabel alloc] init];
    _introLab = introLab;
    //introLab.textColor = [UIColor colorFromHex:@"#ffffff"];
    introLab.text = @"商家洗车自动抵扣";
    introLab.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    [self.contentView addSubview:introLab];
    
    UILabel *scoreLab = [[UILabel alloc] init];
    _scoreLab = scoreLab;
    scoreLab.text = @"1000积分";
    scoreLab.textColor = [UIColor redColor];
    scoreLab.font = [UIFont systemFontOfSize:18*Main_Screen_Height/667];
    [self.contentView addSubview:scoreLab];
    
    [backImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(22*Main_Screen_Height/667);
        make.top.equalTo(self.contentView).mas_offset(21*Main_Screen_Height/667);
    }];
    
    [introLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(nameLab);
        make.top.equalTo(nameLab.mas_bottom).mas_offset(10*Main_Screen_Height/667);
    }];
    
    [scoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(22*Main_Screen_Height/667);
        make.bottom.equalTo(self.contentView).mas_offset(-18*Main_Screen_Height/667);
    }];
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

@end
