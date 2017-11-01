//
//  CYUserCarTableViewCell.m
//  CarWashing
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYUserCarTableViewCell.h"

@implementation CYUserCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 15*Main_Screen_Height/667)];
        view.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:view];
        self.carImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 15*Main_Screen_Height/667, 120*Main_Screen_Height/667, 100*Main_Screen_Height/667)];
        self.contentView.backgroundColor=[UIColor greenColor];
        self.carImageView.layer.cornerRadius = 10*Main_Screen_Height/667;
        self.carImageView.layer.masksToBounds=YES;
        [self.contentView addSubview:self.carImageView];
        
        
    }
    return self;
}

@end
