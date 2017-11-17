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
        view.backgroundColor=[UIColor colorFromHex:@"#f6f6f6"];
        [self.contentView addSubview:view];
        self.carImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 30*Main_Screen_Height/667, 120*Main_Screen_Height/667, 100*Main_Screen_Height/667)];
        self.carImageView.image=[UIImage imageNamed:@"矩形23拷贝"];
        self.carImageView.layer.cornerRadius = 10*Main_Screen_Height/667;
        self.carImageView.layer.masksToBounds=YES;
        [self.contentView addSubview:_carImageView];
        
        //title
        self.titlelabel =[[UILabel alloc]init];
        self.titlelabel.textColor=[UIColor colorFromHex:@"#4a4a4a"];
        self.titlelabel.font=[UIFont systemFontOfSize:17*Main_Screen_Height/667];
        self.titlelabel.text = @"即撒谎的卡结算空间啊啥的空间啊说多了快仨活动";
        self.titlelabel.numberOfLines=2;
        [self.contentView addSubview:_titlelabel];
        [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.carImageView.mas_right).mas_offset(15*Main_Screen_Height/667);
            make.top.mas_equalTo(self.carImageView.mas_top);
            make.width.mas_equalTo(Main_Screen_Width -(157*Main_Screen_Height/667));
            make.height.mas_equalTo(20*Main_Screen_Height/667);
        }];
        //detaillabel
        self.detaillabel =[[UILabel alloc]init];
        self.detaillabel.textColor=[UIColor colorFromHex:@"#999999"];
        self.detaillabel.font=[UIFont systemFontOfSize:17*Main_Screen_Height/667];
        self.detaillabel.text = @"即撒谎的卡结算空间啊啥的空间啊说多了快仨活动";
        self.detaillabel.numberOfLines=2;
        [self.contentView addSubview:self.detaillabel];
        [self.detaillabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.carImageView.mas_right).mas_offset(15*Main_Screen_Height/667);
            make.top.mas_equalTo(self.titlelabel.mas_bottom);
            make.width.mas_equalTo(Main_Screen_Width -(157*Main_Screen_Height/667));
            make.height.mas_equalTo(30*Main_Screen_Height/667);
        }];
        //distance
        self.distancelabel =[[UILabel alloc]init];
        self.distancelabel.textColor=[UIColor colorFromHex:@"#999999"];
        self.distancelabel.font=[UIFont systemFontOfSize:14*Main_Screen_Height/667];
        self.distancelabel.text = @"公里数：3.4公里";
        [self.contentView addSubview:_distancelabel];
        [self.distancelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.carImageView.mas_right).mas_offset(15*Main_Screen_Height/667);
            make.top.mas_equalTo(self.detaillabel.mas_bottom);
            make.width.mas_equalTo(Main_Screen_Width -(157*Main_Screen_Height/667));
            make.height.mas_equalTo(25*Main_Screen_Height/667);
        }];
        //time
        self.timeLabel =[[UILabel alloc]init];
        self.timeLabel.textColor=[UIColor colorFromHex:@"#999999"];
        self.timeLabel.font=[UIFont systemFontOfSize:14*Main_Screen_Height/667];
        self.timeLabel.text = @"15：30";
        [self.contentView addSubview:_timeLabel];
        
        //调整time位置
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.carImageView.mas_right).mas_offset(15*Main_Screen_Height/667);
            make.top.mas_equalTo(self.distancelabel.mas_bottom);
            make.width.mas_equalTo(Main_Screen_Width -(157*Main_Screen_Height/667));
            make.height.mas_equalTo(25*Main_Screen_Height/667);
        }];
        
    }
    return self;
}
-(void)configCell:(CYUserCarModel*)model
{
    [self.carImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,model.Img]] placeholderImage:[UIImage imageNamed:@"矩形23拷贝"]];
    self.distancelabel.text= [NSString stringWithFormat:@"%@公里",model.Mileage];
    self.timeLabel.text= [NSString stringWithFormat:@"%@",model.ActDate];
    self.titlelabel.text= [NSString stringWithFormat:@"%@%@",model.CarBrand,model.CarType];
    self.detaillabel.text= [NSString stringWithFormat:@"%@",model.CarComment];
}
@end
