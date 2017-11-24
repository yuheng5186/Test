//
//  MyInteractMessageCell.m
//  CarWashing
//
//  Created by apple on 2017/11/22.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MyInteractMessageCell.h"

@implementation MyInteractMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dateLabel.hidden=YES;
    self.headerimageView.layer.cornerRadius = 35/2;
    self.headerimageView.layer.masksToBounds = YES;
}
- (IBAction)praiseBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cell:button:)]) {
        [self.delegate cell:self button:sender.tag-1];
    }
}

-(void)configCell:(MyinteractModel*)model
{
    [self.headerimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,model.FromusrImg]]];
    if ([model.ActivityType isEqualToString:@"2"]) {//车友提问
        self.nameLabel.text= model.FromusrName;
    }else if ([model.ActivityType isEqualToString:@"3"]){//热门话题
        self.nameLabel.text= model.FromusrName;
    }else if ([model.ActivityType isEqualToString:@"5"]){//二手车
        self.nameLabel.text= model.CarInfo;
    }
    self.timeLabel.text = model.ActDate;
    self.dateLabel.text = model.ActDate;
    self.titleLabel.text = model.ActivityName;
}

@end
