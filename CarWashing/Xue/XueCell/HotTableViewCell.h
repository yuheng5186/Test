//
//  HotTableViewCell.h
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYHotTopicModel.h"
#import "JackImageViewType.h"
@interface HotTableViewCell : UITableViewCell

@property(strong,nonatomic)UILabel *titleLable;
@property(strong,nonatomic)JackImageViewType *largeImageViewOnly;
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UILabel *amazingNumberLabel;
@property(strong,nonatomic)UILabel *commentNumLabel;
-(void)configCell:(CYHotTopicModel*)model;
@end
