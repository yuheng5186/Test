//
//  MyInteractMessageCell.h
//  CarWashing
//
//  Created by apple on 2017/11/22.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyinteractModel.h"
@protocol MyInteractMessageCelldelegate <NSObject>
-(void)cell:(UITableViewCell*)cell button:(NSInteger)btn;
@end
@interface MyInteractMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerimageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,assign) id<MyInteractMessageCelldelegate>delegate;
-(void)configCell:(MyinteractModel*)model;
@end
