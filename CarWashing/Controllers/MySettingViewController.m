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

    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*220/667) color:[UIColor yellowColor]];
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
    UIButton  *settingButton        = [UIUtil drawButtonInView:upView frame:CGRectMake(0, 0, settingImage.size.width, settingImage.size.height) iconName:@"icon_setting" target:self action:@selector(editButtonClick:)];
    settingButton.top               = Main_Screen_Height*40/667;
    settingButton.right             = Main_Screen_Width -Main_Screen_Width*20/375;
    
    
}
- (void) editButtonClick:(id)sender {
    
    

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
