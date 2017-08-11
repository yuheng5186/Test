//
//  MemberView.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/27.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MemberView.h"

@implementation MemberView


+ (instancetype)memberView {
    return [[NSBundle mainBundle] loadNibNamed:@"MemberView" owner:nil options:nil].firstObject;
}


- (void)layoutSubviews {
    
    self.topContainView.backgroundColor = [UIColor colorFromHex:@"#293754"];
    
    self.bottomContainView.backgroundColor = [UIColor colorFromHex:@"#febb02"];
    
    self.increaseButton.backgroundColor = [UIColor colorFromHex:@"ff9041"];
    
    self.ernScoreButton.backgroundColor = [UIColor colorFromHex:@"ff9041"];
    
    
    NSString *phoneNum = @"13661682431";
    NSString *phoneText = [phoneNum stringByReplacingOccurrencesOfString:[phoneNum substringWithRange:NSMakeRange(3, 4)] withString:@"****"];
    self.phoneLabel.text = phoneText;
    
    
}


@end
