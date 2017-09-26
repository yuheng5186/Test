//
//  CYCardTableViewCell.h
//  CarWashing
//
//  Created by apple on 2017/9/26.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardBag.h"
@interface CYCardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *leftNumLabel;
-(void)configCell:(CardBag*)model;
@end
