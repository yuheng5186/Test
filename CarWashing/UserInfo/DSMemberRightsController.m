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
    
    [self drawTitle:@"会员特权" Color:[UIColor blackColor]];
    
}

- (void) drawContent
{
    self.statusView.backgroundColor     = [UIColor grayColor];
    self.navigationView.backgroundColor = [UIColor grayColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createSubView];

}
- (void) createSubView {
    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*200/667) color:[UIColor yellowColor]];
    upView.top                      = 0;
    
    
    UIImage *membershipImage              = [UIImage imageNamed:@"btnImage"];
    UIImageView *membershipImageView      = [UIUtil drawCustomImgViewInView:upView frame:CGRectMake(0, 0, membershipImage.size.width/4, membershipImage.size.height/4) imageName:@"btnImage"];
    membershipImageView.top               = Main_Screen_Height*20/667;
    membershipImageView.centerX           = upView.centerX;
    
    NSString *membershipName              = @"白银会员";
    UIFont *membershipNameFont            = [UIFont systemFontOfSize:16];
    UILabel *membershipNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:membershipName font:membershipNameFont] font:membershipNameFont text:membershipName isCenter:NO];
    membershipNameLabel.textColor         = [UIColor colorFromHex:@"#8B8B8B"];
    membershipNameLabel.top               = membershipImageView.bottom +Main_Screen_Height*20/667;
    membershipNameLabel.centerX           = membershipImageView.centerX;

    UIView *middleView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*180/667) color:[UIColor whiteColor]];
    middleView.top                      = upView.bottom;
    
    
    UIProgressView *progressView          = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame                    = CGRectMake(0, 0, Main_Screen_Width -Main_Screen_Width*40/375, 40);
    progressView.top                      = Main_Screen_Height*60/667;
    progressView.centerX                  = Main_Screen_Width/2;
    progressView.progress                 = 0.5;
    progressView.trackTintColor           = [UIColor grayColor];
    progressView.progressTintColor        = [UIColor yellowColor];
    progressView.transform                = CGAffineTransformMakeScale(1.0f, 5.0f);
    [progressView setProgress:0.5 animated:YES];
    
    [middleView addSubview:progressView];
    
    NSString *membershipScoreName              = @"1600";
    UIFont *membershipScoreNameFont            = [UIFont systemFontOfSize:16];
    UILabel *membershipScoreNameLabel          = [UIUtil drawLabelInView:middleView frame:[UIUtil textRect:membershipScoreName font:membershipScoreNameFont] font:membershipScoreNameFont text:membershipScoreName isCenter:NO];
    membershipScoreNameLabel.textColor         = [UIColor colorFromHex:@"#8B8B8B"];
    membershipScoreNameLabel.top               = Main_Screen_Height*20/667;
    membershipScoreNameLabel.centerX           = membershipImageView.centerX;
    
    NSString *allScoreName              = @"3000";
    UIFont *allScoreNameFont            = [UIFont systemFontOfSize:16];
    UILabel *allScoreNameLabel          = [UIUtil drawLabelInView:middleView frame:[UIUtil textRect:allScoreName font:allScoreNameFont] font:allScoreNameFont text:allScoreName isCenter:NO];
    allScoreNameLabel.textColor         = [UIColor colorFromHex:@"#8B8B8B"];
    allScoreNameLabel.top               = progressView.bottom +Main_Screen_Height*10/667;
    allScoreNameLabel.right             = progressView.right;
    
    NSString *scoreRemindName              = @"在获得800积分升级为黄金会员";
    UIFont *scoreRemindNameFont            = [UIFont systemFontOfSize:16];
    UILabel *scoreRemindNameLabel          = [UIUtil drawLabelInView:middleView frame:[UIUtil textRect:scoreRemindName font:scoreRemindNameFont] font:scoreRemindNameFont text:scoreRemindName isCenter:NO];
    scoreRemindNameLabel.textColor         = [UIColor blackColor];
    scoreRemindNameLabel.top               = allScoreNameLabel.bottom +Main_Screen_Height*10/667;
    scoreRemindNameLabel.centerX           = progressView.centerX;
    
    UIButton *updateMemberButton        = [UIUtil drawButtonInView:middleView frame:CGRectMake(0, 0, 50, 30) text:@"升级" font:[UIFont systemFontOfSize:16] color:[UIColor whiteColor] target:self action:@selector(updateMemberClick:)];
    updateMemberButton.layer.cornerRadius   = 5;
    updateMemberButton.backgroundColor  = [UIColor redColor];
    updateMemberButton.top              = allScoreNameLabel.top +Main_Screen_Height*20/667;
    updateMemberButton.right            = scoreRemindNameLabel.left -Main_Screen_Width*10/375;
    
    
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
    
    
    UIView *downView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*150/667) color:[UIColor whiteColor]];
    downView.top                      = middleView.bottom +Main_Screen_Height*10/667;
    
    NSString *memberString              = @"会员特权";
    UIFont *menberStringFont            = [UIFont systemFontOfSize:16];
    UILabel *memberStringLabel          = [UIUtil drawLabelInView:downView frame:[UIUtil textRect:memberString font:menberStringFont] font:menberStringFont text:memberString isCenter:NO];
    memberStringLabel.textColor         = [UIColor blackColor];
    memberStringLabel.top               = Main_Screen_Height*15/667;
    memberStringLabel.left              = Main_Screen_Width*15/375;
    
    UIView  *lineView           = [UIUtil drawLineInView:downView frame:CGRectMake(0, 0, Main_Screen_Width, 1)];
    lineView.backgroundColor    = [UIColor grayColor];
    lineView.top                = memberStringLabel.bottom +Main_Screen_Height*15/667;
    lineView.left               = 0;
    
    
    UIView *symbolView                   = [UIUtil drawLineInView:downView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    symbolView.left                      = Main_Screen_Width*30/375;
    symbolView.top                       = lineView.bottom +Main_Screen_Height*10/667;
    
    UITapGestureRecognizer  *tapSymbolGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSymbolButtonClick:)];
    [symbolView addGestureRecognizer:tapSymbolGesture];
    
    
    UIImageView *symbolImageView      = [UIUtil drawCustomImgViewInView:symbolView frame:CGRectMake(0, 0, 50,40) imageName:@"btnImage"];
    symbolImageView.left              = Main_Screen_Width*10/375;
    symbolImageView.top               = Main_Screen_Height*10/667;
    
    NSString *symbolString              = @"身份象征";
    UIFont *symbolStringFont            = [UIFont systemFontOfSize:16];
    UILabel *symbolStringLabel          = [UIUtil drawLabelInView:symbolView frame:[UIUtil textRect:symbolString font:symbolStringFont] font:symbolStringFont text:symbolString isCenter:NO];
    symbolStringLabel.textColor         = [UIColor blackColor];
    symbolStringLabel.centerX           = symbolImageView.centerX;
    symbolStringLabel.top               = symbolImageView.bottom +Main_Screen_Height*10/667;
    
    UIView *discountView                   = [UIUtil drawLineInView:downView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    discountView.left                      = symbolView.right +Main_Screen_Width*20/375;
    discountView.top                       = lineView.bottom +Main_Screen_Height*10/667;
    
    UITapGestureRecognizer  *tapdiscountGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDiscountButtonClick:)];
    [discountView addGestureRecognizer:tapdiscountGesture];
    
    
    UIImageView *discountImageView      = [UIUtil drawCustomImgViewInView:discountView frame:CGRectMake(0, 0, 50,40) imageName:@"btnImage"];
    discountImageView.left              = Main_Screen_Width*10/375;
    discountImageView.top               = Main_Screen_Height*10/667;
    
    NSString *discountString              = @"洗车折扣";
    UIFont *discountStringFont            = [UIFont systemFontOfSize:16];
    UILabel *discountStringLabel          = [UIUtil drawLabelInView:discountView frame:[UIUtil textRect:discountString font:discountStringFont] font:discountStringFont text:discountString isCenter:NO];
    discountStringLabel.textColor         = [UIColor blackColor];
    discountStringLabel.centerX           = discountImageView.centerX;
    discountStringLabel.top               = discountImageView.bottom +Main_Screen_Height*10/667;
    
    UIView *maintainView                   = [UIUtil drawLineInView:downView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    maintainView.left                      = discountView.right +Main_Screen_Width*20/375;
    maintainView.top                       = lineView.bottom +Main_Screen_Height*10/667;
    
    UITapGestureRecognizer  *tapMaintainGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMaintainButtonClick:)];
    [maintainView addGestureRecognizer:tapMaintainGesture];
    
    
    UIImageView *maintainImageView      = [UIUtil drawCustomImgViewInView:maintainView frame:CGRectMake(0, 0, 50,40) imageName:@"btnImage"];
    maintainImageView.left              = Main_Screen_Width*10/375;
    maintainImageView.top               = Main_Screen_Height*10/667;
    
    NSString *maintainString              = @"保养优惠";
    UIFont *maintainStringFont            = [UIFont systemFontOfSize:16];
    UILabel *maintainStringLabel          = [UIUtil drawLabelInView:maintainView frame:[UIUtil textRect:maintainString font:maintainStringFont] font:maintainStringFont text:maintainString isCenter:NO];
    maintainStringLabel.textColor         = [UIColor blackColor];
    maintainStringLabel.centerX           = maintainImageView.centerX;
    maintainStringLabel.top               = maintainImageView.bottom +Main_Screen_Height*10/667;
    
    
    UIView *goodsView                   = [UIUtil drawLineInView:downView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    goodsView.left                      = maintainView.right +Main_Screen_Width*20/375;
    goodsView.top                       = lineView.bottom +Main_Screen_Height*10/667;
    
    UITapGestureRecognizer  *tapGoodsGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGoodsButtonClick:)];
    [goodsView addGestureRecognizer:tapGoodsGesture];
    
    
    UIImageView *goodsImageView      = [UIUtil drawCustomImgViewInView:goodsView frame:CGRectMake(0, 0, 50,40) imageName:@"btnImage"];
    goodsImageView.left              = Main_Screen_Width*10/375;
    goodsImageView.top               = Main_Screen_Height*10/667;
    
    NSString *goodsString              = @"会员商品";
    UIFont *goodsStringFont            = [UIFont systemFontOfSize:16];
    UILabel *goodsStringLabel          = [UIUtil drawLabelInView:goodsView frame:[UIUtil textRect:goodsString font:goodsStringFont] font:goodsStringFont text:goodsString isCenter:NO];
    goodsStringLabel.textColor         = [UIColor blackColor];
    goodsStringLabel.centerX           = goodsImageView.centerX;
    goodsStringLabel.top               = goodsImageView.bottom +Main_Screen_Height*10/667;
    
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
