//
//  AnotherHotTableViewCell.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "AnotherHotTableViewCell.h"
#import "HotSecondDetailCollectionViewCell.h"

@implementation AnotherHotTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setUP];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUP{
    
    UILabel *grayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Height, 15)];
    grayLabel.backgroundColor = [UIColor colorFromHex:@"#f6f6f6"];
    [self.contentView addSubview:grayLabel];
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(12, 30, 200, 35)];
    titleLable.text = @"我今天第一天上班";
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.textColor = [UIColor colorFromHex:@"#999999"];
    [self.contentView addSubview:titleLable];
    
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 175, 80, 30)];
    timeLabel.text = @"15:40";
    timeLabel.font = [UIFont systemFontOfSize:14];
    titleLable.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    [self.contentView addSubview:timeLabel];
    
    UILabel *amazingNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-64, 173, 50, 30)];
    amazingNumberLabel.text = @"2333";
    amazingNumberLabel.textAlignment = NSTextAlignmentRight;
    amazingNumberLabel.font = [UIFont systemFontOfSize:14];
    amazingNumberLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    [self.contentView addSubview:amazingNumberLabel];
    
    UIButton *goodButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-80, 177, 20, 20)];
    goodButton.backgroundColor = [UIColor orangeColor];
    
    [self.contentView addSubview:goodButton];
    
    UILabel *commentNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-130, 173, 50, 30)];
    commentNumLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    commentNumLabel.text = @"2333";
    commentNumLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:commentNumLabel];
    
    UIButton *commButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-160, 177, 20, 20)];
    commButton.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:commButton];
    
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layOut.itemSize = CGSizeMake(100, 100);
    UICollectionView *imageCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(12, 65, Main_Screen_Width, 100) collectionViewLayout:layOut];
    imageCollection.backgroundColor = [UIColor whiteColor];
    imageCollection.delegate = self;
    imageCollection.dataSource = self;
    [imageCollection registerClass:[HotSecondDetailCollectionViewCell class] forCellWithReuseIdentifier:@"second"];
    [self.contentView addSubview:imageCollection];
    
}

#pragma mark - CollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotSecondDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"second" forIndexPath:indexPath];
    return cell;
}


@end
