//
//  CyShowTableViewCell.h
//  CarWashing
//
//  Created by apple on 2017/11/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CyShowTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftShowImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCons;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end
