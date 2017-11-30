//
//  CYPurchaseTableViewCell.h
//  CarWashing
//
//  Created by apple on 2017/11/30.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYPurchaseModel.h"
@interface CYPurchaseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneylabel;
-(void)configModel:(CYPurchaseModel*)model;
@end
