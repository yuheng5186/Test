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

@interface MySettingViewController ()<UITableViewDelegate,UITableViewDataSource>

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
    
    
    UIView *orderView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    orderView.left                      = Main_Screen_Width*20/375;
    orderView.top                       = 0;
    
    UITapGestureRecognizer  *tapOrderGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOrderButtonClick:)];
    [orderView addGestureRecognizer:tapOrderGesture];
    
    
//    UIImage *orderImage              = [UIImage imageNamed:@"btnImage"];
    UIImageView *orderImageView      = [UIUtil drawCustomImgViewInView:orderView frame:CGRectMake(0, 0, 50,40) imageName:@"btnImage"];
    orderImageView.left              = Main_Screen_Width*10/375;
    orderImageView.top               = Main_Screen_Height*10/667;
    
    NSString *orderName              = @"订单";
    UIFont *orderNameFont            = [UIFont systemFontOfSize:16];
    UILabel *orderNameLabel          = [UIUtil drawLabelInView:orderView frame:[UIUtil textRect:orderName font:orderNameFont] font:orderNameFont text:orderName isCenter:NO];
    orderNameLabel.textColor         = [UIColor blackColor];
    orderNameLabel.centerX           = orderImageView.centerX;
    orderNameLabel.top               = orderImageView.bottom +Main_Screen_Height*10/667;
    
    
    
    
    UIView *favoritesView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    favoritesView.left                      = orderView.right +Main_Screen_Width*25/375;
    favoritesView.top                       = 0;
    
    UITapGestureRecognizer  *favoritesTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapFavoritesButtonClick:)];
    [favoritesView addGestureRecognizer:favoritesTapGesture];
    
    UIImageView *favoritesImageView      = [UIUtil drawCustomImgViewInView:favoritesView frame:CGRectMake(0, 0, 50,40) imageName:@"btnImage"];
    favoritesImageView.left              = Main_Screen_Width*10/375;
    favoritesImageView.top               = Main_Screen_Height*10/667;
    
    NSString *favoritesName              = @"收藏";
    UIFont *favoritesNameFont            = [UIFont systemFontOfSize:16];
    UILabel *favoritesNameLabel          = [UIUtil drawLabelInView:favoritesView frame:[UIUtil textRect:favoritesName font:favoritesNameFont] font:favoritesNameFont text:favoritesName isCenter:NO];
    favoritesNameLabel.textColor         = [UIColor blackColor];
    favoritesNameLabel.centerX           = favoritesImageView.centerX;
    favoritesNameLabel.top               = favoritesImageView.bottom +Main_Screen_Height*10/667;
    
    
    UIView *exchangeView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    exchangeView.left                      = favoritesView.right +Main_Screen_Width*25/375;
    exchangeView.top                       = 0;
    
    UITapGestureRecognizer  *exchangeTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapExchangeButtonClick:)];
    [exchangeView addGestureRecognizer:exchangeTapGesture];
    
    UIImageView *exchangeImageView      = [UIUtil drawCustomImgViewInView:exchangeView frame:CGRectMake(0, 0, 50,40) imageName:@"btnImage"];
    exchangeImageView.left              = Main_Screen_Width*10/375;
    exchangeImageView.top               = Main_Screen_Height*10/667;
    
    NSString *exchangeName              = @"兑换";
    UIFont *exchangeNameFont            = [UIFont systemFontOfSize:16];
    UILabel *exchangeNameLabel          = [UIUtil drawLabelInView:exchangeView frame:[UIUtil textRect:exchangeName font:exchangeNameFont] font:exchangeNameFont text:exchangeName isCenter:NO];
    exchangeNameLabel.textColor         = [UIColor blackColor];
    exchangeNameLabel.centerX           = exchangeImageView.centerX;
    exchangeNameLabel.top               = exchangeImageView.bottom +Main_Screen_Height*10/667;
    
    
    UIView *serviceView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    serviceView.left                      = exchangeView.right +Main_Screen_Width*25/375;
    serviceView.top                       = 0;
    
    UITapGestureRecognizer  *serviceTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapServiceButtonClick:)];
    [serviceView addGestureRecognizer:serviceTapGesture];
    
    UIImageView *serviceImageView      = [UIUtil drawCustomImgViewInView:serviceView frame:CGRectMake(0, 0, 50,40) imageName:@"btnImage"];
    serviceImageView.left              = Main_Screen_Width*10/375;
    serviceImageView.top               = Main_Screen_Height*10/667;
    
    NSString *serviceName              = @"客服";
    UIFont *serviceNameFont            = [UIFont systemFontOfSize:16];
    UILabel *serviceNameLabel          = [UIUtil drawLabelInView:serviceView frame:[UIUtil textRect:serviceName font:serviceNameFont] font:serviceNameFont text:serviceName isCenter:NO];
    serviceNameLabel.textColor         = [UIColor blackColor];
    serviceNameLabel.centerX           = serviceImageView.centerX;
    serviceNameLabel.top               = serviceImageView.bottom +Main_Screen_Height*10/667;
    
    
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height*220/667) style:UITableViewStylePlain];
    self.tableView.top              = upView.bottom +Main_Screen_Height*10/667;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
//    self.tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor  = [UIColor whiteColor];
    self.tableView.scrollEnabled    = NO;
//    self.tableView.tableFooterView  = [UIView new];
    self.tableView.contentInset     = UIEdgeInsetsMake(0, 0, 60, 0);
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return 4;
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
    
    
    if (indexPath.row == 0) {
        cell.imageView.image    = [UIImage imageNamed:@"btnImage"];
        cell.textLabel.text     = @"金顶会员";
        cell.detailTextLabel.text = @"2600积分";

    }else if (indexPath.row == 1)
    {
        cell.imageView.image    = [UIImage imageNamed:@"shopL"];
        cell.textLabel.text     = @"我的爱车";
    }else if (indexPath.row == 2)
    {
        cell.imageView.image    = [UIImage imageNamed:@"icon_defaultavatar"];
        cell.textLabel.text     = @"我的卡券";
        cell.detailTextLabel.text = @"3张优惠券";

    }else if (indexPath.row == 3)
    {
        cell.imageView.image    = [UIImage imageNamed:@"btnImage"];
        cell.textLabel.text     = @"推荐金顶APP";
        cell.detailTextLabel.text = @"奖励300元";

    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    if (indexPath.row == 0) {
        
        DSMembershipController *membershipController        = [[DSMembershipController alloc]init];
        membershipController.hidesBottomBarWhenPushed     = YES;
        [self.navigationController pushViewController: membershipController animated: YES];
        
        
    }else if (indexPath.row == 1){
        
        DSMyCarController *myCarController              = [[DSMyCarController alloc]init];
        myCarController.hidesBottomBarWhenPushed        = YES;
        [self.navigationController pushViewController:myCarController animated:YES];
        
    }else if (indexPath.row == 2){
        
        DSMyCardController *myCardController            = [[DSMyCardController alloc]init];
        myCardController.hidesBottomBarWhenPushed       = YES;
        [self.navigationController pushViewController:myCardController animated:YES];
        
    }else{
    
        DSRecommendController *recommendController      = [[DSRecommendController alloc]init];
        recommendController.hidesBottomBarWhenPushed    = YES;
        [self.navigationController pushViewController:recommendController animated:YES];
    }

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
