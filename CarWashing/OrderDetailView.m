//
//  OrderDetailView.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "OrderDetailView.h"

@implementation OrderDetailView

+ (instancetype)orderDetailView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"OrderDetailView" owner:nil options:nil].lastObject;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI {
    
}

@end
