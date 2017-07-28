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




@end
