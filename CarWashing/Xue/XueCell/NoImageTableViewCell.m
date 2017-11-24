//
//  NoImageTableViewCell.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/24.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "NoImageTableViewCell.h"

@implementation NoImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUP];
    }
    return  self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUP{
    
    UILabel *grayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 10)];
    grayLabel.backgroundColor = [UIColor colorFromHex:@"#f6f6f6"];
    [self.contentView addSubview:grayLabel];
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(12, 20, 200, 30)];
    _titleLable.text = @"我今天第56678天上班";
    _titleLable.font = [UIFont systemFontOfSize:18.0];
    _titleLable.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    [self.contentView addSubview:_titleLable];
    
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 60, 150, 30)];
    _timeLabel.text = @"15:40";
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor colorFromHex:@"#999999"];
    [self.contentView addSubview:_timeLabel];
    
    _amazingNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-45, 60, 30, 30)];
    _amazingNumberLabel.text = @"233";
    _amazingNumberLabel.textAlignment = NSTextAlignmentRight;
    _amazingNumberLabel.font = [UIFont systemFontOfSize:14];
    _amazingNumberLabel.textColor = [UIColor colorFromHex:@"#999999"];
    [self.contentView addSubview:_amazingNumberLabel];
    
    UIButton *goodButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-65, 65, 20, 20)];
    [goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
    [self.contentView addSubview:goodButton];
    _commentNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-105, 60, 30, 30)];
    _commentNumLabel.textColor = [UIColor colorFromHex:@"#999999"];
    _commentNumLabel.text = @"233";
    _commentNumLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_commentNumLabel];
    
    UIButton *commButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-130, 65, 20, 20)];
    [commButton setImage:[UIImage imageNamed:@"faxianxiaoxi"] forState:UIControlStateNormal];
    [self.contentView addSubview:commButton];
    
    
}



@end
