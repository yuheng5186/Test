//
//  HotTableViewCell.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "HotTableViewCell.h"

@implementation HotTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setUP];
    }
    return self;
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
    
    UILabel *grayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Height, 15)];
    grayLabel.backgroundColor = [UIColor colorFromHex:@"#f6f6f6"];
    [self.contentView addSubview:grayLabel];
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(12, 30, 200, 35)];
    titleLable.text = @"我今天第一天上班";
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.textColor = [UIColor colorFromHex:@"#999999"];
    [self.contentView addSubview:titleLable];
    
    UIImageView *largeImageViewOnly = [[UIImageView alloc]initWithFrame:CGRectMake(12, 75, Main_Screen_Width-24, 150)];
    largeImageViewOnly.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:largeImageViewOnly];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 235, 80, 30)];
    timeLabel.text = @"15:40";
    timeLabel.font = [UIFont systemFontOfSize:14];
    titleLable.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    [self.contentView addSubview:timeLabel];
    
    UILabel *amazingNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-64, 233, 50, 30)];
    amazingNumberLabel.text = @"2333";
    amazingNumberLabel.textAlignment = NSTextAlignmentRight;
    amazingNumberLabel.font = [UIFont systemFontOfSize:14];
    amazingNumberLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    [self.contentView addSubview:amazingNumberLabel];
    
    UIButton *goodButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-80, 237, 20, 20)];
    goodButton.backgroundColor = [UIColor orangeColor];
    [goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
    [self.contentView addSubview:goodButton];
    
    UILabel *commentNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-130, 233, 50, 30)];
    commentNumLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    commentNumLabel.text = @"2333";
    commentNumLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:commentNumLabel];
    
    UIButton *commButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-160, 237, 20, 20)];
    commButton.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:commButton];
}

@end
