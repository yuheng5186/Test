//
//  CYQuestionTableViewCell.m
//  CarWashing
//
//  Created by apple on 2017/11/10.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYQuestionTableViewCell.h"

@implementation CYQuestionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headerImageView.layer.cornerRadius=20;
    self.headerImageView.layer.masksToBounds=YES;
}

//问答
-(void)configCell:(CYQuestionModel*)model
{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,model.FromusrImg]] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.nameLabel.text=[NSString stringWithFormat:@"%@",model.FromusrName];
    self.CommendLabel.text=[NSString stringWithFormat:@"%ld个评论",model.CommentCount];
    self.timelabel.text=[NSString stringWithFormat:@"%@",model.ActDate];
    self.titlelabel.text=[NSString stringWithFormat:@"%@",model.ActivityName];
    
    
}

@end
