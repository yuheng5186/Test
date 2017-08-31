//
//  DSAboutController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/24.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSAboutController.h"
#import "DSAgreementController.h"

@interface DSAboutController ()

@end

@implementation DSAboutController

- (void)drawNavigation {
    
    [self drawTitle:@"关于蔷薇"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self craeteSubView];
}

- (void) craeteSubView {
    self.contentView.backgroundColor    = [UIColor colorFromHex:@"#e5e5e5"];
    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*200/667) color:[UIColor colorFromHex:@"#e5e5e5"]];
    upView.top                      = 0;
    
    
    UIImage *appImage              = [UIImage imageNamed:@"WechatIMG3"];
    UIImageView *appImageView      = [UIUtil drawCustomImgViewInView:upView frame:CGRectMake(0, 0, appImage.size.width/2, appImage.size.height/2) imageName:@"WechatIMG3"];
    appImageView.top               = Main_Screen_Height*20/667;
    appImageView.centerX           = upView.centerX;
    
    NSDictionary *infoDic           = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion            = [infoDic objectForKey: @"CFBundleShortVersionString"];
    NSString *string                = [NSString stringWithFormat: @"%@ %@",NSLocalizedString (@"V", nil), appVersion];
    
    
    NSString *showName              = [NSString stringWithFormat:@"蔷薇爱车%@",string];
    UIFont *showNameFont            = [UIFont systemFontOfSize:Main_Screen_Height*16/667];
    UILabel *showNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:showName font:showNameFont] font:showNameFont text:showName isCenter:NO];
    showNameLabel.textColor         = [UIColor colorFromHex:@"#8B8B8B"];
    showNameLabel.top               = appImageView.bottom +Main_Screen_Height*15/667;
    showNameLabel.centerX           = appImageView.centerX;
    
    NSString *contentName               = @"    上海璟薇实业集团有限公司，是一家立足于上海，面向全国以及海外市场的全产业链、多元化集团公司，集设计、研发、生产、批发、定制、加盟为一体的综合性集团公司。上海璟薇实业集团有限公司，长期专注于黄金珠宝行业，以发现美，创造美，留住美，传承美为设计理念，在工业4.0的发展趋势下，以3D打印、3D扫描高科技技术来实现真正的黄金珠宝定制。上海璟薇集团旗下品牌“妃莉妮娅”是集中国风、流行元素、3D硬金、DIY手编于一体，将手串文化、文玩文化、黄金文化融入其中的高端品牌。妃莉妮娅的优雅、高贵，诠释着民族文化的传承。";
    UIFont *contentNameFont             = [UIFont systemFontOfSize:Main_Screen_Height*16/667];
    UILabel *contentNameLabel           = [UIUtil drawLabelInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*20/375, Main_Screen_Height*200/667) font:contentNameFont text:contentName isCenter:NO];
    contentNameLabel.textColor          = [UIColor colorFromHex:@"#999999"];
//    contentNameLabel.backgroundColor    = [UIColor colorFromHex:@"#ffffff"];
    contentNameLabel.numberOfLines      = 0;
    contentNameLabel.top                = upView.bottom +Main_Screen_Height*20/667;
    contentNameLabel.centerX            = appImageView.centerX;
    
//    NSString *serviceProtocolName              = @"蔷薇爱车服务协议";
//    UIFont *serviceProtocolNameFont            = [UIFont boldSystemFontOfSize:16];
//    UILabel *serviceProtocolNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:serviceProtocolName font:serviceProtocolNameFont] font:serviceProtocolNameFont text:serviceProtocolName isCenter:NO];
//    serviceProtocolNameLabel.textColor         = [UIColor colorFromHex:@"#3868ce"];
//    serviceProtocolNameLabel.top               = contentNameLabel.bottom +Main_Screen_Height*100/667;
//    serviceProtocolNameLabel.centerX           = appImageView.centerX;
    
    UIButton *updateRuleButton          = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width*320/375, Main_Screen_Height*30/667)];
    [updateRuleButton setTitleColor:[UIColor colorFromHex:@"#0161a1"] forState:UIControlStateNormal];
    NSMutableAttributedString *title    = [[NSMutableAttributedString alloc] initWithString:@"蔷薇爱车服务协议"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:titleRange];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHex:@"3869ce"] range:NSMakeRange(0, 8)];
    [updateRuleButton setAttributedTitle:title forState:UIControlStateNormal];
    [updateRuleButton setBackgroundColor:[UIColor clearColor]];
    [updateRuleButton.titleLabel setFont:[UIFont systemFontOfSize:14*Main_Screen_Height/667]];
    [updateRuleButton addTarget:self action:@selector(agreeButtonByClick:) forControlEvents:UIControlEventTouchUpInside];
    updateRuleButton.top              = contentNameLabel.bottom +Main_Screen_Height*100/667;
    updateRuleButton.centerX          = appImageView.centerX;
    [self.contentView addSubview:updateRuleButton];
    
    
    
    
    NSString *copyrightlName              = @"Copyright2014-2017蔷薇版权所有  沪ICP备";
    UIFont *copyrightlNameFont            = [UIFont systemFontOfSize:Main_Screen_Height*16/667];
    UILabel *copyrightlNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:copyrightlName font:copyrightlNameFont] font:copyrightlNameFont text:copyrightlName isCenter:NO];
    copyrightlNameLabel.textColor         = [UIColor colorFromHex:@"#999999"];
    copyrightlNameLabel.top               = updateRuleButton.bottom +Main_Screen_Height*5/667;
    copyrightlNameLabel.centerX           = appImageView.centerX;
    
}
- (void) agreeButtonByClick:(id)sender {
    
    DSAgreementController *agreeController      = [[DSAgreementController alloc]init];
    agreeController.hidesBottomBarWhenPushed    = YES;
    [self.navigationController pushViewController:agreeController animated:YES];
    
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
