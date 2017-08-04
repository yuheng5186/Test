//
//  DSUpdateRuleController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/25.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSUpdateRuleController.h"

@interface DSUpdateRuleController ()

@end

@implementation DSUpdateRuleController

- (void)drawNavigation {
    
    [self drawTitle:@"升级规则"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createSubView];
}

- (void) createSubView {
    
    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*340/667) color:[UIColor whiteColor]];
    upView.top                      = 0;
    
    NSString *growUpString              = @"会员成长值";
    UIFont *growUpStringFont            = [UIFont systemFontOfSize:16];
    UILabel *growUpStringLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:growUpString font:growUpStringFont] font:growUpStringFont text:growUpString isCenter:NO];
    growUpStringLabel.textColor         = [UIColor colorFromHex:@"#4a4a4a"];
    growUpStringLabel.centerX           = upView.centerX;
    growUpStringLabel.top               = Main_Screen_Height*20/667;
    
    UIView *leftView                    = [UIUtil drawLineInView:upView frame:CGRectMake(0, 0, 80, Main_Screen_Height*1/667) color:[UIColor colorFromHex:@"#e6e6e6"]];
    leftView.right                      = growUpStringLabel.left -Main_Screen_Width*10/375;
    leftView.centerY                    = growUpStringLabel.centerY;
    
    UIView *rightView                    = [UIUtil drawLineInView:upView frame:CGRectMake(0, 0, 80, Main_Screen_Height*1/667) color:[UIColor colorFromHex:@"#e6e6e6"]];
    rightView.left                      = growUpStringLabel.right +Main_Screen_Width*10/375;
    rightView.centerY                    = growUpStringLabel.centerY;
    
    
    NSString *growUpString1              = @"金顶会员等级有获得积分数和商品消费次数共同决定，每一次等级的提升需要改等级的积分数以及购买次数。累计积分数和购买次数决定会员等级";
    UIFont *growUpString1Font            = [UIFont systemFontOfSize:16];
    UILabel *growUpString1Label          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:growUpString1 font:growUpString1Font] font:growUpString1Font text:growUpString1 isCenter:NO];
    growUpString1Label.numberOfLines     = 0;
    growUpString1Label.frame             = CGRectMake(0, 0, Main_Screen_Width-20, Main_Screen_Height*60/667);
    growUpString1Label.textColor         = [UIColor colorFromHex:@"#999999"];
    growUpString1Label.centerX           = upView.centerX;
    growUpString1Label.top               = Main_Screen_Height*10/667 +growUpStringLabel.bottom;

    
    NSString *growUpRequireString              = @"会员等级以及最低要求";
    UIFont *growUpRequireStringFont            = [UIFont systemFontOfSize:16];
    UILabel *growUpRequireStringLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:growUpRequireString font:growUpRequireStringFont] font:growUpRequireStringFont text:growUpRequireString isCenter:NO];
    growUpRequireStringLabel.textColor         = [UIColor colorFromHex:@"#999999"];
    growUpRequireStringLabel.centerX           = upView.centerX;
    growUpRequireStringLabel.top               = Main_Screen_Height*10/667+growUpString1Label.bottom;
    
    UIImageView *growUpImageView      = [UIUtil drawCustomImgViewInView:upView frame:CGRectMake(0, 0, Main_Screen_Width-20,200) imageName:@"WechatIMG6"];
    growUpImageView.left              = Main_Screen_Width*10/375;
    growUpImageView.top               = Main_Screen_Height*10/667 +growUpRequireStringLabel.bottom;
    
    
    UIView *downView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*150/667) color:[UIColor whiteColor]];
    downView.top                      = upView.bottom +Main_Screen_Height*10/667;
    
    
    NSString *rightString              = @"会员权益说明";
    UIFont *rightStringFont            = [UIFont systemFontOfSize:16];
    UILabel *rightStringLabel          = [UIUtil drawLabelInView:downView frame:[UIUtil textRect:rightString font:rightStringFont] font:rightStringFont text:rightString isCenter:NO];
    rightStringLabel.textColor         = [UIColor colorFromHex:@"#4a4a4a"];
    rightStringLabel.centerX           = downView.centerX;
    rightStringLabel.top               = Main_Screen_Height*20/667;
    
    UIView *leftView1                    = [UIUtil drawLineInView:downView frame:CGRectMake(0, 0, 40, Main_Screen_Height*1/667) color:[UIColor colorFromHex:@"e6e6e6"]];
    leftView1.right                      = rightStringLabel.left -Main_Screen_Width*10/375;
    leftView1.centerY                    = rightStringLabel.centerY;
    
    UIView *rightView1                    = [UIUtil drawLineInView:downView frame:CGRectMake(0, 0, 40, Main_Screen_Height*1/667) color:[UIColor colorFromHex:@"#e6e6e6"]];
    rightView1.left                      = rightStringLabel.right +Main_Screen_Width*10/375;
    rightView1.centerY                    = rightStringLabel.centerY;
    
    NSString *rightString2              = @"升级奖励";
    UIFont *rightStringFont2            = [UIFont systemFontOfSize:16];
    UILabel *rightStringLabel2          = [UIUtil drawLabelInView:downView frame:[UIUtil textRect:rightString2 font:rightStringFont2] font:rightStringFont2 text:rightString2 isCenter:NO];
    rightStringLabel2.textColor         = [UIColor colorFromHex:@"#4a4a4a"];
    rightStringLabel2.left              = Main_Screen_Width*10/375;
    rightStringLabel2.top               = Main_Screen_Height*20/667 +rightStringLabel.bottom;
    
    NSString *contentString              = @"金顶会员每提升一个会员等级，可获得不等数量的优惠券，以及相对应的商品折扣";
    UIFont *contentStringFont            = [UIFont systemFontOfSize:16];
    UILabel *contentStringLabel          = [UIUtil drawLabelInView:downView frame:[UIUtil textRect:contentString font:contentStringFont] font:contentStringFont text:contentString isCenter:NO];
    contentStringLabel.numberOfLines     = 0;
    contentStringLabel.frame             = CGRectMake(0, 0, Main_Screen_Width-80, Main_Screen_Height*40/667);
    contentStringLabel.textColor         = [UIColor colorFromHex:@"#999999"];
    contentStringLabel.centerX           = downView.centerX;
    contentStringLabel.top               = Main_Screen_Height*10/667 +rightStringLabel2.bottom;

    
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
