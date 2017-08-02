//
//  GoodsViewCell.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "GoodsViewCell.h"

@implementation GoodsViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    
    UIView *containView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 10, 10)];
    containView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:containView];
}

@end
