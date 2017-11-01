//
//  CYUserCarTableViewCell.h
//  CarWashing
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYUserCarTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView * carImageView;
@property (nonatomic,strong) UIImageView * titlelabel;
@property (nonatomic,strong) UIImageView * distancelabel;
@property (nonatomic,strong) UIImageView * timeLabel;
-(instancetype)initWithFrame:(CGRect)frame;
@end
