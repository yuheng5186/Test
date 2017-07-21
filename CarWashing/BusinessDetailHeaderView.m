//
//  BusinessDetailHeaderView.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BusinessDetailHeaderView.h"

@implementation BusinessDetailHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+ (instancetype)businessDetailHeaderView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"BusinessDetailHeaderView" owner:nil options:nil].firstObject;
}

@end
