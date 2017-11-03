//
//  QuesTableViewCell.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "QuesTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "SDWeiXinPhotoContainerView.h"
#import "UIImageView+WebCache.h"


#import "SDPhotoBrowser.h"



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
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 30, 36, 36)];
    _headImageView.backgroundColor = [UIColor grayColor];
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 18;
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.clipsToBounds = YES;
    [self.contentView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(58, 20, 250, 35)];
    _nameLabel.text = @"一二三四五  大众POLO";
    _nameLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_nameLabel];
    
    
    _replyLabel = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-62, 20, 50, 35)];
    _replyLabel.text = @"5个回复";
    _replyLabel.textColor = [UIColor colorFromHex:@"#909090"];
    _replyLabel.textAlignment = NSTextAlignmentRight;
    _replyLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_replyLabel];
    
    _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(58, 42, 70, 35)];
    _timeLable.text = @"17:50";
    _timeLable.textColor = [UIColor colorFromHex:@"#909090"];
    _timeLable.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_timeLable];
    
    _mailLabel = [[UILabel alloc]initWithFrame:CGRectMake(56, 70, Main_Screen_Width-70, 70)];
    _mailLabel.textColor = [UIColor colorFromHex:@"#3f3f3f"];
//    _mailLabel.backgroundColor = [UIColor grayColor];
    _mailLabel.font = [UIFont systemFontOfSize:13];
    _mailLabel.numberOfLines = 0;
    [self.contentView addSubview:_mailLabel];
    
    _largeImageView = [[UIView alloc]init];
//    _largeImageView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_largeImageView];
    
    _realLargeImage = [[UIImageView alloc]init];
    _realLargeImage.contentMode = UIViewContentModeScaleAspectFill;
    _realLargeImage.clipsToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
    [_realLargeImage addGestureRecognizer:tap];
    _realLargeImage.userInteractionEnabled = YES;
    [_largeImageView addSubview:_realLargeImage];
    
    _picContainerView = [SDWeiXinPhotoContainerView new];
    [_largeImageView addSubview:_picContainerView];

    
}
//////////////////////////////////////////////////////
- (void)tapImageView
{
    

}

@end
