//
//  QuesTableViewCell.h
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuesTableViewCell : UITableViewCell
@property(strong,nonatomic)UIImageView *largeImageView;
@property(strong,nonatomic)UIImageView *headImageView;
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)UILabel *replyLabel;
@property(strong,nonatomic)UILabel *timeLable;
@property(strong,nonatomic)UILabel *mailLabel;
@end
