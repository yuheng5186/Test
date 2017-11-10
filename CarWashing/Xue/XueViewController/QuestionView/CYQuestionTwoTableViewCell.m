//
//  CYQuestionTwoTableViewCell.m
//  CarWashing
//
//  Created by apple on 2017/11/10.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYQuestionTwoTableViewCell.h"

@implementation CYQuestionTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headerImageView.layer.cornerRadius=20;
    self.headerImageView.layer.masksToBounds=YES;
}

-(void)configCell:(CYQuestionModel*)model{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,model.FromusrImg]] placeholderImage:[UIImage imageNamed:@"photo"]];
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,model.IndexImg]] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.namelabel.text=[NSString stringWithFormat:@"%@",model.FromusrName];
    self.commendLabel.text=[NSString stringWithFormat:@"%ld个评论",model.CommentCount];
    self.timeLabel.text=[NSString stringWithFormat:@"%@",model.ActDate];
    self.detaillabel.text=[NSString stringWithFormat:@"%@",model.ActivityName];
}

@end
