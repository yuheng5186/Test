//
//  CYUserCarTableViewCell.m
//  CarWashing
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYUserCarTableViewCell.h"

@implementation CYUserCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 15*Main_Screen_Height/667)];
        view.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:view];
        self.carImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 15*Main_Screen_Height/667, 120*Main_Screen_Height/667, 100*Main_Screen_Height/667)];
        self.contentView.backgroundColor=[UIColor greenColor];
        self.carImageView.layer.cornerRadius = 10*Main_Screen_Height/667;
        self.carImageView.layer.masksToBounds=YES;
        [self.contentView addSubview:_carImageView];
        
        //title
        self.timeLabel =[[UILabel alloc]init];
        self.timeLabel.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:_timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.carImageView.mas_right).mas_offset(15*Main_Screen_Height/667);
            make.top.mas_equalTo(self.carImageView.mas_top);
            make.width.mas_equalTo(Main_Screen_Width -(157*Main_Screen_Height/667));
            make.height.mas_equalTo(80*Main_Screen_Height/667);
        }];
        
    }
    return self;
}

@end
