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


@interface MySettingViewController ()<UITableViewDelegate,UITableViewDataSource,LKAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

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
    
    [self createSubView];
}

- (void) createSubView {

    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*320/667) color:[UIColor colorFromHex:@"#293754"]];
    upView.top                      = 0;
    
//    UIImage *userImage              = [UIImage imageNamed:@"icon_defaultavatar"];
//    UIImageView *userImageView      = [UIUtil drawCustomImgViewInView:upView frame:CGRectMake(0, 0, userImage.size.width/2, userImage.size.height/2) imageName:@"icon_defaultavatar"];
//    userImageView.top               = Main_Screen_Height*50/667;
//    userImageView.left              = Main_Screen_Width*30/375;
    
    NSString *titleName              = @"我的";
    UIFont *titleNameFont            = [UIFont boldSystemFontOfSize:16];
    UILabel *titleNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:titleName font:titleNameFont] font:titleNameFont text:titleName isCenter:NO];
    titleNameLabel.textColor         = [UIColor whiteColor];
    titleNameLabel.top               = Main_Screen_Height*30/667;
    titleNameLabel.centerX           = upView.centerX;
    
    
//    UIImage *editImage              = [UIImage imageNamed:@"icon_defaultavatar"];
    UIButton  *editButton           = [UIUtil drawButtonInView:upView frame:CGRectMake(0, 0, 80, 80) iconName:@"touxiang" target:self action:@selector(editButtonClick:)];
    editButton.top                  = titleNameLabel.bottom +Main_Screen_Height*15/667;
    editButton.centerX              = titleNameLabel.centerX;

    UIImage *settingImage           = [UIImage imageNamed:@"shezhi"];
    UIButton  *settingButton        = [UIUtil drawButtonInView:upView frame:CGRectMake(0, 0, settingImage.size.width, settingImage.size.height) iconName:@"shezhi" target:self action:@selector(settingButtonClick:)];
    settingButton.centerY           = titleNameLabel.centerY;
    settingButton.right             = Main_Screen_Width -Main_Screen_Width*10/375;
    
    
    NSString *userName              = @"15800781856";
    UIFont *userNameFont            = [UIFont boldSystemFontOfSize:16];
    UILabel *userNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:userName font:userNameFont] font:userNameFont text:userName isCenter:NO];
    userNameLabel.textColor         = [UIColor whiteColor];
    userNameLabel.top               = editButton.bottom +Main_Screen_Height*13/667;
    userNameLabel.centerX           = upView.centerX;
    
    
    
    NSString *membershipString      = @"会员特权";
    UIFont *membershipFont          = [UIFont systemFontOfSize:15];
    UIButton *membershipButton      = [UIUtil drawButtonInView:upView frame:CGRectMake(0, 0, 80, 20) text:membershipString font:membershipFont color:[UIColor whiteColor] target:self action:@selector(menbershipButtonClick:)];
    membershipButton.backgroundColor= [UIColor colorFromHex:@"#FDBB2C"];
    membershipButton.layer.cornerRadius = 10;
    membershipButton.centerX        = editButton.centerX-Main_Screen_Width*50/375;
    membershipButton.top            = userNameLabel.bottom +Main_Screen_Height*10/667;
    
    NSString *signString      = @"会员签到";
    UIFont *signFont          = [UIFont systemFontOfSize:15];
    UIButton *signButton      = [UIUtil drawButtonInView:upView frame:CGRectMake(0, 0, 80, 20) text:signString font:signFont color:[UIColor whiteColor] target:self action:@selector(signButtonClick:)];
    signButton.backgroundColor= [UIColor colorFromHex:@"#5AB2F1"];
    signButton.layer.cornerRadius = 10;
    signButton.centerX        = editButton.centerX +Main_Screen_Width*50/375;
    signButton.top            = userNameLabel.bottom +Main_Screen_Height*10/667;
    
    UIView *backgroudView                  = [UIUtil drawLineInView:upView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*100/667) color:[UIColor whiteColor]];
    backgroudView.bottom                = upView.bottom;
    backgroudView.left                  = upView.left;
    
    UIView *orderView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    orderView.centerX                   = Main_Screen_Width/4 -20;
    orderView.top                       = 0;
    
    UITapGestureRecognizer  *tapOrderGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOrderButtonClick:)];
    [orderView addGestureRecognizer:tapOrderGesture];
    
    UIImage     *orderImage          = [UIImage imageNamed:@"dingdan"];
    UIImageView *orderImageView      = [UIUtil drawCustomImgViewInView:orderView frame:CGRectMake(0, 0, orderImage.size.width,orderImage.size.height) imageName:@"dingdan"];
    orderImageView.centerX           = orderView.width/2;
    orderImageView.top               = Main_Screen_Height*30/667;
    
    NSString *orderName              = @"订单";
    UIFont *orderNameFont            = [UIFont systemFontOfSize:16];
    UILabel *orderNameLabel          = [UIUtil drawLabelInView:orderView frame:[UIUtil textRect:orderName font:orderNameFont] font:orderNameFont text:orderName isCenter:NO];
    orderNameLabel.textColor         = [UIColor blackColor];
    orderNameLabel.centerX           = orderImageView.centerX;
    orderNameLabel.top               = orderImageView.bottom +Main_Screen_Height*10/667;
    
    
    
    
    UIView *favoritesView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    favoritesView.centerX                   = Main_Screen_Width/2;
    favoritesView.top                       = 0;
    
    UITapGestureRecognizer  *favoritesTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapFavoritesButtonClick:)];
    [favoritesView addGestureRecognizer:favoritesTapGesture];
    
    UIImage     *favoritesImage          = [UIImage imageNamed:@"shoucang"];
    UIImageView *favoritesImageView      = [UIUtil drawCustomImgViewInView:favoritesView frame:CGRectMake(0, 0, favoritesImage.size.width,favoritesImage.size.height) imageName:@"shoucang"];
    favoritesImageView.centerX           = favoritesView.width/2;
    favoritesImageView.top               = Main_Screen_Height*30/667;
    
    NSString *favoritesName              = @"收藏";
    UIFont *favoritesNameFont            = [UIFont systemFontOfSize:16];
    UILabel *favoritesNameLabel          = [UIUtil drawLabelInView:favoritesView frame:[UIUtil textRect:favoritesName font:favoritesNameFont] font:favoritesNameFont text:favoritesName isCenter:NO];
    favoritesNameLabel.textColor         = [UIColor blackColor];
    favoritesNameLabel.centerX           = favoritesImageView.centerX;
    favoritesNameLabel.top               = favoritesImageView.bottom +Main_Screen_Height*10/667;
    
    
    UIView *exchangeView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    exchangeView.centerX                   = Main_Screen_Width*3/4 +20;
    exchangeView.top                       = 0;
    
    UITapGestureRecognizer  *exchangeTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapExchangeButtonClick:)];
    [exchangeView addGestureRecognizer:exchangeTapGesture];
    
    UIImage     *exchangeImage          = [UIImage imageNamed:@"duihuanliwu"];
    UIImageView *exchangeImageView      = [UIUtil drawCustomImgViewInView:exchangeView frame:CGRectMake(0, 0, exchangeImage.size.width,exchangeImage.size.height) imageName:@"duihuanliwu"];
    exchangeImageView.centerX           = exchangeView.width/2;
    exchangeImageView.top               = Main_Screen_Height*30/667;
    
    NSString *exchangeName              = @"兑换";
    UIFont *exchangeNameFont            = [UIFont systemFontOfSize:16];
    UILabel *exchangeNameLabel          = [UIUtil drawLabelInView:exchangeView frame:[UIUtil textRect:exchangeName font:exchangeNameFont] font:exchangeNameFont text:exchangeName isCenter:NO];
    exchangeNameLabel.textColor         = [UIColor blackColor];
    exchangeNameLabel.centerX           = exchangeImageView.centerX;
    exchangeNameLabel.top               = exchangeImageView.bottom +Main_Screen_Height*10/667;
    
    
    
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height) style:UITableViewStyleGrouped];
    self.tableView.top              = upView.bottom;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.scrollEnabled    = NO;
    self.tableView.tableFooterView  = [UIView new];
    [self.contentView addSubview:self.tableView];
    
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
    
    DSMemberRightsController *memberRightsVC    = [[DSMemberRightsController alloc]init];
    memberRightsVC.hidesBottomBarWhenPushed     = YES;
    [self.navigationController pushViewController:memberRightsVC animated:YES];
    
}

- (void) signButtonClick:(id)sender {
    
    LKAlertView *alartView      = [[LKAlertView alloc]initWithTitle:nil message:@"签到成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alartView show];
    
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
    return 10.f;
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
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        cell.imageView.image            = [UIImage imageNamed:@"jindinghuiyuan"];
        cell.textLabel.text             = @"金顶会员";
        cell.detailTextLabel.text       = @"2600积分";
        cell.detailTextLabel.textColor  = [UIColor colorFromHex:@"#ffd55e"];
        
    }else if (indexPath.section == 1){
    
        if (indexPath.row == 0) {
            cell.imageView.image        = [UIImage imageNamed:@"wodeaiche"];
            cell.textLabel.text         = @"我的爱车";
        }else{
            cell.imageView.image        = [UIImage imageNamed:@"wwodekaquan"];
            cell.textLabel.text         = @"我的卡券";
            cell.detailTextLabel.text   = @"3张优惠券";
        
        }
    }else{
        cell.imageView.image            = [UIImage imageNamed:@"tuijianjinding"];
        cell.textLabel.text             = @"推荐金顶APP";
        cell.detailTextLabel.text       = @"奖励300元";
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
        DSRecommendController *recommendController              = [[DSRecommendController alloc]init];
        recommendController.hidesBottomBarWhenPushed            = YES;
        [self.navigationController pushViewController:recommendController animated:YES];
    }

}

#pragma mark ---LKAlertViewDelegate---
- (void)alertView:(LKAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    

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
