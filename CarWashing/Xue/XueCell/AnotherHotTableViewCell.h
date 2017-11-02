//
//  AnotherHotTableViewCell.h
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnotherHotTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic)UILabel *titleLable;
@property(strong,nonatomic)UIImageView *largeImageViewOnly;
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UILabel *amazingNumberLabel;
@property(strong,nonatomic)UILabel *commentNumLabel;

@end

