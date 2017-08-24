//
//  DSUserRightDetailController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/8/8.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSUserRightDetailController.h"
#import "UIWindow+YzdHUD.h"

#import "HTTPDefine.h"
#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "MBProgressHUD.h"
#import "UdStorage.h"

@interface DSUserRightDetailController ()

@property (nonatomic,strong) NSDictionary *dic;
@property (nonatomic,strong) UIButton    *getButton;
@end

@implementation DSUserRightDetailController

- (void) drawNavigation {
    
    [self drawTitle:@"用户权益"];
}
- (void) drawContent {
    self.contentView.top        = self.navigationView.bottom;
    self.contentView.height     = self.view.height;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dic = [[NSDictionary alloc]init];
    [self GetCouponDetail];
    
}
- (void) createSubView {

    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*200/667) color:[UIColor whiteColor]];
    upView.top                      = 0;
    
//    UIImage *backgroundImage              = [UIImage imageNamed:@"saomaxichetiyanquan"];
    UIImageView *backgroundImageView      = [UIUtil drawCustomImgViewInView:upView frame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*20/375, Main_Screen_Height*130/667) imageName:@"saomaxichetiyanquan"];
    backgroundImageView.top               = Main_Screen_Height*10/667;
    backgroundImageView.centerX           = upView.centerX;
    
    NSString *showString             = _dic[@"CardName"];
    UIFont    *showFont              = [UIFont boldSystemFontOfSize:22*Main_Screen_Height/667];
    UILabel     *showlabel           = [UIUtil drawLabelInView:upView frame:CGRectMake(0, 0, Main_Screen_Width*200/375, Main_Screen_Height*20/667) font:showFont text:showString isCenter:NO];
    showlabel.textColor              = [UIColor whiteColor];
    showlabel.left                   = Main_Screen_Width*25/375;
    showlabel.top                    = Main_Screen_Height*38/667;
    
    
    
    NSString *showString2             = [NSString stringWithFormat:@"免费洗车%@次",_dic[@"CardCount"]];
    UIFont    *showFont2              = [UIFont boldSystemFontOfSize:14*Main_Screen_Height/667];
    UILabel     *showlabel2           = [UIUtil drawLabelInView:upView frame:CGRectMake(0, 0, Main_Screen_Width*200/375, Main_Screen_Height*20/667) font:showFont2 text:showString2 isCenter:NO];
    showlabel2.textColor              = [UIColor whiteColor];
    showlabel2.left                   = Main_Screen_Width*25/375;
    showlabel2.top                    = showlabel.bottom +Main_Screen_Height*10/667;
    
    NSString *showString3             = [NSString stringWithFormat:@"截止日期: %@",_dic[@"ExpiredTimes"]];;
    UIFont    *showFont3              = [UIFont boldSystemFontOfSize:16*Main_Screen_Height/667];
    UILabel     *showlabel3           = [UIUtil drawLabelInView:upView frame:CGRectMake(0, 0, Main_Screen_Width*200/375, Main_Screen_Height*20/667) font:showFont3 text:showString3 isCenter:NO];
    showlabel3.textColor              = [UIColor whiteColor];
    showlabel3.left                   = Main_Screen_Width*25/375;
    showlabel3.top                    = showlabel2.bottom +Main_Screen_Height*10/667;
    
    
    
    NSString *string;
    if([_dic[@"IsReceive"] intValue] == 1)
    {
        string        = @"立即领取";
        _getButton  = [UIUtil drawDefaultButton:upView title:string target:self action:@selector(getButtonClick:)];
        
    }
    else
    {
        string        = @"已领取";
        _getButton  = [UIUtil drawDefaultButton:upView title:string target:self action:nil];
    }
    
    
    
    _getButton.top           = backgroundImageView.bottom +Main_Screen_Height*30/667;
    _getButton.centerX       = Main_Screen_Width/2;
    
    upView.height           = _getButton.bottom +Main_Screen_Height*30/667;
    
    UIView *downView                = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*200/667) color:[UIColor whiteColor]];
    downView.top                    = upView.bottom +Main_Screen_Height*10/667;
    
    NSString *useString             = @"使用须知";
    UIFont    *useFont              = [UIFont systemFontOfSize:16];
    UILabel     *uselabel           = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width*100/375, Main_Screen_Height*20/667) font:useFont text:useString isCenter:NO];
    uselabel.textColor              = [UIColor colorFromHex:@"#4a4a4a"];
    uselabel.left                   = Main_Screen_Width*10/375;
    uselabel.top                    = Main_Screen_Height*10/667;
    
    NSString *useString1             = @"1. 本代金券由金顶洗车APP开发，仅限金顶洗车店和与金顶合作商家使用";
    UIFont    *useFont1              = [UIFont systemFontOfSize:14];
    UILabel     *uselabel1           = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*20/375, Main_Screen_Height*40/667) font:useFont1 text:useString1 isCenter:NO];
    uselabel1.textColor              = [UIColor colorFromHex:@"#999999"];
    uselabel1.numberOfLines          = 0;
    uselabel1.centerX                = downView.width/2;
    uselabel1.top                    = uselabel.bottom +Main_Screen_Height*10/667;
    
    NSString *useString2             = @"2. 如果使用代金券购买服务时发生退服务行为，代金券不予退还";
    UIFont    *useFont2              = [UIFont systemFontOfSize:14];
    UILabel     *uselabel2           = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*20/375, Main_Screen_Height*40/667) font:useFont2 text:useString2 isCenter:NO];
    uselabel2.textColor              = [UIColor colorFromHex:@"#999999"];
    uselabel2.numberOfLines          = 0;
    uselabel2.centerX                = Main_Screen_Width/2;
    uselabel2.top                    = uselabel1.bottom +Main_Screen_Height*5/667;
    
    NSString *useString3             = @"3. 有任何问题，可咨询金顶客服";
    UIFont    *useFont3              = [UIFont systemFontOfSize:14];
    UILabel     *uselabel3           = [UIUtil drawLabelInView:downView frame:CGRectMake(0, 0, Main_Screen_Width-Main_Screen_Width*20/375, Main_Screen_Height*40/667) font:useFont3 text:useString3 isCenter:NO];
    uselabel3.textColor              = [UIColor colorFromHex:@"#999999"];
    uselabel3.numberOfLines          = 0;
    uselabel3.centerX                = Main_Screen_Width/2;
    uselabel3.top                    = uselabel2.bottom +Main_Screen_Height*0/667;
}

-(void)GetCouponDetail
{
    NSDictionary *mulDic = @{
                             @"ConfigCode":self.ConfigCode,
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"]
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Card/CardConfigDetail",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            
            _dic = [dict objectForKey:@"JsonData"];
//            [_CouponListData addObjectsFromArray:arr];
//            [self.tableView reloadData];
            
            [self createSubView];
        }
        else
        {
            [self.view showInfo:@"信息获取失败" autoHidden:YES interval:2];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
}


- (void) getButtonClick:(id)sender {

    [self.view.window showHUDWithText:@"恭喜您领取成功，已经放入您的卡券中" Type:ShowPhotoYes Enabled:YES];

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
