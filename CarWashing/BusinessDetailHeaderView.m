//
//  BusinessDetailHeaderView.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/27.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BusinessDetailHeaderView.h"
#import "UIView+AutoSizeToDevice.h"


@interface BusinessDetailHeaderView ()


@end

@implementation BusinessDetailHeaderView


+ (instancetype)businessDetailHeaderView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"BusinessDetailHeaderView" owner:nil options:nil].firstObject;
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    
//    if (self = [super initWithFrame:frame]) {
//        
//        [self setupUI];
//    }
//    return self;
//}

//- (void)layoutSubviews{
//    [self setupUI];
//}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setupUI {
    
    self.dg_viewAutoSizeToDevice = YES;
    
    self.nameLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    
    self.adressLabel.textColor = [UIColor colorFromHex:@"#999999"];
    
    self.scoreLabel.textColor = [UIColor colorFromHex:@"#dfdfdf"];
    
    self.freeCheckLabel.backgroundColor = [UIColor colorFromHex:@"#517ab6"];
    self.freeCheckLabel.layer.cornerRadius = 7.5*Main_Screen_Height/667;
    self.freeCheckLabel.clipsToBounds = YES;
    
    self.qualityLabel.backgroundColor = [UIColor colorFromHex:@"f85460"];
    self.qualityLabel.layer.cornerRadius = 7.5*Main_Screen_Height/667;
    self.qualityLabel.clipsToBounds = YES;
    
    self.buttonView.backgroundColor = [UIColor colorFromHex:@"#64affa"];
    
    self.separateView.backgroundColor = [UIColor colorFromHex:@"#f0f0f0"];
    
    self.adressLabel2.textColor = [UIColor colorFromHex:@"#999999"];
    self.ServiceNumLabel.textColor = [UIColor colorFromHex:@"#999999"];
    self.openTimeLabel.textColor = [UIColor colorFromHex:@"#999999"];
    
    self.distanceLabel.textColor = [UIColor colorFromHex:@"#868686"];
    
    self.naviLabel.textColor = [UIColor colorFromHex:@"#868686"];
    
    self.shopTypeLabel.textColor = [UIColor colorFromHex:@"#868686"];
    
    //收藏按钮
    [self.favoriteButton setImage:[UIImage imageNamed:@"shoucang1"] forState:UIControlStateNormal];
    [self.favoriteButton setImage:[UIImage imageNamed:@"shoucang2"] forState:UIControlStateSelected];
}



- (IBAction)didClickFavoriteBtn:(UIButton *)sender {
    
    if (sender.selected) {
        
        [sender setImage:[UIImage imageNamed:@"shoucang2"] forState:UIControlStateSelected];
        
        [self showInfo:@"取消收藏" autoHidden:YES];
    }else{
     
        [self showInfo:@"收藏成功" autoHidden:YES];
    }
    
    
    
    sender.selected = !sender.selected;
    
}




@end
