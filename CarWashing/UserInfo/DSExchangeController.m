//
//  DSExchangeController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSExchangeController.h"
#import <Masonry.h>
#import "HTTPDefine.h"
#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "MBProgressHUD.h"
#import "UdStorage.h"
#import "CyCommentHtmlViewController.h"
@interface DSExchangeController ()<LKAlertViewDelegate>
{
    UITextField *exchangeTF;
    NSString    * remindStr;
    NSString   * remindTitle;
    UIImageView * adVertist ;
}
@property (nonatomic,strong) NSDictionary* dicData;
@end

@implementation DSExchangeController

- (void) drawContent {
    
    self.statusView.hidden      = YES;
    
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
    self.contentView.backgroundColor    = [UIColor colorFromHex:@"#0161a1"];
    
}

-(void)setNav{
    UIImageView * backimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    backimageView.image = [UIImage imageNamed:@"jihuoye"];
    [self.view addSubview:backimageView];
    
    UILabel *lbl = [UIUtil drawLabelInView:self.view frame:CGRectMake(Main_Screen_Width/5, 0, Main_Screen_Width*3/5, 84) font:[UIFont boldSystemFontOfSize:18] text:@"激活卡券" isCenter:YES color: [UIColor whiteColor]];
    [self.view addSubview:lbl];
    
    UIImageView * backbutton = [[UIImageView alloc]init];
    backbutton.image = [UIImage imageNamed:@"icon_titlebar_arrow"];
    [self.view addSubview:backbutton];
    [backbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lbl);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
        make.size.mas_equalTo(CGSizeMake(17, 23));
    }];
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 100, 100);
    [backBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
}
-(void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)geData{
    NSDictionary *mulDic = @{
                             @"AdvertisModule":@(4)
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Advertising/GetAdvertisList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"---%@",dict);
        self.dicData= dict;
        NSArray * Adverarray = dict[@"JsonData"];
        if (Adverarray.count!=0) {
             [adVertist sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,dict[@"JsonData"][0][@"AdvertisImg"]]]];
        }
       
    } fail:^(NSError *error) {
        NSLog(@"---%@",error);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setupUI];
    adVertist = [[UIImageView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height-100, Main_Screen_Width, 100)];
    adVertist.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [adVertist addGestureRecognizer:tap];
    [self.view addSubview:adVertist];
    [self geData];
}

-(void)tapClick
{
//    CyCommentHtmlViewController * htmlVc=[[CyCommentHtmlViewController alloc]init];
//    htmlVc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:htmlVc animated:YES];
}
- (void)setupUI {
    
   
    
    
    exchangeTF = [[UITextField alloc] init];
    exchangeTF.placeholder = @"请输入激活码(区分大小写)";
    exchangeTF.textAlignment = NSTextAlignmentCenter;
    exchangeTF.layer.cornerRadius = Main_Screen_Height*24/667;
    exchangeTF.keyboardType = UIKeyboardTypeASCIICapable;
    exchangeTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:exchangeTF];
    
    UIButton *exchangeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [exchangeBtn addTarget:self action:@selector(didClickExchangeScoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [exchangeBtn setTitle:@"激活" forState:UIControlStateNormal];
    [exchangeBtn setBackgroundColor:[UIColor colorFromHex:@"#ffe36f"]];
    [exchangeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    exchangeBtn.titleLabel.font = [UIFont systemFontOfSize:18*Main_Screen_Height/667];
    exchangeBtn.layer.cornerRadius =(Main_Screen_Height*45/667)/2;
    exchangeBtn.layer.masksToBounds = YES;
    [self.view addSubview:exchangeBtn];
    [exchangeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(233*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(Main_Screen_Width*351/375);
        make.height.mas_equalTo(Main_Screen_Height*45/667);
    }];
    [exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
     make.top.equalTo(exchangeTF.mas_bottom).mas_offset(Main_Screen_Height*30/667);
     make.centerX.equalTo(self.view);
     make.width.mas_equalTo(Main_Screen_Width*351/375);
     make.height.mas_equalTo(Main_Screen_Height*45/667);
    }];
 }
                             
- (void)didClickExchangeScoreBtn:(UIButton *)button {

    remindStr = @"";
    remindTitle = @"";
    if(exchangeTF.text.length == 0)
    {
        [self.view showInfo:@"请输入激活码" autoHidden:YES interval:2];
    }
    else
    {
        NSDictionary *mulDic = @{
                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                 @"ActivationCode":exchangeTF.text
                                 };
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Card/ActivationCardOne",Khttp] success:^(NSDictionary *dict, BOOL success) {
            NSLog(@"---%@",dict);
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                
                if([[[dict objectForKey:@"JsonData"] objectForKey:@"Activationstate"] integerValue] == 3)
                {
                    remindTitle =@"提示";
                    remindStr = [NSString stringWithFormat:@"激活码不存在（请注意大小写）您的剩余激活次数%@次",dict[@"JsonData"][@"RemainTimes"]];
//                    [self.view showInfo:@"对不起，该卡不存在" autoHidden:YES interval:2];
                }
                else if([[[dict objectForKey:@"JsonData"] objectForKey:@"Activationstate"] integerValue] == 1)
                {
                    remindTitle =@"恭喜你，激活成功";
                    remindStr = [NSString stringWithFormat:@"蔷薇洗车%@一张，您的剩余激活次数%@次",dict[@"JsonData"][@"CardName"],dict[@"JsonData"][@"RemainTimes"]];
                }
                else if([[[dict objectForKey:@"JsonData"]objectForKey:@"Activationstate"] integerValue] == 2)
                {
                    remindTitle =@"提示";
                    remindStr = [NSString stringWithFormat:@"该码已被激活过 您的剩余激活次数%@次",dict[@"JsonData"][@"RemainTimes"]];
//                    if([[[dict objectForKey:@"JsonData"] objectForKey:@"CardUseState"] integerValue] == 1)
//                    {
//
//                        [self.view showInfo:@"对不起，该卡已被激活" autoHidden:YES interval:2];
//                    }
//                    else if([[[dict objectForKey:@"JsonData"] objectForKey:@"CardUseState"] integerValue] == 2)
//                    {
//                        [self.view showInfo:@"对不起，该卡已被使用" autoHidden:YES interval:2];
//                    }
//                    else{
//                        [self.view showInfo:@"对不起，该卡已失效" autoHidden:YES interval:2];
//                    }
                }
                else
                {
                    NSInteger  str=[[NSString stringWithFormat:@"%@",dict[@"JsonData"][@"RemainTimes"]]integerValue];
                    if (str==-1) {
                        remindTitle =@"提示";
                        remindStr = @"您今天的激活次数已使用完";
                    }else{
                        remindTitle =@"提示";
                        remindStr = @"激活失败";
                    }
                }
                LKAlertView *alartView      = [[LKAlertView alloc]initWithTitle:remindTitle message:remindStr delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:@""];
                [alartView show];
                
            }
            else
            {
                [self.view showInfo:@"激活失败" autoHidden:YES interval:2];
            }
        } fail:^(NSError *error) {
            [self.view showInfo:@"激活失败" autoHidden:YES interval:2];
            
        }];

    }
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}



@end
