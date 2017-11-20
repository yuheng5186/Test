//
//  MyTableViewCell.h
//  CarWashing
//
//  Created by apple on 2017/11/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
    
    @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
    @property (weak, nonatomic) IBOutlet UILabel *interLabel;
    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeiamgeWidth;
    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *disTanceConstraint;
    
@end
