//
//  QuesTableViewCell.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "QuesTableViewCell.h"

@implementation QuesTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setUp];
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

-(void)setUp{
    UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 30, 36, 36)];
    headImageView.backgroundColor = [UIColor grayColor];
    headImageView.clipsToBounds = YES;
    headImageView.layer.cornerRadius = 18;
    [self.contentView addSubview:headImageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(58, 20, 250, 35)];
    nameLabel.text = @"一二三四五  大众POLO";
    nameLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:nameLabel];
    
//    UILabel *carLabel = [[UILabel alloc]initWithFrame:CGRectMake(152, 30, 70, 35)];
//    carLabel.text = @"大众POLO";
//    carLabel.font = [UIFont systemFontOfSize:14];
////    carLabel.backgroundColor = [UIColor grayColor];
//    [self.contentView addSubview:carLabel];
    
    UILabel *replyLabel = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-62, 20, 50, 35)];
    replyLabel.text = @"5个回复";
    replyLabel.textColor = [UIColor colorFromHex:@"#909090"];
    replyLabel.textAlignment = NSTextAlignmentRight;
    replyLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:replyLabel];
    
    UILabel *timeLable = [[UILabel alloc]initWithFrame:CGRectMake(58, 42, 70, 35)];
    timeLable.text = @"17:50";
    timeLable.textColor = [UIColor colorFromHex:@"#909090"];
    timeLable.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:timeLable];
    
    UILabel *mailLabel = [[UILabel alloc]initWithFrame:CGRectMake(56, 70, Main_Screen_Width-70, 70)];
    mailLabel.text = @"杭州一名执勤女警近日因为路人一张随手拍的照片走红网络。想去杭州偶遇她等。杭州一名执勤女警近日因为路人一张随手拍的照片走.";
//    mailLabel.backgroundColor = [UIColor grayColor];
    mailLabel.textColor = [UIColor colorFromHex:@"#3f3f3f"];
    mailLabel.font = [UIFont systemFontOfSize:13];
    mailLabel.numberOfLines = 0;
    [self.contentView addSubview:mailLabel];
    
    _largeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(56, 140, Main_Screen_Width-70, 150)];
    _largeImageView.backgroundColor = [UIColor lightGrayColor];
    _largeImageView.clipsToBounds = YES;
    _largeImageView.layer.cornerRadius = 3;
    [self.contentView addSubview:_largeImageView];
    
}

@end
