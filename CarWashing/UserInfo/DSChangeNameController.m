//
//  DSChangeNameController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/26.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSChangeNameController.h"

@interface DSChangeNameController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *userNameText;

@end

@implementation DSChangeNameController

- (void)drawNavigation {
    
    [self drawTitle:@"修改姓名"];
    [self drawRightTextButton:@"确定" action:@selector(buttonClick:)];
    
}
- (void) buttonClick:(id)sender {

}

- (void) drawContent
{
    self.contentView.top                = self.navigationView.bottom;
    self.contentView.height             = self.view.height;}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubView];
}
- (void) createSubView {

    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*60/667) color:[UIColor whiteColor]];
    upView.top                      = 10;
    
    self.userNameText                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-240, 40)];
    //        self.phoneNumberText.placeholder    = @"输入验证码";
    self.userNameText.placeholder    = @"15800781856";
//    self.userNameText.text           = @"15800781856";
    self.userNameText.delegate       = self;
    self.userNameText.returnKeyType  = UIReturnKeyDone;
    self.userNameText.textAlignment  = NSTextAlignmentLeft;
    self.userNameText.font           = [UIFont systemFontOfSize:16];
    self.userNameText.backgroundColor= [UIColor whiteColor];
    self.userNameText.top            = Main_Screen_Height*10/667;
    self.userNameText.left           = Main_Screen_Width*20/375 ;
    
    [self.userNameText addTarget:self action:@selector(userNameTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [upView addSubview:self.userNameText];

}
- (void) userNameTextChanged:(UITextField *)sender {

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
