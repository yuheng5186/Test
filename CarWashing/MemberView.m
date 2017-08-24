//
//  MemberView.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/27.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MemberView.h"
#import "UIView+AutoSizeToDevice.h"

@implementation MemberView


+ (instancetype)memberView {
    return [[NSBundle mainBundle] loadNibNamed:@"MemberView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.topContainView.backgroundColor = [UIColor colorFromHex:@"#293754"];
    
    self.bottomContainView.backgroundColor = [UIColor colorFromHex:@"#febb02"];
    
    //self.increaseButton.backgroundColor = [UIColor colorFromHex:@"ff9041"];
    self.increaseButton.layer.cornerRadius = 8;
    self.increaseButton.layer.borderWidth = 1;
    self.increaseButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //self.ernScoreButton.backgroundColor = [UIColor colorFromHex:@"ff9041"];
    self.ernScoreButton.layer.cornerRadius = 8;
    self.ernScoreButton.layer.borderWidth = 1;
    self.ernScoreButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    NSString *phoneNum = @"13661682431";
    NSString *phoneText = [phoneNum stringByReplacingOccurrencesOfString:[phoneNum substringWithRange:NSMakeRange(3, 4)] withString:@"****"];
    self.phoneLabel.text = phoneText;
    
}





@end
