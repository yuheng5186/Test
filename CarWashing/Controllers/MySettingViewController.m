//
//  MySettingViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/19.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MySettingViewController.h"

@interface MySettingViewController ()

@end

@implementation MySettingViewController

- (void) drawContent {

    self.statusView.hidden      = YES;
    
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"我的";
    self.navigationController.navigationBar.hidden = YES;

    [self createSubView];
}

- (void) createSubView {

    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*250/667) color:[UIColor yellowColor]];
    upView.top                      = 0;
    
    UIImage *userImage              = [UIImage imageNamed:@"icon_defaultavatar"];
    UIImageView *userImageView      = [UIUtil drawCustomImgViewInView:upView frame:CGRectMake(0, 0, userImage.size.width/2, userImage.size.height/2) imageName:@"icon_defaultavatar"];
    userImageView.top               = Main_Screen_Height*50/667;
    userImageView.left              = Main_Screen_Width*30/375;
    
    NSString *userName              = @"15800781856";
    UIFont *userNameFont            = [UIFont systemFontOfSize:16];
    UILabel *userNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:userName font:userNameFont] font:userNameFont text:userName isCenter:NO];
    userNameLabel.textColor         = [UIColor colorFromHex:@"#8B8B8B"];
    userNameLabel.left              = userImageView.right +Main_Screen_Width*20/667;
    userNameLabel.centerY           = userImageView.centerY - Main_Screen_Height*10/375;
    
    UIImage *editImage              = [UIImage imageNamed:@"icon_edit"];
    UIButton  *editButton           = [UIUtil drawButtonInView:upView frame:CGRectMake(0, 0, editImage.size.width, editImage.size.height) iconName:@"icon_edit" target:self action:@selector(editButtonClick:)];
    editButton.left                 = userNameLabel.right +Main_Screen_Width*10/667;
    editButton.centerY              = userNameLabel.centerY;

    UIImage *settingImage           = [UIImage imageNamed:@"icon_setting"];
    UIButton  *settingButton        = [UIUtil drawButtonInView:upView frame:CGRectMake(0, 0, settingImage.size.width, settingImage.size.height) iconName:@"icon_setting" target:self action:@selector(settingButtonClick:)];
    settingButton.top               = Main_Screen_Height*40/667;
    settingButton.right             = Main_Screen_Width -Main_Screen_Width*20/375;
    
    NSString *membershipString      = @"会员特权";
    UIFont *membershipFont          = [UIFont systemFontOfSize:16];
    UIButton *membershipButton      = [UIUtil drawButtonInView:upView frame:CGRectMake(0, 0, 110, 30) text:membershipString font:membershipFont color:[UIColor whiteColor] target:self action:@selector(menbershipButtonClick:)];
    membershipButton.backgroundColor= [UIColor redColor];
    membershipButton.layer.cornerRadius = 15;
    membershipButton.left           = userNameLabel.left;
    membershipButton.top            = userNameLabel.bottom +Main_Screen_Height*20/667;
    
    NSString *signString      = @"每日签到";
    UIFont *signFont          = [UIFont systemFontOfSize:16];
    UIButton *signButton      = [UIUtil drawButtonInView:upView frame:CGRectMake(0, 0, 110, 30) text:signString font:signFont color:[UIColor whiteColor] target:self action:@selector(signButtonClick:)];
    signButton.backgroundColor= [UIColor redColor];
    signButton.layer.cornerRadius = 15;
    signButton.left           = membershipButton.right +Main_Screen_Width*15/375;
    signButton.centerY        = membershipButton.centerY;
    
    UIView *backgroudView                  = [UIUtil drawLineInView:upView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*80/667) color:[UIColor whiteColor]];
    backgroudView.bottom                = upView.bottom;
    backgroudView.left                  = upView.left;
    
    
    UIView *orderView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    orderView.left                      = Main_Screen_Width*40/375;
    orderView.top                       = 0;
    
    UITapGestureRecognizer  *tapOrderGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOrderButtonClick:)];
    [orderView addGestureRecognizer:tapOrderGesture];
    
    
    
    UIView *favoritesView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*80/667) color:[UIColor blueColor]];
    favoritesView.left                      = orderView.right +Main_Screen_Width*40/375;
    favoritesView.top                       = 0;
    
    UITapGestureRecognizer  *favoritesTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapFavoritesButtonClick:)];
    [favoritesView addGestureRecognizer:favoritesTapGesture];
    
    
    
    UIView *exchangeView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*80/667) color:[UIColor blueColor]];
    exchangeView.left                      = orderView.right +Main_Screen_Width*40/375;
    exchangeView.top                       = 0;
    
    UITapGestureRecognizer  *exchangeTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapExchangeButtonClick:)];
    [exchangeView addGestureRecognizer:exchangeTapGesture];
    
    
}
- (void) editButtonClick:(id)sender {
    
    

}

- (void) settingButtonClick:(id)sender {
    
    

}
- (void) menbershipButtonClick:(id)sender {
    
    
    
}

- (void) signButtonClick:(id)sender {
    
    
    
}

- (void) tapOrderButtonClick:(id)sender {
    
    
}

- (void) tapFavoritesButtonClick:(id)sender {
    
    
}

- (void) tapExchangeButtonClick:(id)sender {
    
    
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
