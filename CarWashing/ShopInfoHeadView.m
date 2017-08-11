//
//  ShopInfoHeadView.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/4.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "ShopInfoHeadView.h"

@implementation ShopInfoHeadView

+ (instancetype)shopInfoHeadView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"ShopInfoHeadView" owner:nil options:nil].lastObject;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.freeCheckLabel.layer.cornerRadius = 7.5;
    self.freeCheckLabel.clipsToBounds = YES;
    self.freeCheckLabel.backgroundColor = [UIColor colorFromHex:@"#517ab6"];
    
    self.qualityProtectedLabel.layer.cornerRadius = 7.5;
    self.qualityProtectedLabel.clipsToBounds = YES;
    self.qualityProtectedLabel.backgroundColor = [UIColor colorFromHex:@"#f85460"];
    
}

@end
