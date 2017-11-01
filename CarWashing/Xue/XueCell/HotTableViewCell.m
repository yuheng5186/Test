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
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, 200, 35)];
    titleLable.text = @"我今天第一天上班";
    titleLable.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:titleLable];
    
    UIImageView *largeImageViewOnly = [[UIImageView alloc]initWithFrame:CGRectMake(12, 55, Main_Screen_Width-24, 150)];
    largeImageViewOnly.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:largeImageViewOnly];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 215, 80, 14)];
    timeLabel.text = @"15:40";
    timeLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:timeLabel];
    
    UILabel *amazingNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-62, 215, 50, 14)];
    amazingNumberLabel.backgroundColor = [UIColor grayColor];
    amazingNumberLabel.text = @"2333";
    amazingNumberLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:amazingNumberLabel];
}

@end
