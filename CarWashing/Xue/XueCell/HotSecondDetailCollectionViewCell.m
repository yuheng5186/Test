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
    UIImageView *jackImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    jackImageView.backgroundColor = [UIColor grayColor];
    jackImageView.clipsToBounds = YES;
    jackImageView.layer.cornerRadius = 3;
    [self.contentView addSubview:jackImageView];
}
@end
