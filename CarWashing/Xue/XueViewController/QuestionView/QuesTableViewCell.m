//
//  QuesTableViewCell.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "QuesTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "SDWeiXinPhotoContainerView.h"
#import "UIImageView+WebCache.h"

#import "SDPhotoBrowser.h"



@implementation QuesTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setUp];
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

-(void)setUp{
    _headImageView = [[JackImageViewType alloc]initWithFrame:CGRectMake(12, 30, 36, 36)];
    
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 18;
    [self.contentView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(58, 20, 250, 35)];
    _nameLabel.text = @"一二三四五  大众POLO";
    _nameLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_nameLabel];
    
    
    _replyLabel = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-62, 20, 50, 35)];
    _replyLabel.text = @"5个回复";
    _replyLabel.textColor = [UIColor colorFromHex:@"#909090"];
    _replyLabel.textAlignment = NSTextAlignmentRight;
    _replyLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_replyLabel];
    
    _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(58, 42, 150, 35)];
    _timeLable.text = @"17:50";
    _timeLable.textColor = [UIColor colorFromHex:@"#909090"];
    _timeLable.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_timeLable];
    
    _mailLabel = [[UILabel alloc]initWithFrame:CGRectMake(56, 77, Main_Screen_Width-70, 23)];
    _mailLabel.textColor = [UIColor colorFromHex:@"#3f3f3f"];
//    _mailLabel.backgroundColor = [UIColor grayColor];
    _mailLabel.font = [UIFont systemFontOfSize:13];
    _mailLabel.numberOfLines = 0;
    [self.contentView addSubview:_mailLabel];
    
    _largeImageView = [[UIView alloc]init];
    //九宫格图片
    self.largeImageView.frame = CGRectMake(56, 100, Main_Screen_Width-70, 0);
    [self.contentView addSubview:_largeImageView];
    
    _realLargeImage = [[JackImageViewType alloc]init];
    _realLargeImage.userInteractionEnabled = YES;
    _realLargeImage.frame=CGRectMake(0, 0,self.largeImageView.frame.size.width, self.largeImageView.frame.size.height);
    [_largeImageView addSubview:_realLargeImage];
    
    _picContainerView = [SDWeiXinPhotoContainerView new];
    _picContainerView.frame=CGRectMake(0, 0,self.largeImageView.frame.size.width, self.largeImageView.frame.size.height);
    [_largeImageView addSubview:_picContainerView];

}
-(void)configModel:(CYQuestionModel*)model
{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,model.FromusrImg]] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.nameLabel.text=[NSString stringWithFormat:@"%@",model.FromusrName];
    self.replyLabel.text=[NSString stringWithFormat:@"%ld个评论",model.CommentCount];
    self.timeLable.text=[NSString stringWithFormat:@"%@",model.ActDate];
    self.mailLabel.text=[NSString stringWithFormat:@"%@",model.ActivityName];
     
    
//    //计算label高度
//    NSDictionary *font123 = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
//    CGSize maxSize = CGSizeMake(Main_Screen_Width-70, MAXFLOAT);
//    CGSize labelSize = [model.ActivityName boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:font123 context:nil].size;
    if([model.IndexImg rangeOfString:@","].location !=NSNotFound)//_roaldSearchText
    {
        self.largeImageView.hidden =NO;
        self.realLargeImage.hidden=YES;
        NSLog(@"yes");
        NSArray * arrImage = [model.IndexImg componentsSeparatedByString:@","];
        if (arrImage.count <= 3 && arrImage.count > 1) {
                self.largeImageView.hidden =NO;
                self.largeImageView.height = 260;
                NSMutableArray * containArr = [NSMutableArray array];
                for (int i=0; i<arrImage.count; i++) {
                    NSString * str=[NSString stringWithFormat:@"%@%@",kHTTPImg,arrImage[i]];
                    [containArr addObject:str];
                }
                self.picContainerView.picPathStringsArray = containArr;
                
            }else if (arrImage.count <= 6 && arrImage.count > 3){
                self.largeImageView.hidden =NO;
                self.largeImageView.height = 260;
                NSMutableArray * containArr = [NSMutableArray array];
                for (int i=0; i<arrImage.count; i++) {
                    NSString * str=[NSString stringWithFormat:@"%@%@",kHTTPImg,arrImage[i]];
                    [containArr addObject:str];
                }
                self.picContainerView.picPathStringsArray = containArr;
            }else if (arrImage.count <= 9&& arrImage.count > 6){
                self.largeImageView.hidden =NO;
                self.largeImageView.height = 340;
                NSMutableArray * containArr = [NSMutableArray array];
                for (int i=0; i<arrImage.count; i++) {
                    NSString * str=[NSString stringWithFormat:@"%@%@",kHTTPImg,arrImage[i]];
                    [containArr addObject:str];
                }
                self.picContainerView.picPathStringsArray = containArr;
    }
        
    
    }
    
}

@end
