//
//  DSActivityDetailCell.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/8/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSActivityDetailCell.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"


@implementation DSActivityDetailCell

{
    UIImageView *_iconImageView;
    UILabel     *_nameLabel;
    UILabel     *_contentLabel;
    UILabel     *_sayTimeLabel;
    UIImageView *_starImageView;
    UIButton *_ThumbUpBtn;

}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubView];
    }
    return self;
}


- (void) createSubView {
    
    UIImageView     *view0 = [UIImageView new];
    view0.backgroundColor   = [UIColor redColor];
    _iconImageView          = view0;
    
    UILabel *lab1           = [UILabel new];
    lab1.textColor          = [UIColor colorFromHex:@"#4a4a4a"];
    lab1.font               = [UIFont systemFontOfSize:16];
    _nameLabel              = lab1;
    
    
    UILabel *lab2           = [UILabel new];
    lab2.textColor          = [UIColor colorFromHex:@"#999999"];
    lab2.font               = [UIFont systemFontOfSize:14];
    lab2.numberOfLines      = 0;
    _contentLabel           = lab2;
    
    UILabel *lab3           = [UILabel new];
    lab3.textColor          = [UIColor colorFromHex:@"#999999"];
    lab3.font               = [UIFont systemFontOfSize:14];
    _sayTimeLabel           = lab3;
    
    UIImageView     *view4 = [UIImageView new];
    view4.backgroundColor   = [UIColor clearColor];
    _starImageView          = view4;
#pragma mark-评论点赞按钮
    UIButton *thumbupvie=[UIButton new];
//    thumbupvie.backgroundColor=[UIColor redColor];
////    UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
//    thumbupvie.imageView.backgroundColor=[UIColor whiteColor];
//    thumbupvie.titleLabel.backgroundColor=[UIColor yellowColor];
    thumbupvie.titleLabel.textColor=[UIColor colorFromHex:@"#868686"];
    [thumbupvie setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    thumbupvie.titleLabel.font               = [UIFont systemFontOfSize:12];
    [thumbupvie setTitle:@"99" forState:UIControlStateNormal];
    [thumbupvie setImage:[UIImage imageNamed:@"pinglundianzan"] forState:UIControlStateNormal];
    [thumbupvie setImage:[UIImage imageNamed:@"xiaohongshou"] forState:UIControlStateSelected];
     [thumbupvie setTitleEdgeInsets:UIEdgeInsetsMake(10, -thumbupvie.imageView.image.size.width, 0, thumbupvie.imageView.image.size.width)];
    [thumbupvie setImageEdgeInsets:UIEdgeInsetsMake(10, thumbupvie.titleLabel.bounds.size.width, 0, -thumbupvie.titleLabel.bounds.size.width)];
     [thumbupvie addTarget:self action:@selector(ThumbOclick:) forControlEvents:UIControlEventTouchUpInside];
   
    

    _ThumbUpBtn=thumbupvie;
    
    [self.contentView sd_addSubviews:@[view0,lab1,lab2,lab3,view4,thumbupvie]];
    
    
    _iconImageView.sd_layout
    .widthIs(40)
    .heightIs(40)
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10);
    
    _nameLabel.sd_layout
    .topEqualToView(_iconImageView)
    .leftSpaceToView(_iconImageView, 10)
    .heightRatioToView(_iconImageView, 0.4);
    
    _starImageView.sd_layout
    .topSpaceToView(_nameLabel, 5)
    .leftEqualToView(_nameLabel)
    .heightIs(15)
    .widthIs(80);
    
    _contentLabel.sd_layout
    .topSpaceToView(_starImageView, 10)
    .leftEqualToView(_nameLabel)
    .autoHeightRatio(0);
    
    _sayTimeLabel.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .centerYEqualToView(_nameLabel)
    .heightIs(20);
    
    _ThumbUpBtn.sd_layout
    .rightSpaceToView(self.contentView,12)
    .bottomSpaceToView(self.contentView,8)
    .widthIs(34)
    .heightIs(34);
    
    _iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    [_contentLabel setSingleLineAutoResizeWithMaxWidth:260];
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    [_sayTimeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    
}
#pragma mark-评论点赞
-(void)ThumbOclick:(UIButton *)btn{
    if (self.thumbOnclick) {
        self.thumbOnclick(btn);
    }

}

- (void) setModel:(DSUserModel *)model {
    
    _model  = model;
    _iconImageView.image    = [UIImage imageNamed:model.iconName];
    _nameLabel.text         = model.name;
    _contentLabel.text      = model.content;
    _sayTimeLabel.text      = model.sayTime;
    _starImageView.image    = [UIImage imageNamed:model.starName];
    _ThumbUpBtn.titleLabel.text=model.thumbNum;
    CGFloat bottomMargin = 10;
    
    
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:bottomMargin];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
