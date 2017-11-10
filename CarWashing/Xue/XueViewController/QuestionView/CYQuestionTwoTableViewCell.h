//
//  CYQuestionTwoTableViewCell.h
//  CarWashing
//
//  Created by apple on 2017/11/10.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JackImageViewType.h"
#import "CYQuestionModel.h"
@interface CYQuestionTwoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet JackImageViewType *bigImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detaillabel;
@property (weak, nonatomic) IBOutlet UILabel *commendLabel;
-(void)configCell:(CYQuestionModel*)model;
@end
