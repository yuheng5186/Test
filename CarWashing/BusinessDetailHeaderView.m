//
//  BusinessDetailHeaderView.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/27.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BusinessDetailHeaderView.h"

@interface BusinessDetailHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *adressLabel;

@property (weak, nonatomic) IBOutlet UIImageView *starImageView;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *freeCheckLabel;

@property (weak, nonatomic) IBOutlet UILabel *qualityLabel;

@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (weak, nonatomic) IBOutlet UIButton *phoneButton;

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@property (weak, nonatomic) IBOutlet UIView *separateView;

@property (weak, nonatomic) IBOutlet UILabel *adressLabel2;

@property (weak, nonatomic) IBOutlet UILabel *openTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *naviLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopTypeLabel;

@property (weak, nonatomic) IBOutlet UIButton *naviSmallBtn;
@end

@implementation BusinessDetailHeaderView


+ (instancetype)businessDetailHeaderView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"BusinessDetailHeaderView" owner:nil options:nil].firstObject;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews{
    [self setupUI];
}

- (void)setupUI {
    
    self.nameLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    
    self.adressLabel.textColor = [UIColor colorFromHex:@"#999999"];
    
    self.scoreLabel.textColor = [UIColor colorFromHex:@"#dfdfdf"];
    
    self.freeCheckLabel.backgroundColor = [UIColor colorFromHex:@"#517ab6"];
    self.freeCheckLabel.layer.cornerRadius = 7.5;
    self.freeCheckLabel.clipsToBounds = YES;
    
    self.qualityLabel.backgroundColor = [UIColor colorFromHex:@"f85460"];
    self.qualityLabel.layer.cornerRadius = 7.5;
    self.qualityLabel.clipsToBounds = YES;
    
    self.buttonView.backgroundColor = [UIColor colorFromHex:@"#64affa"];
    
    self.separateView.backgroundColor = [UIColor colorFromHex:@"#dfdfdf"];
    
    self.adressLabel2.textColor = [UIColor colorFromHex:@"#999999"];
    
    self.openTimeLabel.textColor = [UIColor colorFromHex:@"#999999"];
    
    self.distanceLabel.textColor = [UIColor colorFromHex:@"#868686"];
    
    self.distanceLabel.textColor = [UIColor colorFromHex:@"#868686"];
    
    self.shopTypeLabel.textColor = [UIColor colorFromHex:@"#868686"];
}



- (IBAction)didClickFavoriteBtn:(UIButton *)sender {
    
    
    
}




@end
