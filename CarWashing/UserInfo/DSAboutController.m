//
//  DSAboutController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/24.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSAboutController.h"

@interface DSAboutController ()

@end

@implementation DSAboutController

- (void)drawNavigation {
    
    [self drawTitle:@"关于金顶" Color:[UIColor blackColor]];
    
}

- (void) drawContent
{
    self.statusView.backgroundColor     = [UIColor grayColor];
    self.navigationView.backgroundColor = [UIColor grayColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self craeteSubView];
}

- (void) craeteSubView {
    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*200/667) color:[UIColor yellowColor]];
    upView.top                      = 0;
    
    
    UIImage *appImage              = [UIImage imageNamed:@"WechatIMG3"];
    UIImageView *appImageView      = [UIUtil drawCustomImgViewInView:upView frame:CGRectMake(0, 0, appImage.size.width/2, appImage.size.height/2) imageName:@"WechatIMG3"];
    appImageView.top               = Main_Screen_Height*20/667;
    appImageView.centerX           = upView.centerX;
    
    NSString *showName              = @"金顶洗车V1.0";
    UIFont *showNameFont            = [UIFont systemFontOfSize:16];
    UILabel *showNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:showName font:showNameFont] font:showNameFont text:showName isCenter:NO];
    showNameLabel.textColor         = [UIColor colorFromHex:@"#8B8B8B"];
    showNameLabel.top               = appImageView.bottom +Main_Screen_Height*15/667;
    showNameLabel.centerX           = appImageView.centerX;
    
    NSString *contentName               = @"    上海璟薇实业集团有限公司，是一家立足于上海，面向全国以及海外市场的全产业链、多元化集团公司，集设计、研发、生产、批发、定制、加盟为一体的综合性集团公司。上海璟薇实业集团有限公司，长期专注于黄金珠宝行业，以发现美，创造美，留住美，传承美为设计理念，在工业4.0的发展趋势下，以3D打印、3D扫描高科技技术来实现真正的黄金珠宝定制。上海璟薇集团旗下品牌“妃莉妮娅”是集中国风、流行元素、3D硬金、DIY手编于一体，将手串文化、文玩文化、黄金文化融入其中的高端品牌。妃莉妮娅的优雅、高贵，诠释着民族文化的传承。";
    UIFont *contentNameFont             = [UIFont systemFontOfSize:16];
    UILabel *contentNameLabel           = [UIUtil drawLabelInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width-20, Main_Screen_Height*200/667) font:contentNameFont text:contentName isCenter:NO];
    contentNameLabel.textColor          = [UIColor colorFromHex:@"#8B8B8B"];
    contentNameLabel.numberOfLines      = 0;
    contentNameLabel.top                = upView.bottom +Main_Screen_Height*20/667;
    contentNameLabel.centerX            = appImageView.centerX;
    
    NSString *serviceProtocolName              = @"金顶洗车服务协议";
    UIFont *serviceProtocolNameFont            = [UIFont boldSystemFontOfSize:16];
    UILabel *serviceProtocolNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:serviceProtocolName font:serviceProtocolNameFont] font:serviceProtocolNameFont text:serviceProtocolName isCenter:NO];
    serviceProtocolNameLabel.textColor         = [UIColor blueColor];
    serviceProtocolNameLabel.top               = contentNameLabel.bottom +Main_Screen_Height*100/667;
    serviceProtocolNameLabel.centerX           = appImageView.centerX;
    
    NSString *copyrightlName              = @"Copyright2014-2017金顶版权所有  沪ICP备";
    UIFont *copyrightlNameFont            = [UIFont boldSystemFontOfSize:16];
    UILabel *copyrightlNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:copyrightlName font:copyrightlNameFont] font:copyrightlNameFont text:copyrightlName isCenter:NO];
    copyrightlNameLabel.textColor         = [UIColor blackColor];
    copyrightlNameLabel.top               = serviceProtocolNameLabel.bottom +Main_Screen_Height*15/667;
    copyrightlNameLabel.centerX           = appImageView.centerX;
    
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
