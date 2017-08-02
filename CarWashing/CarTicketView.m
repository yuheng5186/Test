//
//  CarTicketView.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CarTicketView.h"

@implementation CarTicketView

+ (instancetype)carTicketView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"CarTicketView" owner:nil options:nil].lastObject;
}

@end
