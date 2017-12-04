//
//  DSAddShopController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/8/14.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSAddShopController.h"
#import "DSAddMerchantController.h"

@interface DSAddShopController ()

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation DSAddShopController

- (void) drawNavigation {

    [self drawTitle:@"商家入驻"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createSubView];
}
- (void) createSubView {
    self.scrollView                         = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64)];
    self.scrollView.backgroundColor         = [UIColor whiteColor];
    self.scrollView.contentSize             = CGSizeMake(self.contentView.size.width, 1217);
//    [self.scrollView flashScrollIndicators];
//    self.scrollView.contentInset     = UIEdgeInsetsMake(0, 0, 180, 0);
//    self.scrollView.directionalLockEnabled  = YES;
    [self.contentView addSubview:self.scrollView];
    UIImageView *adImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    adImageView.contentMode=UIViewContentModeScaleAspectFill;
    adImageView.image = [UIImage imageNamed:@"shangjiaruzhuhuodong"];
    [self.scrollView addSubview:adImageView];
//    UIImageView *adImageView    = [UIUtil drawCustomImgViewInView:self.scrollView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) imageName:@"shangjiaruzhuhuodong"];
    
    
//    adImageView.centerX         = Main_Screen_Width/2;
//    adImageView.top             = Main_Screen_Height*0/667;
    
    
    NSString *string                = @"马上入驻，立即赚钱";
    UIFont  *stringFont             = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
    UIButton    *getMoneyButton     = [UIUtil drawButtonInView:self.scrollView frame:CGRectMake(0, 0, Main_Screen_Width -Main_Screen_Width*60/375, Main_Screen_Height*40/667) text:string font:stringFont color:[UIColor whiteColor] target:self action:@selector(getShopMoneyButtonClick:)];
    getMoneyButton.backgroundColor  = [UIColor colorFromHex:@"#0161a1"];
    getMoneyButton.layer.cornerRadius   = 5*Main_Screen_Height/667;
    getMoneyButton.top           = adImageView.bottom +Main_Screen_Height*10/667;
    getMoneyButton.centerX          = self.contentView.centerX;
    
//    self.scrollView.contentSize             = CGSizeMake(self.contentView.size.width, self.contentView.size.height +getMoneyButton.height*1.2);

}
- (void) getShopMoneyButtonClick:(id)sender {
    DSAddMerchantController *addMerchantController      = [[DSAddMerchantController alloc]init];
    addMerchantController.hidesBottomBarWhenPushed      = YES;
    [self.navigationController pushViewController:addMerchantController animated:YES];
    
}


@end
