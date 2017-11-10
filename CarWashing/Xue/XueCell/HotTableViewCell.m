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
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(12, 30, 200, 35)];
    _titleLable.text = @"我今天第1234天上班";
    _titleLable.font = [UIFont systemFontOfSize:17];
    _titleLable.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    [self.contentView addSubview:_titleLable];
    
    _largeImageViewOnly = [[JackImageViewType alloc]initWithFrame:CGRectMake(12, 75, Main_Screen_Width-24, 150)];
//    _largeImageViewOnly.backgroundColor = [UIColor grayColor];
    _largeImageViewOnly.image = [UIImage imageNamed:@"placeholder"];
    [self.contentView addSubview:_largeImageViewOnly];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 235, 150, 30)];
    _timeLabel.text = @"15:40";
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor colorFromHex:@"#999999"];
    [self.contentView addSubview:_timeLabel];
    
    _amazingNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-64, 233, 50, 30)];
    _amazingNumberLabel.text = @"2333";
    _amazingNumberLabel.textAlignment = NSTextAlignmentRight;
    _amazingNumberLabel.font = [UIFont systemFontOfSize:14];
    _amazingNumberLabel.textColor = [UIColor colorFromHex:@"#999999"];
    [self.contentView addSubview:_amazingNumberLabel];
    
    UIButton *goodButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-80, 237, 20, 20)];
    [goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
    [self.contentView addSubview:goodButton];
    
    _commentNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-130, 233, 50, 30)];
    _commentNumLabel.textColor = [UIColor colorFromHex:@"#999999"];
    _commentNumLabel.text = @"2333";
    _commentNumLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_commentNumLabel];
    
    UIButton *commButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-160, 237, 20, 20)];
    commButton.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:commButton];
}
-(void)configCell:(CYHotTopicModel*)model
{
    [self.largeImageViewOnly sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,model.IndexImg]] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.titleLable.text= [NSString stringWithFormat:@"%@",model.ActivityName];
    self.timeLabel.text= [NSString stringWithFormat:@"%@",model.ActDate];
    self.amazingNumberLabel.text= [NSString stringWithFormat:@"%@",model.GiveCount];
    self.commentNumLabel.text= [NSString stringWithFormat:@"%@",model.CommentCount];
}
@end
