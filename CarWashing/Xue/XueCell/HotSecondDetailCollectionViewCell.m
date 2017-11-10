//
//  HotSecondDetailCollectionViewCell.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "HotSecondDetailCollectionViewCell.h"

@implementation HotSecondDetailCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self setUP];
    }
    return self;
}

-(void)setUP{
    self.jackImageView = [[JackImageViewType alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.jackImageView.backgroundColor = [UIColor grayColor];
    self.jackImageView.clipsToBounds = YES;
    self.jackImageView.layer.cornerRadius = 3;
    [self.contentView addSubview:self.jackImageView];
}
@end
