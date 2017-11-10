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
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(12, 30, 200, 35)];
    _titleLable.text = @"我今天第56678天上班";
    _titleLable.font = [UIFont systemFontOfSize:17];
    _titleLable.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    [self.contentView addSubview:_titleLable];
    
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 175, 80, 30)];
    _timeLabel.text = @"15:40";
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor colorFromHex:@"#999999"];
    [self.contentView addSubview:_timeLabel];
    
    _amazingNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-64, 173, 50, 30)];
    _amazingNumberLabel.text = @"2333";
    _amazingNumberLabel.textAlignment = NSTextAlignmentRight;
    _amazingNumberLabel.font = [UIFont systemFontOfSize:14];
    _amazingNumberLabel.textColor = [UIColor colorFromHex:@"#999999"];
    [self.contentView addSubview:_amazingNumberLabel];
    
    UIButton *goodButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-80, 177, 20, 20)];
    [goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
    [self.contentView addSubview:goodButton];
    
    _commentNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-130, 173, 50, 30)];
    _commentNumLabel.textColor = [UIColor colorFromHex:@"#999999"];
    _commentNumLabel.text = @"2333";
    _commentNumLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_commentNumLabel];
    
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
    imageCollection.showsHorizontalScrollIndicator = NO;
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
