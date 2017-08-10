//
//  DSShareGetMoneyController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/8/10.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSShareGetMoneyController.h"

@interface DSShareGetMoneyController ()

@end

@implementation DSShareGetMoneyController

- (void) drawNavigation {

    [self drawTitle:@"分享赚钱"];
}
- (void) drawContent {
    
    self.contentView.top                = 0;
    self.contentView.height             = self.view.height;
    self.contentView.backgroundColor    = [UIColor colorFromHex:@"#f6f6f6"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubView];

}

- (void) createSubView {
    
//    UIView *titleView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*375/667) color:[UIColor colorFromHex:@"#f6f6f6"]];
//    titleView.top                      = Main_Screen_Height*64/375;
//    titleView.centerX                  = Main_Screen_Width/2;
    
//    UIImageView *logoImageView  = [UIUtil drawCustomImgViewInView:titleView frame:CGRectMake(0, 0, Main_Screen_Width*40/375, Main_Screen_Height*40/667) imageName:@"WechatIMG3"];
//    logoImageView.top           = Main_Screen_Height*23/667;
//    logoImageView.centerX       = titleView.size.width/2;
    
    NSString   *titleString     = @"推荐得“洗车卡”";
    
    UIFont     *titleFont       = [UIFont boldSystemFontOfSize:40];
    UILabel *titleLabel         = [UIUtil drawLabelInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width*300/375, Main_Screen_Height*60/667) font:titleFont text:titleString isCenter:NO];
    titleLabel.text             = titleString;
    titleLabel.textColor        = [UIColor colorFromHex:@"#4a4a4a"];
    titleLabel.textAlignment    = NSTextAlignmentCenter;
    titleLabel.centerX          = self.contentView.centerX;
    titleLabel.top              = Main_Screen_Height*120/667;
    
    
    NSString *showString              = @"邀请新人完成注册，即可获得价值99元洗车卡";
    UIFont *showStringFont            = [UIFont systemFontOfSize:14];
    UILabel *showLabel          = [UIUtil drawLabelInView:self.contentView frame:[UIUtil textRect:showString font:showStringFont] font:showStringFont text:showString isCenter:NO];
    showLabel.textColor         = [UIColor colorFromHex:@"#4a4a4a"];
    showLabel.textAlignment     = NSTextAlignmentCenter;
    showLabel.top               = titleLabel.bottom +Main_Screen_Height*20/667;
    showLabel.centerX           = titleLabel.centerX;
    
    UIImageView *bigImageView   = [UIUtil drawCustomImgViewInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width*280/375, Main_Screen_Height*280/667) imageName:@"WechatIMG54"];
    bigImageView.top            = showLabel.bottom +Main_Screen_Height*28/667;
    bigImageView.centerX        = self.contentView.centerX;
    
    UIButton    *getMoneyButton = [UIUtil drawDefaultButton:self.contentView title:@"立即邀请，新人可获得99元洗车卡" target:self action:@selector(getMoneyButtonClick:)];
    getMoneyButton.top          = bigImageView.bottom +Main_Screen_Height*30/667;
    getMoneyButton.centerX      = self.contentView.centerX;
    
}

- (void) getMoneyButtonClick:(id)sender {


    
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
