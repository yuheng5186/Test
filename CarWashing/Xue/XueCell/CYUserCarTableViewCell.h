//
//  CYUserCarTableViewCell.h
//  CarWashing
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYUserCarModel.h"
@interface CYUserCarTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView * carImageView;
@property (nonatomic,strong) UILabel * titlelabel;
@property (nonatomic,strong) UILabel * detaillabel;
@property (nonatomic,strong) UILabel * distancelabel;
@property (nonatomic,strong) UILabel * timeLabel;
-(void)configCell:(CYUserCarModel*)model;
@end
