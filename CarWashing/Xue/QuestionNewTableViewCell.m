//
//  QuestionNewTableViewCell.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "QuestionNewTableViewCell.h"

@implementation QuestionNewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    _userImage = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 36, 36)];
    _userImage.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_userImage];
}

@end
