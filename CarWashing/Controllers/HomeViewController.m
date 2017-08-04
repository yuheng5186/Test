//
//  HomeViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/19.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "HomeViewController.h"
#import "DSMessagesController.h"
#import "SXScrPageView.h"
#import "DSAdDetailController.h"
#import "DSCardGroupController.h"
#import "PurchaseViewController.h"
#import "MenuTabBarController.h"
#import "DSExchangeController.h"

#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"

#import "DSMembershipController.h"
#import "DSMemberRightsController.h"
#import "DSServiceController.h"
#import "DSMyCarController.h"
#import "FindViewController.h"
#import "ScanController.h"

#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

@interface HomeViewController ()<JFLocationDelegate,UITableViewDelegate,UITableViewDataSource>

/** 选择的结果*/
@property (strong, nonatomic) UILabel *resultLabel;
@property (nonatomic, strong) UIButton  *locationButton;
/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HomeViewController


- (void) drawContent {
    
    self.statusView.hidden      = YES;
    
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
    self.contentView.backgroundColor    = [UIColor colorFromHex:@"#293754"];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    self.navigationController.navigationBar.hidden = YES;
    
    [self createSubView];
    
    self.locationManager = [[JFLocation alloc] init];
    _locationManager.delegate = self;
    
}
- (JFAreaDataManager *)manager {
    if (!_manager) {
        _manager = [JFAreaDataManager shareManager];
        [_manager areaSqliteDBData];
    }
    return _manager;
}

- (void) createSubView {
    
    [self createNavTitleView];
    
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height) style:UITableViewStyleGrouped];
    self.tableView.top              = self.navigationView.bottom;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    //    self.tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor  = [UIColor colorFromHex:@"#f6f6f6"];
    //    self.tableView.scrollEnabled    = NO;
//    self.tableView.tableFooterView  = [UIView new];
//    self.tableView.tableHeaderView  = [UIView new];
    
//    self.tableView.bounces  = NO;
    self.tableView.contentInset     = UIEdgeInsetsMake(0, 0, 180, 0);
    [self.contentView addSubview:self.tableView];
    
    [self createHeaderView];
    
}



- (void) createNavTitleView {
    
    UIView *titleView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*64/667) color:[UIColor colorFromHex:@"#293754"]];
    titleView.top                      = 0;
    
    NSString *titleName              = @"    ";
    UIFont *titleNameFont            = [UIFont boldSystemFontOfSize:18];
    UILabel *titleNameLabel          = [UIUtil drawLabelInView:titleView frame:[UIUtil textRect:titleName font:titleNameFont] font:titleNameFont text:titleName isCenter:NO];
    titleNameLabel.textColor         = [UIColor blackColor];
    titleNameLabel.centerX           = titleView.centerX;
    titleNameLabel.centerY           = titleView.centerY +Main_Screen_Height*10/667;
    
    UIImage *messagesImage           = [UIImage imageNamed:@"xiaoxi"];
    UIButton  *messagesButton        = [UIUtil drawButtonInView:titleView frame:CGRectMake(0, 0, messagesImage.size.width, messagesImage.size.height) iconName:@"xiaoxi" target:self action:@selector(messagesButtonClick:)];
    messagesButton.right             = Main_Screen_Width -Main_Screen_Width*10/375;
    messagesButton.centerY           = titleNameLabel.centerY;
    
    UIImage *downloadImage           = [UIImage imageNamed:@"xiazai"];
    UIButton  *downloadButton        = [UIUtil drawButtonInView:titleView frame:CGRectMake(0, 0, downloadImage.size.width, downloadImage.size.height) iconName:@"xiazai" target:self action:@selector(messagesButtonClick:)];
    downloadButton.right             = messagesButton.left -20;
    downloadButton.centerY           = titleNameLabel.centerY;
    
    UIImage *searchImage           = [UIImage imageNamed:@"sousuo"];
    UIButton  *searchButton        = [UIUtil drawButtonInView:titleView frame:CGRectMake(0, 0, searchImage.size.width, searchImage.size.height) iconName:@"sousuo" target:self action:@selector(messagesButtonClick:)];
    searchButton.right             = downloadButton.left -20;
    searchButton.centerY           = titleNameLabel.centerY;
    

    
    
    
    UIImage *logeImage              = [UIImage imageNamed:@"xichebaidi"];
    UIImageView *logoImageView      = [UIUtil drawCustomImgViewInView:titleView frame:CGRectMake(0, 0, logeImage.size.width,logeImage.size.height) imageName:@"xichebaidi"];
    logoImageView.left              = Main_Screen_Width*20/375;
    logoImageView.centerY           = titleNameLabel.centerY;
    
    
    NSString *logoName              = @"金顶洗车";
    UIFont *logoNameFont            = [UIFont boldSystemFontOfSize:14];
    UILabel *logoNameLabel          = [UIUtil drawLabelInView:titleView frame:[UIUtil textRect:logoName font:logoNameFont] font:logoNameFont text:logoName isCenter:NO];
    logoNameLabel.textColor         = [UIColor whiteColor];
    logoNameLabel.left              = logoImageView.right +20;
    logoNameLabel.centerY           = logoImageView.centerY;
    
    
    
    
    
    
    
    self.locationButton        = [UIButton buttonWithType:UIButtonTypeCustom];
    self.locationButton.frame             = CGRectMake(0, 0, 100, 30);
    self.locationButton.backgroundColor   = [UIColor whiteColor];
    [self.locationButton setTitle:@"上海市" forState:UIControlStateNormal];
    [self.locationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.locationButton.titleLabel.font   = [UIFont systemFontOfSize:16];
    self.locationButton.left              = 10;
    self.locationButton.centerY           = titleNameLabel.centerY;
    [self.locationButton addTarget:self action:@selector(locationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.locationButton setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
    self.locationButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -80);
    [self.locationButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -60, 0, 0)];
    
//    [titleView addSubview:self.locationButton];
}

- (void) createHeaderView {
    
    UIView *headerView = [UIView new];
    headerView.width = [UIScreen mainScreen].bounds.size.width;
    headerView.height   = Main_Screen_Height*505/667;
    headerView.backgroundColor  = [UIColor whiteColor];
    self.tableView.tableHeaderView  = headerView;

    UIView *backgroudView           = [UIView new];
    backgroudView.width             = [UIScreen mainScreen].bounds.size.width;
    backgroudView.height            = Main_Screen_Height*150/667;
    backgroudView.backgroundColor   = [UIColor colorFromHex:@"#293754"];
    backgroudView.top               = 0;
    backgroudView.left              = 0;
    [headerView addSubview:backgroudView];
    
    UIView *scanView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    scanView.centerX                   = Main_Screen_Width/8;
    scanView.top                       = Main_Screen_Height*20/375;
    
    UITapGestureRecognizer  *tapScanGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScanButtonClick:)];
    [scanView addGestureRecognizer:tapScanGesture];
    UIImage *scanImage              = [UIImage imageNamed:@"saoyisao"];
    UIImageView *scanImageView      = [UIUtil drawCustomImgViewInView:scanView frame:CGRectMake(0, 0, scanImage.size.width,scanImage.size.height) imageName:@"saoyisao"];
    scanImageView.centerX           = scanView.size.width/2;
    scanImageView.top               = Main_Screen_Height*10/667;
    
    NSString *scanName              = @"扫一扫";
    UIFont *scanNameFont            = [UIFont systemFontOfSize:16];
    UILabel *scanNameLabel          = [UIUtil drawLabelInView:scanView frame:[UIUtil textRect:scanName font:scanNameFont] font:scanNameFont text:scanName isCenter:NO];
    scanNameLabel.textColor         = [UIColor colorFromHex:@"#fefefe"];
    scanNameLabel.centerX           = scanImageView.centerX;
    scanNameLabel.top               = scanImageView.bottom +Main_Screen_Height*10/667;
    
    UIView *cardBagView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    cardBagView.centerX                   = Main_Screen_Width*3/8;
    cardBagView.top                       = Main_Screen_Height*20/375;
    
    UITapGestureRecognizer  *tapCardBagGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCardBagButtonClick:)];
    [cardBagView addGestureRecognizer:tapCardBagGesture];
    
    UIImage *cardImage                 = [UIImage imageNamed:@"kabao"];
    UIImageView *cardBagImageView      = [UIUtil drawCustomImgViewInView:cardBagView frame:CGRectMake(0, 0, cardImage.size.width,cardImage.size.height) imageName:@"kabao"];
    cardBagImageView.centerX           = cardBagView.size.width/2;
    cardBagImageView.top               = Main_Screen_Height*10/667;
    
    NSString *cardBagName              = @"卡包";
    UIFont *cardBagNameFont            = [UIFont systemFontOfSize:16];
    UILabel *cardBagNameLabel          = [UIUtil drawLabelInView:cardBagView frame:[UIUtil textRect:cardBagName font:cardBagNameFont] font:cardBagNameFont text:cardBagName isCenter:NO];
    cardBagNameLabel.textColor         = [UIColor colorFromHex:@"#fefefe"];
    cardBagNameLabel.centerX           = cardBagImageView.centerX;
    cardBagNameLabel.top               = cardBagImageView.bottom +Main_Screen_Height*10/667;
    
    
    UIView *discountView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    discountView.centerX                   = Main_Screen_Width*5/8;
    discountView.top                       = Main_Screen_Height*20/375;
    
    UITapGestureRecognizer  *tapDiscountGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDiscountButtonClick:)];
    [discountView addGestureRecognizer:tapDiscountGesture];
    
    UIImage *discountImage              = [UIImage imageNamed:@"youhui"];
    UIImageView *discountImageView      = [UIUtil drawCustomImgViewInView:discountView frame:CGRectMake(0, 0, discountImage.size.width,discountImage.size.height) imageName:@"youhui"];
    discountImageView.centerX           = discountView.size.width/2;
    discountImageView.top               = Main_Screen_Height*10/667;
    
    NSString *discountName              = @"优惠";
    UIFont *discountNameFont            = [UIFont systemFontOfSize:16];
    UILabel *discountNameLabel          = [UIUtil drawLabelInView:discountView frame:[UIUtil textRect:discountName font:discountNameFont] font:discountNameFont text:discountName isCenter:NO];
    discountNameLabel.textColor         = [UIColor colorFromHex:@"#fefefe"];
    discountNameLabel.centerX           = discountImageView.centerX;
    discountNameLabel.top               = discountImageView.bottom +Main_Screen_Height*10/667;
    
    
    UIView *scoreView                   = [UIUtil drawLineInView:backgroudView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    scoreView.centerX                   = Main_Screen_Width*7/8;
    scoreView.top                       = Main_Screen_Height*20/375;
    
    UITapGestureRecognizer  *tapScoreGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScoreButtonClick:)];
    [scoreView addGestureRecognizer:tapScoreGesture];
    
    UIImage *scoreImage              = [UIImage imageNamed:@"jifen"];
    UIImageView *scoreImageView      = [UIUtil drawCustomImgViewInView:scoreView frame:CGRectMake(0, 0, scoreImage.size.width,scoreImage.size.height) imageName:@"jifen"];
    scoreImageView.centerX           = scoreView.size.width/2;
    scoreImageView.top               = Main_Screen_Height*10/667;
    
    NSString *scoreName              = @"积分";
    UIFont *scoreNameFont            = [UIFont systemFontOfSize:16];
    UILabel *scoreNameLabel          = [UIUtil drawLabelInView:scoreView frame:[UIUtil textRect:scoreName font:scoreNameFont] font:scoreNameFont text:scoreName isCenter:NO];
    scoreNameLabel.textColor         = [UIColor colorFromHex:@"#fefefe"];
    scoreNameLabel.centerX           = scoreImageView.centerX;
    scoreNameLabel.top               = scoreImageView.bottom +Main_Screen_Height*10/667;
    

    
    
    
    
//    NSString *restName              = @"剩余8次";
//    UIFont *restNameFont            = [UIFont systemFontOfSize:16];
//    UILabel *restNameLabel          = [UIUtil drawLabelInView:scanView frame:[UIUtil textRect:restName font:restNameFont] font:restNameFont text:restName isCenter:NO];
//    restNameLabel.textColor         = [UIColor grayColor];
//    restNameLabel.centerX           = scanNameLabel.centerX;
//    restNameLabel.top               = scanNameLabel.bottom +Main_Screen_Height*5/667;
    
    
//    UIView *lineView                   = [UIUtil drawLineInView:headerView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*1/667) color:[UIColor grayColor]];
//    lineView.top                       = cardBagView.bottom +Main_Screen_Height*40/667;
    
    
    UIView *payView                   = [UIUtil drawLineInView:headerView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    payView.centerX                   = Main_Screen_Width/8;
    payView.top                       = backgroudView.bottom +Main_Screen_Height*10/375;
    
    UITapGestureRecognizer  *tapPayGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPayButtonClick:)];
    [payView addGestureRecognizer:tapPayGesture];
    UIImage *payImage              = [UIImage imageNamed:@"libao"];
    UIImageView *payImageView      = [UIUtil drawCustomImgViewInView:payView frame:CGRectMake(0, 0, payImage.size.width,payImage.size.height) imageName:@"libao"];
    payImageView.left              = Main_Screen_Width*20/375;
    payImageView.top               = Main_Screen_Height*10/667;
    
    NSString *payName              = @"兑换礼品";
    UIFont *payNameFont            = [UIFont systemFontOfSize:16];
    UILabel *payNameLabel          = [UIUtil drawLabelInView:payView frame:[UIUtil textRect:payName font:payNameFont] font:payNameFont text:payName isCenter:NO];
    payNameLabel.textColor         = [UIColor blackColor];
    payNameLabel.centerX           = payImageView.centerX;
    payNameLabel.top               = payImageView.bottom +Main_Screen_Height*10/667;
    
    UIView *signView                   = [UIUtil drawLineInView:headerView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    signView.centerX                   = Main_Screen_Width*3/8;
    signView.top                       = backgroudView.bottom +Main_Screen_Height*10/375;
    
    UITapGestureRecognizer  *tapSignGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSignButtonClick:)];
    [signView addGestureRecognizer:tapSignGesture];
    
    UIImage *signImage              = [UIImage imageNamed:@"qiandao"];
    UIImageView *signImageView      = [UIUtil drawCustomImgViewInView:signView frame:CGRectMake(0, 0, signImage.size.width,signImage.size.height) imageName:@"qiandao"];
    signImageView.left              = Main_Screen_Width*20/375;
    signImageView.top               = Main_Screen_Height*10/667;
    
    NSString *signName              = @"每日签到";
    UIFont *signNameFont            = [UIFont systemFontOfSize:16];
    UILabel *signNameLabel          = [UIUtil drawLabelInView:signView frame:[UIUtil textRect:signName font:signNameFont] font:signNameFont text:signName isCenter:NO];
    signNameLabel.textColor         = [UIColor blackColor];
    signNameLabel.centerX           = signImageView.centerX;
    signNameLabel.top               = signImageView.bottom +Main_Screen_Height*10/667;
    
    UIView *memberRightView                   = [UIUtil drawLineInView:headerView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    memberRightView.centerX                   = Main_Screen_Width*5/8;
    memberRightView.top                       = backgroudView.bottom +Main_Screen_Height*10/375;
    
    UITapGestureRecognizer  *tapMemberRightGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMemberRightButtonClick:)];
    [memberRightView addGestureRecognizer:tapMemberRightGesture];
    
    UIImage *memberImage                   = [UIImage imageNamed:@"huiyuan"];
    UIImageView *memberRightImageView      = [UIUtil drawCustomImgViewInView:memberRightView frame:CGRectMake(0, 0, memberImage.size.width,memberImage.size.height) imageName:@"huiyuan"];
    memberRightImageView.left              = Main_Screen_Width*20/375;
    memberRightImageView.top               = Main_Screen_Height*10/667;
    
    NSString *rightName              = @"会员特权";
    UIFont *rightNameFont            = [UIFont systemFontOfSize:16];
    UILabel *rightNameLabel          = [UIUtil drawLabelInView:memberRightView frame:[UIUtil textRect:rightName font:rightNameFont] font:rightNameFont text:rightName isCenter:NO];
    rightNameLabel.textColor         = [UIColor blackColor];
    rightNameLabel.centerX           = memberRightImageView.centerX;
    rightNameLabel.top               = memberRightImageView.bottom +Main_Screen_Height*10/667;
    
    
    UIView *serviceView                   = [UIUtil drawLineInView:headerView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    serviceView.centerX                   = Main_Screen_Width*7/8;
    serviceView.top                       = backgroudView.bottom +Main_Screen_Height*10/375;
    
    UITapGestureRecognizer  *tapServiceGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapServiceButtonClick:)];
    [serviceView addGestureRecognizer:tapServiceGesture];
    
    UIImage *serviceImage              = [UIImage imageNamed:@"kefu"];
    UIImageView *serviceImageView      = [UIUtil drawCustomImgViewInView:serviceView frame:CGRectMake(0, 0, serviceImage.size.width,serviceImage.size.height) imageName:@"kefu"];
    serviceImageView.left              = Main_Screen_Width*20/375;
    serviceImageView.top               = Main_Screen_Height*10/667;
    
    NSString *serviceName              = @"客服咨询";
    UIFont *serviceNameFont            = [UIFont systemFontOfSize:16];
    UILabel *serviceNameLabel          = [UIUtil drawLabelInView:serviceView frame:[UIUtil textRect:serviceName font:serviceNameFont] font:serviceNameFont text:serviceName isCenter:NO];
    serviceNameLabel.textColor         = [UIColor blackColor];
    serviceNameLabel.centerX           = memberRightImageView.centerX;
    serviceNameLabel.top               = memberRightImageView.bottom +Main_Screen_Height*10/667;
    
    
    UIView *myCarView                   = [UIUtil drawLineInView:headerView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    myCarView.centerX                   = Main_Screen_Width/8;
    myCarView.top                       = payView.bottom +Main_Screen_Height*10/375;
    
    UITapGestureRecognizer  *tapMyCarGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMyCarButtonClick:)];
    [myCarView addGestureRecognizer:tapMyCarGesture];
    
    UIImage *myCarImage              = [UIImage imageNamed:@"qiche"];
    UIImageView *myCarImageView      = [UIUtil drawCustomImgViewInView:myCarView frame:CGRectMake(0, 0, myCarImage.size.width,myCarImage.size.height) imageName:@"qiche"];
    myCarImageView.left              = Main_Screen_Width*20/375;
    myCarImageView.top               = Main_Screen_Height*10/667;
    
    
    NSString *myCarName              = @"我的爱车";
    UIFont *myCarNameFont            = [UIFont systemFontOfSize:16];
    UILabel *myCarNameLabel          = [UIUtil drawLabelInView:myCarView frame:[UIUtil textRect:myCarName font:myCarNameFont] font:myCarNameFont text:myCarName isCenter:NO];
    myCarNameLabel.textColor         = [UIColor blackColor];
    myCarNameLabel.centerX           = myCarImageView.centerX;
    myCarNameLabel.top               = myCarImageView.bottom +Main_Screen_Height*10/667;
    
    UIView *shareView                   = [UIUtil drawLineInView:headerView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    shareView.centerX                   = Main_Screen_Width*3/8;
    shareView.top                       = payView.bottom +Main_Screen_Height*10/375;
    
    UITapGestureRecognizer  *tapShareGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShareButtonClick:)];
    [shareView addGestureRecognizer:tapShareGesture];
    
    UIImage *shareImage              = [UIImage imageNamed:@"shouyefenxiang"];
    UIImageView *shareImageView      = [UIUtil drawCustomImgViewInView:shareView frame:CGRectMake(0, 0, shareImage.size.width,shareImage.size.height) imageName:@"shouyefenxiang"];
    shareImageView.left              = Main_Screen_Width*20/375;
    shareImageView.top               = Main_Screen_Height*10/667;
    
    NSString *shareName              = @"分享赚钱";
    UIFont *shareNameFont            = [UIFont systemFontOfSize:16];
    UILabel *shareNameLabel          = [UIUtil drawLabelInView:shareView frame:[UIUtil textRect:shareName font:shareNameFont] font:shareNameFont text:shareName isCenter:NO];
    shareNameLabel.textColor         = [UIColor blackColor];
    shareNameLabel.centerX           = shareImageView.centerX;
    shareNameLabel.top               = shareImageView.bottom +Main_Screen_Height*10/667;
    
    UIView *shopView                   = [UIUtil drawLineInView:headerView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    shopView.centerX                   = Main_Screen_Width*5/8;
    shopView.top                       = payView.bottom +Main_Screen_Height*10/375;
    
    UITapGestureRecognizer  *tapShopGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapShopButtonClick:)];
    [shopView addGestureRecognizer:tapShopGesture];
    
    UIImage *shopImage              = [UIImage imageNamed:@"shangjiaruzhu"];
    UIImageView *shopImageView      = [UIUtil drawCustomImgViewInView:shopView frame:CGRectMake(0, 0, shopImage.size.width,shopImage.size.height) imageName:@"shangjiaruzhu"];
    shopImageView.left              = Main_Screen_Width*20/375;
    shopImageView.top               = Main_Screen_Height*10/667;
    
    NSString *shopName              = @"商家入驻";
    UIFont *shopNameFont            = [UIFont systemFontOfSize:16];
    UILabel *shopNameLabel          = [UIUtil drawLabelInView:shopView frame:[UIUtil textRect:shopName font:shopNameFont] font:shopNameFont text:shopName isCenter:NO];
    shopNameLabel.textColor         = [UIColor blackColor];
    shopNameLabel.centerX           = shopImageView.centerX;
    shopNameLabel.top               = shopImageView.bottom +Main_Screen_Height*10/667;
    
    
    UIView *carClubView                   = [UIUtil drawLineInView:headerView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    carClubView.centerX                   = Main_Screen_Width*7/8;
    carClubView.top                       = payView.bottom +Main_Screen_Height*10/375;
    
    UITapGestureRecognizer  *tapCarClubGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCarClubButtonClick:)];
    [carClubView addGestureRecognizer:tapCarClubGesture];
    
    UIImage *carClubImage              = [UIImage imageNamed:@"cheyouquan"];
    UIImageView *carClubImageView      = [UIUtil drawCustomImgViewInView:carClubView frame:CGRectMake(0, 0, carClubImage.size.width,carClubImage.size.height) imageName:@"cheyouquan"];
    carClubImageView.left              = Main_Screen_Width*20/375;
    carClubImageView.top               = Main_Screen_Height*10/667;
    
    NSString *carClubName              = @"车友圈";
    UIFont *carClubNameFont            = [UIFont systemFontOfSize:16];
    UILabel *CarClubNameLabel          = [UIUtil drawLabelInView:carClubView frame:[UIUtil textRect:carClubName font:carClubNameFont] font:carClubNameFont text:carClubName isCenter:NO];
    CarClubNameLabel.textColor         = [UIColor blackColor];
    CarClubNameLabel.centerX           = carClubImageView.centerX;
    CarClubNameLabel.top               = carClubImageView.bottom +Main_Screen_Height*10/667;
    
    UIImage *newManImage                 = [UIImage imageNamed:@"GO"];
    UIImageView *newManImageView      = [UIUtil drawCustomImgViewInView:headerView frame:CGRectMake(0, 0, newManImage.size.width,newManImage.size.height) imageName:@"GO"];
    newManImageView.centerX           = headerView.centerX;
    newManImageView.top               = carClubView.bottom;

//    UIImage *activityImage                 = [UIImage imageNamed:@"02"];
    UIImageView *activityImageView      = [UIUtil drawCustomImgViewInView:headerView frame:CGRectMake(0, 0, Main_Screen_Width,90) imageName:@"WechatIMG4"];
    activityImageView.centerX           = headerView.centerX;
    activityImageView.top               = newManImageView.bottom+10;
    
//    NSMutableArray * images = [NSMutableArray array];
//
//    for (NSInteger i = 0; i<4; i++)
//    {
//        [images addObject:[NSString stringWithFormat:@"%02ld.jpg",i+1]];
//    }
//
//    SXScrPageView * sxView =   [SXScrPageView direcWithtFrame:CGRectMake(0, 80, Main_Screen_Width, 200) ImageArr:images AndImageClickBlock:^(NSInteger index) {
//
//        DSAdDetailController *viewVC = [[DSAdDetailController alloc]init];
//        [self.navigationController pushViewController:viewVC animated:YES];
//
//    }];
//    sxView.top  =   carClubView.bottom +Main_Screen_Height*10/667;
//    [headerView addSubview:sxView];
    
//    UIView *newBagView                  = [UIUtil drawLineInView:headerView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*120/667) color:[UIColor clearColor]];
//    newBagView.top                      = sxView.bottom +Main_Screen_Height*10/667;
//    
//    UIImageView *newImageView           = [UIUtil drawCustomImgViewInView:newBagView frame:CGRectMake(0, 0, Main_Screen_Width,120) imageName:@"banka"];
//    newImageView.top                    = 0;
//    
//    UITapGestureRecognizer  *tapNewGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapNewButtonClick:)];
//    [newBagView addGestureRecognizer:tapNewGesture];
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 90;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1f;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    NSString *imageString               = @"xiaofeijilu";
    
    if (indexPath.section == 1) {
        imageString         = @"zensong";
    }
    
    if (indexPath.section == 2) {
        imageString         = @"quanyi";
    }
    
    UIImage *recordImage                = [UIImage imageNamed:imageString];
    UIImageView  *recordimageView       = [UIUtil drawCustomImgViewInView:cell.contentView frame:CGRectMake(0, 0, recordImage.size.width, recordImage.size.height) imageName:imageString];
    recordimageView.left                = Main_Screen_Width*12/375;
    recordimageView.top                 = Main_Screen_Height*12/667;
    
    NSString *titleString              = @"消费记录";
    if (indexPath.section == 1) {
        titleString     = @"用户权益";
    }
    if (indexPath.section == 2) {
        titleString     = @"洗车赠送";
    }
    
    UIFont *titleStringFont            = [UIFont systemFontOfSize:14];
    UILabel *titleStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:titleString font:titleStringFont] font:titleStringFont text:titleString isCenter:NO];
    titleStringLabel.textColor         = [UIColor colorFromHex:@"#4a4a4a"];
    titleStringLabel.left              = recordimageView.right +Main_Screen_Width*13/375;
    titleStringLabel.top               = Main_Screen_Height*10/667;
    
    NSString *timeString              = @"2017-7-27 15:30";
    UIFont *timeStringFont            = [UIFont systemFontOfSize:14];
    UILabel *timeStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:timeString font:timeStringFont] font:timeStringFont text:timeString isCenter:NO];
    timeStringLabel.textColor         = [UIColor colorFromHex:@"#999999"];
    timeStringLabel.left              = recordimageView.right +Main_Screen_Width*13/375;
    timeStringLabel.top               = titleStringLabel.bottom +Main_Screen_Height*5/667;
    
    NSString *contentString              = @"线下扫码支付";
    UIFont *contentStringFont            = [UIFont systemFontOfSize:12];
    UILabel *contentStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:contentString font:contentStringFont] font:contentStringFont text:contentString isCenter:NO];
    contentStringLabel.textColor         = [UIColor colorFromHex:@"#868686"];
    contentStringLabel.right             = Main_Screen_Width -Main_Screen_Width*12/375;
    contentStringLabel.top               = Main_Screen_Height*9/667;
    
    NSString    *vipString           = @"";
    if (indexPath.section == 1) {
        vipString   = @"zhuanxiang";

    }
    if (indexPath.section == 2) {
        vipString   = @"huiyuanzhuanxiang";

    }
    
    UIImage *vipImage                = [UIImage imageNamed:vipString];
    UIImageView  *vipImageView       = [UIUtil drawCustomImgViewInView:cell.contentView frame:CGRectMake(0, 0, vipImage.size.width, vipImage.size.height) imageName:vipString];
    vipImageView.right               = Main_Screen_Width -Main_Screen_Width*14/375;
    vipImageView.top                 = Main_Screen_Height*12/667;
    vipImageView.hidden              = YES;
    
    NSString *contentShowString              = @"¥ 18.00";
    
    if (indexPath.section == 1) {
        contentShowString   = @"您有一张现金券可使用";
        contentStringLabel.hidden   = YES;
        vipImageView.hidden         = NO;
    }
    
    if (indexPath.section == 2) {
        contentShowString   = @"恭喜您获得洗车月卡一张";
        contentStringLabel.hidden   = YES;
        vipImageView.hidden         = NO;
    }
    
    UIFont *contentShowStringFont            = [UIFont systemFontOfSize:18];
    UILabel *contentShowStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:contentShowString font:contentShowStringFont] font:contentShowStringFont text:contentShowString isCenter:NO];
    contentShowStringLabel.textColor         = [UIColor colorFromHex:@"#3a3a3a"];
    contentShowStringLabel.centerX           = Main_Screen_Width/2;
    contentShowStringLabel.top               = Main_Screen_Height*58/667;
    
    
    if (indexPath.section == 3) {
        UIImageView  *bankaImageView       = [UIUtil drawCustomImgViewInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width, 90) imageName:@"banka"];
        bankaImageView.left                = 0;
        bankaImageView.top                 = 0;
    }
    
//    NSString *remindShowString              = @"还剩余8次自动扫码洗车";
//    UIFont *remindShowStringFont            = [UIFont systemFontOfSize:18];
//    UILabel *remindShowStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:remindShowString font:remindShowStringFont] font:remindShowStringFont text:remindShowString isCenter:NO];
//    remindShowStringLabel.textColor         = [UIColor blackColor];
//    remindShowStringLabel.left              = contentShowStringLabel.left;
//    remindShowStringLabel.top               = contentShowStringLabel.bottom +Main_Screen_Height*10/667;
    
//    if (indexPath.row == 0) {
//        recordimageView.image           = nil;
//        titleStringLabel.text           = nil;
//        timeStringLabel.text            = nil;
//        contentStringLabel.text         = nil;
//        contentShowStringLabel.text     = nil;
//        remindShowStringLabel.text      = nil;
//        
//        
//        
//    }if (indexPath.row == 1) {
//        recordimageView.image   = [UIImage imageNamed:@"quanyi"];
//        titleStringLabel.text   = @"用户权益";
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


- (void) messagesButtonClick:(id)sender {
    
    DSMessagesController *messageController     = [[DSMessagesController alloc]init];
    messageController.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:messageController animated:YES];
}

- (void) locationButtonClick:(id)sender {
    
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.title = @"城市";
    __weak typeof(self) weakSelf = self;
    [cityViewController choseCityBlock:^(NSString *cityName) {
        
        [weakSelf.locationButton setTitle:cityName forState:UIControlStateNormal];
        
        weakSelf.resultLabel.text = cityName;
    }];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cityViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}
#pragma mark --- JFLocationDelegate

//定位中...
- (void)locating {
    NSLog(@"定位中...");
}

//定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    NSString *city = [locationDictionary valueForKey:@"City"];
    if (![_resultLabel.text isEqualToString:city]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _resultLabel.text = city;
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"locationCity"];
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"currentCity"];
            [self.manager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
                [KCURRENTCITYINFODEFAULTS setObject:cityNumber forKey:@"cityNumber"];
            }];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

/// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    NSLog(@"%@",message);
}

/// 定位失败
- (void)locateFailure:(NSString *)message {
    NSLog(@"%@",message);
}

- (void) tapPayButtonClick:(id)sender {
    DSExchangeController *exchangeVC        = [[DSExchangeController alloc]init];
    exchangeVC.hidesBottomBarWhenPushed     = YES;
    [self.navigationController pushViewController:exchangeVC animated:YES];
    
}
- (void) tapScanButtonClick:(id)sender {
    
    ScanController * vc = [[ScanController alloc] init];
    vc.returnScanBarCodeValue = ^(NSString * barCodeString){
        self.resultLabel.text = [NSString stringWithFormat:@"扫描结果:\n%@",barCodeString];
        NSLog(@"扫描结果的字符串======%@",barCodeString);
    };
    //    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void) tapCardBagButtonClick:(id)sender {
    
    DSCardGroupController *cardGroupController      = [[DSCardGroupController alloc]init];
    cardGroupController.hidesBottomBarWhenPushed    = YES;
    [self.navigationController pushViewController:cardGroupController animated:YES];
    
}
- (void) tapDiscountButtonClick:(id)sender {

    

}

- (void) tapScoreButtonClick:(id)sender {
    
    DSMembershipController *membershipController        = [[DSMembershipController alloc]init];
    membershipController.hidesBottomBarWhenPushed       = YES;
    [self.navigationController pushViewController: membershipController animated: YES];
}

- (void) tapSignButtonClick:(id)sender {


}
- (void) tapMemberRightButtonClick:(id)sender {

    DSMemberRightsController *memberRightsVC    = [[DSMemberRightsController alloc]init];
    memberRightsVC.hidesBottomBarWhenPushed     = YES;
    [self.navigationController pushViewController:memberRightsVC animated:YES];

}
- (void) tapServiceButtonClick:(id)sender {

    DSServiceController *serviceVC          = [[DSServiceController alloc]init];
    serviceVC.hidesBottomBarWhenPushed      = YES;
    [self.navigationController pushViewController:serviceVC animated:YES];
}
- (void) tapMyCarButtonClick:(id)sender {
    
    DSMyCarController *myCarController                  = [[DSMyCarController alloc]init];
    myCarController.hidesBottomBarWhenPushed            = YES;
    [self.navigationController pushViewController:myCarController animated:YES];
}
- (void) tapShareButtonClick:(id)sender {
    
    
}
- (void) tapShopButtonClick:(id)sender {
    
    
}
- (void) tapCarClubButtonClick:(id)sender {
    
    FindViewController *findController      = [[FindViewController alloc]init];
//    findController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:findController animated:YES];
}

- (void) tapNewButtonClick:(id)sender {

    MenuTabBarController *menuTabBarController	= [[MenuTabBarController alloc] init];
    [menuTabBarController setSelectedIndex:3];
    menuTabBarController.tabBarItem.tag = 3;
//    [menuTabBarController didSelectRouterAction];
    
    PurchaseViewController *purchaseController  = [[PurchaseViewController alloc]init];
    purchaseController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:purchaseController animated:YES];

}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//
//    
////    NSLog(@"%f",self.tableView.contentOffset.y);
//    if (scrollView.contentOffset.y <= 0) {
//        scrollView.bounces = NO;
//        
//        NSLog(@"禁止下拉");
//    }
//    else
//        if (scrollView.contentOffset.y >= 0){
////            scrollView.bounces = YES;
//            NSLog(@"允许上拉");
//            
//        }

//    if（scrollView.contentOffset.y <= 0 ）{
//        scrollView.contentOffset.y = 0
//    }
//    // 禁止上拉
//    if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height {
//        scrollView.contentOffset.y = scrollView.contentSize.height - scrollView.bounds.size.height
//    }
//}

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
