//
//  RechargeCell.h
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardBag.h"
@interface RechargeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *CardnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *CarddesLabel;
@property (weak, nonatomic) IBOutlet UILabel *CardTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImgV;

@end
