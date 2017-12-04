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
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize             = CGSizeMake(self.contentView.size.width, self.contentView.size.height+500);

    [self.contentView addSubview:self.scrollView];
    UIImageView *adImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, self.contentView.size.height+500)];
    adImageView.image = [UIImage imageNamed:@"shangjiaruzhuhuodong"];
    [self.scrollView addSubview:adImageView];
    
    
    NSString *string                = @"马上入驻，立即赚钱";
    UIFont  *stringFont             = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
    UIButton    *getMoneyButton     = [UIUtil drawButtonInView:self.scrollView frame:CGRectMake(0, 0, Main_Screen_Width -Main_Screen_Width*60/375, Main_Screen_Height*40/667) text:string font:stringFont color:[UIColor whiteColor] target:self action:@selector(getShopMoneyButtonClick:)];
    getMoneyButton.backgroundColor  = [UIColor colorFromHex:@"#f5d953"];
    getMoneyButton.layer.cornerRadius   = 5*Main_Screen_Height/667;
    getMoneyButton.bottom           = adImageView.bottom -Main_Screen_Height*50/667;
    getMoneyButton.centerX          = self.contentView.centerX;
    
}
- (void) getShopMoneyButtonClick:(id)sender {
    DSAddMerchantController *addMerchantController      = [[DSAddMerchantController alloc]init];
    addMerchantController.hidesBottomBarWhenPushed      = YES;
    [self.navigationController pushViewController:addMerchantController animated:YES];
    
}


@end
