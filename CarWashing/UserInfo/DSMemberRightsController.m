//
//  DSMemberRightsController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSMemberRightsController.h"
#import "DSUpdateRuleController.h"
@interface DSMemberRightsController ()

@end

@implementation DSMemberRightsController

- (void)drawNavigation {
    
    [self drawTitle:@"会员特权"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createSubView];

}
- (void) createSubView {
    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*130/667) color:[UIColor colorFromHex:@"#293754"]];
    upView.top                      = 0;
    
    
    UIImage *membershipImage              = [UIImage imageNamed:@"huiyuantou"];
    UIImageView *membershipImageView      = [UIUtil drawCustomImgViewInView:upView frame:CGRectMake(0, 0, membershipImage.size.width, membershipImage.size.height) imageName:@"huiyuantou"];
    membershipImageView.top               = Main_Screen_Height*15/667;
    membershipImageView.centerX           = upView.centerX;
    
    NSString *membershipName              = @"白银会员";
    UIFont *membershipNameFont            = [UIFont systemFontOfSize:16];
    UILabel *membershipNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:membershipName font:membershipNameFont] font:membershipNameFont text:membershipName isCenter:NO];
    membershipNameLabel.textColor         = [UIColor colorFromHex:@"#8B8B8B"];
    membershipNameLabel.top               = membershipImageView.bottom +Main_Screen_Height*10/667;
    membershipNameLabel.centerX           = membershipImageView.centerX;

    UIView *middleView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*130/667) color:[UIColor whiteColor]];
    middleView.top                      = upView.bottom;
    
    
    NSString *membershipScoreName              = @"1600";
    UIFont *membershipScoreNameFont            = [UIFont systemFontOfSize:16];
    UILabel *membershipScoreNameLabel          = [UIUtil drawLabelInView:middleView frame:[UIUtil textRect:membershipScoreName font:membershipScoreNameFont] font:membershipScoreNameFont text:membershipScoreName isCenter:NO];
    membershipScoreNameLabel.textColor         = [UIColor colorFromHex:@"#8B8B8B"];
    membershipScoreNameLabel.top               = Main_Screen_Height*10/667;
    membershipScoreNameLabel.centerX           = membershipImageView.centerX;
    
    UIProgressView *progressView          = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame                    = CGRectMake(0, 0, Main_Screen_Width -Main_Screen_Width*40/375, 40);
    progressView.top                      = membershipScoreNameLabel.bottom +Main_Screen_Height*10/667;
    progressView.centerX                  = Main_Screen_Width/2;
    progressView.progress                 = 0.5;
    progressView.trackTintColor           = [UIColor colorFromHex:@"#e6e6e6"];
    progressView.progressTintColor        = [UIColor colorFromHex:@"#febb02"];
    progressView.transform                = CGAffineTransformMakeScale(1.0f, 5.0f);
    progressView.layer.cornerRadius       = 20;
    [progressView setProgress:0.5 animated:YES];
    
    [middleView addSubview:progressView];
    

    
    NSString *allScoreName              = @"3000";
    UIFont *allScoreNameFont            = [UIFont systemFontOfSize:16];
    UILabel *allScoreNameLabel          = [UIUtil drawLabelInView:middleView frame:[UIUtil textRect:allScoreName font:allScoreNameFont] font:allScoreNameFont text:allScoreName isCenter:NO];
    allScoreNameLabel.textColor         = [UIColor colorFromHex:@"#8B8B8B"];
    allScoreNameLabel.top               = progressView.bottom +Main_Screen_Height*5/667;
    allScoreNameLabel.right             = progressView.right;
    
    NSString *scoreRemindName              = @"在获得800积分升级为黄金会员";
    UIFont *scoreRemindNameFont            = [UIFont systemFontOfSize:16];
    UILabel *scoreRemindNameLabel          = [UIUtil drawLabelInView:middleView frame:[UIUtil textRect:scoreRemindName font:scoreRemindNameFont] font:scoreRemindNameFont text:scoreRemindName isCenter:NO];
    scoreRemindNameLabel.textColor         = [UIColor colorFromHex:@"#868686"];
    scoreRemindNameLabel.top               = allScoreNameLabel.bottom +Main_Screen_Height*5/667;
    scoreRemindNameLabel.centerX           = progressView.centerX;
    
    UIImageView *updateMemberButton        = [UIUtil drawCustomImgViewInView:middleView frame:CGRectMake(0, 0, Main_Screen_Width*20/375, Main_Screen_Height*20/667) imageName:@"shengji"];
    updateMemberButton.layer.cornerRadius  = 5;
    updateMemberButton.centerY             = scoreRemindNameLabel.centerY;
    updateMemberButton.right               = scoreRemindNameLabel.left -Main_Screen_Width*5/375;
    
    
    UIButton *updateRuleButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"升级规则"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, [title length])];
    [updateRuleButton setAttributedTitle:title forState:UIControlStateNormal];
    [updateRuleButton setBackgroundColor:[UIColor clearColor]];
    [updateRuleButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [updateRuleButton addTarget:self action:@selector(updateRuleClick:) forControlEvents:UIControlEventTouchUpInside];
    updateRuleButton.top              = scoreRemindNameLabel.top +Main_Screen_Height*20/667;
    updateRuleButton.centerX          = scoreRemindNameLabel.centerX;
    [middleView addSubview:updateRuleButton];
    
    
    UIView *downView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*120/667) color:[UIColor whiteColor]];
    downView.top                      = middleView.bottom +Main_Screen_Height*10/667;
    
    NSString *memberString              = @"我的特权";
    UIFont *menberStringFont            = [UIFont systemFontOfSize:16];
    UILabel *memberStringLabel          = [UIUtil drawLabelInView:downView frame:[UIUtil textRect:memberString font:menberStringFont] font:menberStringFont text:memberString isCenter:NO];
    memberStringLabel.textColor         = [UIColor colorFromHex:@"#4a4a4a"];
    memberStringLabel.top               = Main_Screen_Height*15/667;
    memberStringLabel.left              = Main_Screen_Width*15/375;
    
    UIView  *lineView           = [UIUtil drawLineInView:downView frame:CGRectMake(0, 0, Main_Screen_Width, 1)];
    lineView.backgroundColor    = [UIColor colorFromHex:@"#e6e6e6"];
    lineView.top                = memberStringLabel.bottom +Main_Screen_Height*15/667;
    lineView.left               = 0;
    
    
    UIImage *cardImage          = [UIImage imageNamed:@"shengjihoukaquan"];
    UIImageView *cardImageView  = [UIUtil drawCustomImgViewInView:downView frame:CGRectMake(0, 0, cardImage.size.width, cardImage.size.height) imageName:@"shengjihoukaquan"];
    cardImageView.left          = Main_Screen_Width*10/375;
    cardImageView.top           = lineView.bottom +Main_Screen_Height*20/667;
    
    NSString *cardString        = @"10元洗车券";
    UIFont  *cardFont           = [UIFont systemFontOfSize:14];
    UILabel *cardLabel          = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width*200/375, Main_Screen_Height*20/667) font:cardFont text:cardString isCenter:NO];
    cardLabel.textColor         = [UIColor colorFromHex:@"#3a3a3a"];
    cardLabel.left              = cardImageView.right +Main_Screen_Width*14/375;
    cardLabel.top               = lineView.bottom +Main_Screen_Height*15/667;
    
    NSString *cardShowString        = @"门店洗车时可抵扣相应金额，每月领取一次";
    UIFont  *carShowdFont           = [UIFont systemFontOfSize:12];
    UILabel *cardShowLabel          = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width*280/375, Main_Screen_Height*20/667) font:carShowdFont text:cardShowString isCenter:NO];
    cardShowLabel.textColor         = [UIColor colorFromHex:@"#999999"];
    cardShowLabel.left              = cardImageView.right +Main_Screen_Width*14/375;
    cardShowLabel.top               = cardLabel.bottom;
    
    
    
    UIView *nextView                         = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*120/667) color:[UIColor whiteColor]];
    nextView.top                             = downView.bottom +Main_Screen_Height*10/667;
    
    NSString *memberRightString              = @"升级后可获得特权";
    UIFont *menberRightStringFont            = [UIFont systemFontOfSize:16];
    UILabel *memberRightStringLabel          = [UIUtil drawLabelInView:nextView frame:[UIUtil textRect:memberRightString font:menberRightStringFont] font:menberRightStringFont text:memberRightString isCenter:NO];
    memberRightStringLabel.textColor         = [UIColor colorFromHex:@"#4a4a4a"];
    memberRightStringLabel.top               = Main_Screen_Height*15/667;
    memberRightStringLabel.left              = Main_Screen_Width*15/375;
    
    UIView  *lineView2                       = [UIUtil drawLineInView:nextView frame:CGRectMake(0, 0, Main_Screen_Width, 1)];
    lineView2.backgroundColor                = [UIColor colorFromHex:@"#e6e6e6"];
    lineView2.top                            = memberStringLabel.bottom +Main_Screen_Height*15/667;
    lineView2.left                           = 0;
    
    
    UIImage *cardImage15          = [UIImage imageNamed:@"shengjihoukaquan"];
    UIImageView *cardImageView15  = [UIUtil drawCustomImgViewInView:nextView frame:CGRectMake(0, 0, cardImage15.size.width, cardImage15.size.height) imageName:@"shengjihoukaquan"];
    cardImageView15.left          = Main_Screen_Width*10/375;
    cardImageView15.top           = lineView.bottom +Main_Screen_Height*20/667;
    
    NSString *cardString15        = @"15元洗车券";
    UIFont  *cardFont15           = [UIFont systemFontOfSize:14];
    UILabel *cardLabel15          = [UIUtil drawLabelInView:nextView frame:CGRectMake(0, 0, Main_Screen_Width*200/375, Main_Screen_Height*20/667) font:cardFont15 text:cardString15 isCenter:NO];
    cardLabel15.textColor         = [UIColor colorFromHex:@"#3a3a3a"];
    cardLabel15.left              = cardImageView15.right +Main_Screen_Width*14/375;
    cardLabel15.top               = lineView2.bottom +Main_Screen_Height*15/667;
    
    NSString *cardShowString15        = @"门店洗车时可抵扣相应金额，每月领取一次";
    UIFont  *carShowdFont15           = [UIFont systemFontOfSize:12];
    UILabel *cardShowLabel15          = [UIUtil drawLabelInView:nextView frame:CGRectMake(0, 0, Main_Screen_Width*280/375, Main_Screen_Height*20/667) font:carShowdFont15 text:cardShowString15 isCenter:NO];
    cardShowLabel15.textColor         = [UIColor colorFromHex:@"#999999"];
    cardShowLabel15.left              = cardImageView15.right +Main_Screen_Width*14/375;
    cardShowLabel15.top               = cardLabel15.bottom;

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

#pragma mark -------button click------

- (void) updateMemberClick:(id)sender {


}
- (void) updateRuleClick:(id)sender {
    
    DSUpdateRuleController *updateRuleController  = [[DSUpdateRuleController alloc]init];
    updateRuleController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:updateRuleController animated:YES];
    
}

#pragma mark -------tapGesture click------
- (void) tapSymbolButtonClick:(id)sender {


}

- (void) tapDiscountButtonClick:(id)sender {
    
    
}
- (void) tapMaintainButtonClick:(id)sender {
    
    
}

- (void) tapGoodsButtonClick:(id)sender {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
