//
//  CarTicketView.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CarTicketView.h"
#import "UIView+AutoSizeToDevice.h"

@implementation CarTicketView

+ (instancetype)carTicketView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"CarTicketView" owner:nil options:nil].lastObject;
}



- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.dg_viewAutoSizeToDevice = YES;
}

@end
