//
//  QuesTableViewCell.h
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SDAutoLayout.h"
#import "SDWeiXinPhotoContainerView.h"
#import "UIImageView+WebCache.h"
#import "JackImageViewType.h"
#import "CYQuestionModel.h"

@interface QuesTableViewCell : UITableViewCell
@property(strong,nonatomic)UIView *largeImageView;
@property(strong,nonatomic)JackImageViewType *headImageView;        //
@property(strong,nonatomic)UILabel *nameLabel;                      //
@property(strong,nonatomic)UILabel *replyLabel;                     
@property(strong,nonatomic)UILabel *timeLable;
@property(strong,nonatomic)UILabel *mailLabel;
@property(strong,nonatomic)JackImageViewType *realLargeImage;

@property(nonatomic)SDWeiXinPhotoContainerView *picContainerView;
-(void)configModel:(CYQuestionModel*)model;
@end
