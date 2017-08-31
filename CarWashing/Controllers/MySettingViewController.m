//
//  MySettingViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/19.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MySettingViewController.h"
#import "DSUserInfoController.h"
#import "DSSettingController.h"
#import "DSMembershipController.h"
#import "DSOrderController.h"
#import "DSFavoritesController.h"
#import "DSExchangeController.h"
#import "DSServiceController.h"
#import "DSMyCarController.h"
#import "DSMemberRightsController.h"
#import "DSMyCardController.h"
#import "DSRecommendController.h"
#import "DSCardGroupController.h"

#import "UIImageView+WebCache.h"

#import "PopupView.h"
#import "LewPopupViewAnimationDrop.h"

#import "ShareWeChatController.h"
#import "HTTPDefine.h"
#import "AppDelegate.h"
#import "HYActivityView.h"
#import "UdStorage.h"
#import "AFNetworkingTool.h"
#import "LCMD5Tool.h"




@interface MySettingViewController ()<UITableViewDelegate,UITableViewDataSource,SetTabBarDelegate>

{
    
    NSString *title;
    UIImage *image;
    NSURL *url;
    enum WXScene scene;
    
    NSArray *activity;
}
@property (nonatomic, strong) HYActivityView *activityView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIButton  *editButton;



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
    self.navigationController.navigationBar.hidden = YES;
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(noticeupdateUserName:) name:@"updatenamesuccess" object:nil];
    
    [center addObserver:self selector:@selector(noticeupdateUserheadimg:) name:@"updateheadimgsuccess" object:nil];
    [self createSubView];
}

- (void) createSubView {

    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*320/667) color:[UIColor colorFromHex:@"#293754"]];
    upView.top                      = 0;
    
    
    NSString *titleName              = @"";
    UIFont *titleNameFont            = [UIFont boldSystemFontOfSize:16*Main_Screen_Height/667];
    UILabel *titleNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:titleName font:titleNameFont] font:titleNameFont text:titleName isCenter:NO];
    titleNameLabel.textColor         = [UIColor whiteColor];
    titleNameLabel.top               = Main_Screen_Height*30/667;
    titleNameLabel.centerX           = upView.centerX;
    
    
//    UIImage *editImage              = [UIImage imageNamed:@"icon_defaultavatar"];
    
    
    self.editButton           = [UIUtil drawButtonInView:upView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*80/667) iconName:@"touxiang" target:self action:@selector(editButtonClick:)];
    self.editButton.top                  = titleNameLabel.bottom +Main_Screen_Height*5/667;
    self.editButton.centerX              = titleNameLabel.centerX;
    self.editButton.layer.masksToBounds = YES;
    self.editButton.layer.cornerRadius = Main_Screen_Height*40/667;
    if(APPDELEGATE.currentUser.userImagePath.length > 0)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,APPDELEGATE.currentUser.userImagePath];
        NSURL *url=[NSURL URLWithString:ImageURL];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *img=[UIImage imageWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.editButton setImage:img forState:UIControlStateNormal];
            });
        });
    }


    UIImage *settingImage           = [UIImage imageNamed:@"shezhi"];
    UIButton  *settingButton        = [UIUtil drawButtonInView:upView frame:CGRectMake(0, 0, settingImage.size.width, settingImage.size.height) iconName:@"shezhi" target:self action:@selector(settingButtonClick:)];
    settingButton.centerY           = titleNameLabel.centerY;
    settingButton.right             = Main_Screen_Width -Main_Screen_Width*10/375;
    
    
//    NSString *userName              = APPDELEGATE.currentUser.userName;
    UIFont *userNameFont            = [UIFont boldSystemFontOfSize:Main_Screen_Height*16/667];
    self.userNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:APPDELEGATE.currentUser.userName font:userNameFont] font:userNameFont text:APPDELEGATE.currentUser.userName isCenter:NO];
    self.userNameLabel.textColor         = [UIColor whiteColor];
    self.userNameLabel.top               = self.editButton.bottom +Main_Screen_Height*13/667;
    self.userNameLabel.centerX           = upView.centerX;

    
    
    NSString *membershipString      = @"个人信息";
    UIFont *membershipFont          = [UIFont boldSystemFontOfSize:Main_Screen_Height*15/667];
    UIButton *membershipButton      = [UIUtil drawButtonInView:upView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*25/667) text:membershipString font:membershipFont color:[UIColor whiteColor] target:self action:@selector(menbershipButtonClick:)];
    membershipButton.backgroundColor= [UIColor colorFromHex:@"#FDBB2C"];
    membershipButton.layer.cornerRadius = membershipButton.height/2;
    membershipButton.centerX        = self.editButton.centerX-Main_Screen_Width*50/375;
    membershipButton.top            = self.userNameLabel.bottom +Main_Screen_Height*10/667;
    
    NSString *signString      = @"每日签到";
    UIFont *signFont          = [UIFont boldSystemFontOfSize:Main_Screen_Height*15/667];
    UIButton *signButton      = [UIUtil drawButtonInView:upView frame:CGRectMake(0, 0, Main_Screen_Width*80/375, Main_Screen_Height*25/667) text:signString font:signFont color:[UIColor whiteColor] target:self action:@selector(signButtonClick:)];
    signButton.backgroundColor= [UIColor colorFromHex:@"#5AB2F1"];
    signButton.layer.cornerRadius = signButton.height/2;
    signButton.centerX        = self.editButton.centerX +Main_Screen_Width*50/375;
    signButton.top            = self.userNameLabel.bottom +Main_Screen_Height*10/667;
    
    UIView *backgroudView                  = [UIUtil drawLineInView:upView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*100/667) color:[UIColor whiteColor]];
    backgroudView.bottom                = upView.bottom;
    backgroudView.left                  = upView.left;
    
    UIView *orderView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    orderView.centerX                   = Main_Screen_Width/4 -Main_Screen_Width*20/375;
    orderView.top                       = Main_Screen_Height*10/667;
    
    UITapGestureRecognizer  *tapOrderGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOrderButtonClick:)];
    [orderView addGestureRecognizer:tapOrderGesture];
    
    UIImage     *orderImage          = [UIImage imageNamed:@"dingdan"];
    UIImageView *orderImageView      = [UIUtil drawCustomImgViewInView:orderView frame:CGRectMake(0, 0, orderImage.size.width,orderImage.size.height) imageName:@"dingdan"];
    orderImageView.centerX           = orderView.width/2;
    orderImageView.top               = Main_Screen_Height*15/667;
    
    NSString *orderName              = @"订单";
    UIFont *orderNameFont            = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    UILabel *orderNameLabel          = [UIUtil drawLabelInView:orderView frame:[UIUtil textRect:orderName font:orderNameFont] font:orderNameFont text:orderName isCenter:NO];
    orderNameLabel.textColor         = [UIColor blackColor];
    orderNameLabel.centerX           = orderImageView.centerX;
    orderNameLabel.top               = orderImageView.bottom +Main_Screen_Height*10/667;
    
    
    
    
    UIView *favoritesView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    favoritesView.centerX                   = Main_Screen_Width/2;
    favoritesView.top                       = Main_Screen_Height*10/667;
    
    UITapGestureRecognizer  *favoritesTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapFavoritesButtonClick:)];
    [favoritesView addGestureRecognizer:favoritesTapGesture];
    
    UIImage     *favoritesImage          = [UIImage imageNamed:@"shoucang"];
    UIImageView *favoritesImageView      = [UIUtil drawCustomImgViewInView:favoritesView frame:CGRectMake(0, 0, favoritesImage.size.width,favoritesImage.size.height) imageName:@"shoucang"];
    favoritesImageView.centerX           = favoritesView.width/2;
    favoritesImageView.top               = Main_Screen_Height*15/667;
    
    NSString *favoritesName              = @"收藏";
    UIFont *favoritesNameFont            = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    UILabel *favoritesNameLabel          = [UIUtil drawLabelInView:favoritesView frame:[UIUtil textRect:favoritesName font:favoritesNameFont] font:favoritesNameFont text:favoritesName isCenter:NO];
    favoritesNameLabel.textColor         = [UIColor blackColor];
    favoritesNameLabel.centerX           = favoritesImageView.centerX;
    favoritesNameLabel.top               = favoritesImageView.bottom +Main_Screen_Height*10/667;
    
    
    UIView *exchangeView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    exchangeView.centerX                   = Main_Screen_Width*3/4 +Main_Screen_Width*20/375;
    exchangeView.top                       = Main_Screen_Height*10/667;
    
    UITapGestureRecognizer  *exchangeTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapExchangeButtonClick:)];
    [exchangeView addGestureRecognizer:exchangeTapGesture];
    
    UIImage     *exchangeImage          = [UIImage imageNamed:@"duihuanliwu"];
    UIImageView *exchangeImageView      = [UIUtil drawCustomImgViewInView:exchangeView frame:CGRectMake(0, 0, exchangeImage.size.width,exchangeImage.size.height) imageName:@"duihuanliwu"];
    exchangeImageView.centerX           = exchangeView.width/2;
    exchangeImageView.top               = Main_Screen_Height*15/667;
    
    NSString *exchangeName              = @"激活";
    UIFont *exchangeNameFont            = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    UILabel *exchangeNameLabel          = [UIUtil drawLabelInView:exchangeView frame:[UIUtil textRect:exchangeName font:exchangeNameFont] font:exchangeNameFont text:exchangeName isCenter:NO];
    exchangeNameLabel.textColor         = [UIColor blackColor];
    exchangeNameLabel.centerX           = exchangeImageView.centerX;
    exchangeNameLabel.top               = exchangeImageView.bottom +Main_Screen_Height*10/667;
    
    backgroudView.height                = exchangeView.bottom +Main_Screen_Height*10/667;
    
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height) style:UITableViewStyleGrouped];
    self.tableView.top              = backgroudView.bottom;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.scrollEnabled    = NO;
    self.tableView.tableFooterView  = [UIView new];
    
    [self.contentView addSubview:self.tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
}

#pragma mark -------button click------
- (void) editButtonClick:(id)sender {
    
    DSUserInfoController *userInfoController    = [[DSUserInfoController alloc]init];
    userInfoController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoController animated:YES];

}

- (void) settingButtonClick:(id)sender {
    
    DSSettingController *settingVC              = [[DSSettingController alloc]init];
    settingVC.hidesBottomBarWhenPushed          = YES;
    [self.navigationController pushViewController:settingVC animated:YES];

}
- (void) menbershipButtonClick:(id)sender {
    
//    DSMemberRightsController *memberRightsVC    = [[DSMemberRightsController alloc]init];
//    memberRightsVC.hidesBottomBarWhenPushed     = YES;
//    [self.navigationController pushViewController:memberRightsVC animated:YES];
    
    DSUserInfoController *userInfoController    = [[DSUserInfoController alloc]init];
    userInfoController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoController animated:YES];
    
}

- (void) signButtonClick:(id)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMdd"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    if([UdStorage getObjectforKey:@"SignTime"])
    {
        if([[UdStorage getObjectforKey:@"SignTime"] intValue]<[currentTimeString intValue])
        {
            NSDictionary *mulDic = @{
                                     @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"]
                                     };
            NSDictionary *params = @{
                                     @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                     @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                     };
            
            [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@User/AddUserSign",Khttp] success:^(NSDictionary *dict, BOOL success) {
                
                if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
                {
                    
                    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
                    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
                    [inputFormatter setDateFormat:@"yyyy/MM/dd"];
                    NSDate* inputDate = [inputFormatter dateFromString:[[dict objectForKey:@"JsonData"] objectForKey:@"SignTime"]];
                    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                    [outputFormatter setLocale:[NSLocale currentLocale]];
                    [outputFormatter setDateFormat:@"yyyyMMdd"];
                    NSString *targetTime = [outputFormatter stringFromDate:inputDate];
                    
                    [UdStorage storageObject:targetTime forKey:@"SignTime"];
                    
                    APPDELEGATE.currentUser.UserScore = APPDELEGATE.currentUser.UserScore + 10;
                    
                    [UdStorage storageObject:[NSString stringWithFormat:@"%ld",APPDELEGATE.currentUser.UserScore] forKey:@"UserScore"];
                    
                    
                    PopupView *view = [PopupView defaultPopupView];
                    view.parentVC = self;
                    
                    [self.tableView reloadData];
                    
                    [self lew_presentPopupView:view animation:[LewPopupViewAnimationDrop new] dismissed:^{
                        
                    }];
                }
                
                else
                {
                    [self.view showInfo:@"签到失败" autoHidden:YES interval:2];
                }
                
                
                
            } fail:^(NSError *error) {
                [self.view showInfo:@"签到失败" autoHidden:YES interval:2];
            }];
            
        }
        else
        {
            [self.view showInfo:@"今天已经签过到了" autoHidden:YES interval:2];
        }
    }
    else
    {
        NSDictionary *mulDic = @{
                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"]
                                 };
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@User/AddUserSign",Khttp] success:^(NSDictionary *dict, BOOL success) {
            
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                
                NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
                [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
                [inputFormatter setDateFormat:@"yyyy/MM/dd"];
                NSDate* inputDate = [inputFormatter dateFromString:[[dict objectForKey:@"JsonData"] objectForKey:@"SignTime"]];
                NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                [outputFormatter setLocale:[NSLocale currentLocale]];
                [outputFormatter setDateFormat:@"yyyyMMdd"];
                NSString *targetTime = [outputFormatter stringFromDate:inputDate];
                
                [UdStorage storageObject:targetTime forKey:@"SignTime"];
                
                APPDELEGATE.currentUser.UserScore = APPDELEGATE.currentUser.UserScore + 10;
                
                [UdStorage storageObject:[NSString stringWithFormat:@"%ld",APPDELEGATE.currentUser.UserScore] forKey:@"UserScore"];
                
                [self.tableView reloadData];
                
                PopupView *view = [PopupView defaultPopupView];
                view.parentVC = self;
                
                [self lew_presentPopupView:view animation:[LewPopupViewAnimationDrop new] dismissed:^{
                    
                }];
            }
            
            else
            {
                [self.view showInfo:@"签到失败" autoHidden:YES interval:2];
            }
            
            
            
        } fail:^(NSError *error) {
            [self.view showInfo:@"签到失败" autoHidden:YES interval:2];
        }];
        
    }


    
}

#pragma mark -------tapGesture click------
- (void) tapOrderButtonClick:(id)sender {
    
    DSOrderController *orderVC              = [[DSOrderController alloc]init];
    orderVC.hidesBottomBarWhenPushed        = YES;
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (void) tapFavoritesButtonClick:(id)sender {
    
    DSFavoritesController *favoritesVC      = [[DSFavoritesController alloc]init];
    favoritesVC.hidesBottomBarWhenPushed    = YES;
    [self.navigationController pushViewController:favoritesVC animated:YES];
}

- (void) tapExchangeButtonClick:(id)sender {
    
    DSExchangeController *exchangeVC        = [[DSExchangeController alloc]init];
    exchangeVC.hidesBottomBarWhenPushed     = YES;
    [self.navigationController pushViewController:exchangeVC animated:YES];
}

- (void) tapServiceButtonClick:(id)sender {
    
    DSServiceController *serviceVC          = [[DSServiceController alloc]init];
    serviceVC.hidesBottomBarWhenPushed      = YES;
    [self.navigationController pushViewController:serviceVC animated:YES];
}

#pragma mark - UITableViewDataSource
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f*Main_Screen_Height/667;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section

{
    return 0.01f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    return 0;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*Main_Screen_Height/667;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor    = [UIColor blackColor];
    cell.textLabel.font         = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.font   = [UIFont systemFontOfSize:14];

    if (indexPath.section == 0) {
        cell.imageView.image            = [UIImage imageNamed:@"jindinghuiyuan"];
        cell.textLabel.text             = @"蔷薇会员";
        cell.detailTextLabel.text       = [NSString stringWithFormat:@"%ld积分",APPDELEGATE.currentUser.UserScore];
        cell.detailTextLabel.textColor  = [UIColor colorFromHex:@"#ffd55e"];
        
    }else if (indexPath.section == 1){
    
        if (indexPath.row == 0) {
            cell.imageView.image        = [UIImage imageNamed:@"wodeaiche"];
            cell.textLabel.text         = @"我的爱车";
        }else{
            cell.imageView.image        = [UIImage imageNamed:@"wwodekaquan"];
            cell.textLabel.text         = @"我的卡券";
//            cell.detailTextLabel.text   = @"3张优惠券";
        
        }
    }else{
        cell.imageView.image            = [UIImage imageNamed:@"tuijianjinding"];
        cell.textLabel.text             = @"推荐蔷薇APP";
//        cell.detailTextLabel.text       = @"奖励300元";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DSMembershipController *membershipController        = [[DSMembershipController alloc]init];
            membershipController.hidesBottomBarWhenPushed       = YES;
            [self.navigationController pushViewController: membershipController animated: YES];
            
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            DSMyCarController *myCarController                  = [[DSMyCarController alloc]init];
            myCarController.hidesBottomBarWhenPushed            = YES;
            [self.navigationController pushViewController:myCarController animated:YES];
        }else{
            
            DSCardGroupController *cardGroupController      = [[DSCardGroupController alloc]init];
            cardGroupController.hidesBottomBarWhenPushed    = YES;
            [self.navigationController pushViewController:cardGroupController animated:YES];
            
//            DSMyCardController *myCardController                = [[DSMyCardController alloc]init];
//            myCardController.hidesBottomBarWhenPushed           = YES;
//            [self.navigationController pushViewController:myCardController animated:YES];
        }
    }else{
//        ShareWeChatController *shareVC = [[ShareWeChatController alloc] init];
//        shareVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//        shareVC.delegate = self;
//        
//        self.tabBarController.tabBar.hidden = YES;
//        [self presentViewController:shareVC animated:NO completion:nil];
        if (!self.activityView)
        {
            self.activityView = [[HYActivityView alloc]initWithTitle:@"" referView:self.view];
            self.activityView.delegate = self;
            //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
            self.activityView.numberOfButtonPerLine = 6;
            
            ButtonView *bv ;
            
            bv = [[ButtonView alloc]initWithText:@"微信" image:[UIImage imageNamed:@"btn_share_weixin"] handler:^(ButtonView *buttonView){
                NSLog(@"点击微信");
                SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
                req.text                = @"简单文本分享测试";
                req.bText               = YES;
                // 目标场景
                // 发送到聊天界面  WXSceneSession
                // 发送到朋友圈    WXSceneTimeline
                // 发送到微信收藏  WXSceneFavorite
                req.scene               = WXSceneSession;
                [WXApi sendReq:req];
                
                self.tabBarController.tabBar.hidden = NO;

            }];
            [self.activityView addButtonView:bv];
            
            bv = [[ButtonView alloc]initWithText:@"微信朋友圈" image:[UIImage imageNamed:@"btn_share_pengyouquan"] handler:^(ButtonView *buttonView){
                NSLog(@"点击微信朋友圈");
                SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
                req.text                = @"简单文本分享测试";
                req.bText               = YES;
                // 目标场景
                // 发送到聊天界面  WXSceneSession
                // 发送到朋友圈    WXSceneTimeline
                // 发送到微信收藏  WXSceneFavorite
                req.scene               = WXSceneTimeline;
                [WXApi sendReq:req];
                self.tabBarController.tabBar.hidden = NO;

            }];
            [self.activityView addButtonView:bv];
            
            
        }
        self.tabBarController.tabBar.hidden = YES;

        [self.activityView show];
        
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    
}

-(void)noticeupdateUserName:(NSNotification *)sender{
    self.userNameLabel.frame = [UIUtil textRect:APPDELEGATE.currentUser.userName font:[UIFont boldSystemFontOfSize:16*Main_Screen_Height/667]];
    self.userNameLabel.top               = self.editButton.bottom +Main_Screen_Height*13/667;
    self.userNameLabel.centerX           = Main_Screen_Width/2;
    self.userNameLabel.text = APPDELEGATE.currentUser.userName;
}


-(void)noticeupdateUserheadimg:(NSNotification *)sender{
//    UIImageView *imageV = [[UIImageView alloc]init];
//    NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,APPDELEGATE.currentUser.userImagePath];
//    NSURL *url=[NSURL URLWithString:ImageURL];
//    [imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,APPDELEGATE.currentUser.userImagePath];
        NSURL *url=[NSURL URLWithString:ImageURL];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *img=[UIImage imageWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.editButton setImage:img forState:UIControlStateNormal];
        });
    });
}





#pragma mark - modal代理
- (void)setTabBarIsHide:(UIViewController *)VC {
    
    self.tabBarController.tabBar.hidden = NO;
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
