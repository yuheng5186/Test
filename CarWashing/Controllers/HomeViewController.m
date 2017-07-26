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

#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"

#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

@interface HomeViewController ()<JFLocationDelegate>

@property (strong, nonatomic) UILabel *resultLabel;
@property (nonatomic, strong) UIButton  *locationButton;
/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;

@end

@implementation HomeViewController


- (void) drawContent {
    
    self.statusView.hidden      = YES;
    
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    self.navigationController.navigationBar.hidden = YES;
    
    [self createSubView];

}
- (void) createSubView {
    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*58/667) color:[UIColor whiteColor]];
    upView.top                      = 0;
    
    NSString *titleName              = @"首页";
    UIFont *titleNameFont            = [UIFont boldSystemFontOfSize:18];
    UILabel *titleNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:titleName font:titleNameFont] font:titleNameFont text:titleName isCenter:NO];
    titleNameLabel.textColor         = [UIColor blackColor];
    titleNameLabel.centerX           = upView.centerX;
    titleNameLabel.centerY           = upView.centerY +Main_Screen_Height*10/667;
    
    NSMutableArray * images = [NSMutableArray array];
    
    for (NSInteger i = 0; i<4; i++)
    {
        [images addObject:[NSString stringWithFormat:@"%02ld.jpg",i+1]];
    }
    
    SXScrPageView * sxView =   [SXScrPageView direcWithtFrame:CGRectMake(0, 80, Main_Screen_Width, 200) ImageArr:images AndImageClickBlock:^(NSInteger index) {
        
        DSAdDetailController *viewVC = [[DSAdDetailController alloc]init];
        [self.navigationController pushViewController:viewVC animated:YES];
        
        
    }];
    [self.view addSubview:sxView];
    
    
    UIImage *messagesImage           = [UIImage imageNamed:@"icon_messagebox"];
    UIButton  *messagesButton        = [UIUtil drawButtonInView:upView frame:CGRectMake(0, 0, messagesImage.size.width, messagesImage.size.height) iconName:@"icon_messagebox" target:self action:@selector(messagesButtonClick:)];
    messagesButton.right             = Main_Screen_Width -Main_Screen_Width*10/375;
    messagesButton.centerY           = titleNameLabel.centerY;
    
    
    UIButton  *locationButton        = [UIButton buttonWithType:UIButtonTypeCustom];
    locationButton.frame             = CGRectMake(0, 0, 100, 30);
    locationButton.backgroundColor   = [UIColor whiteColor];
    [locationButton setTitle:@"上海市" forState:UIControlStateNormal];
    [locationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    locationButton.titleLabel.font   = [UIFont systemFontOfSize:16];
    locationButton.left              = 10;
    locationButton.centerY           = titleNameLabel.centerY;
    [locationButton addTarget:self action:@selector(locationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [locationButton setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
    locationButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -80);
    [locationButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -60, 0, 0)];
    
    [upView addSubview:locationButton];
    
    UIView *payView                   = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    payView.left                      = Main_Screen_Width*20/375;
    payView.top                       = sxView.bottom +Main_Screen_Height*10/375;
    
    UITapGestureRecognizer  *tapPayGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPayButtonClick:)];
    [payView addGestureRecognizer:tapPayGesture];
    
    UIImageView *payImageView      = [UIUtil drawCustomImgViewInView:payView frame:CGRectMake(0, 0, 50,40) imageName:@"btnImage"];
    payImageView.left              = Main_Screen_Width*30/375;
    payImageView.top               = Main_Screen_Height*10/667;
    
    NSString *payName              = @"付钱";
    UIFont *payNameFont            = [UIFont systemFontOfSize:16];
    UILabel *payNameLabel          = [UIUtil drawLabelInView:payView frame:[UIUtil textRect:payName font:payNameFont] font:payNameFont text:payName isCenter:NO];
    payNameLabel.textColor         = [UIColor blackColor];
    payNameLabel.centerX           = payImageView.centerX;
    payNameLabel.top               = payImageView.bottom +Main_Screen_Height*10/667;
    
    
    UIView *scanView                   = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    scanView.left                      = payView.right +Main_Screen_Width*50/375;
    scanView.top                       = sxView.bottom +Main_Screen_Height*10/375;
    
    UITapGestureRecognizer  *tapScanGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScanButtonClick:)];
    [scanView addGestureRecognizer:tapScanGesture];
    
    UIImageView *scanImageView      = [UIUtil drawCustomImgViewInView:scanView frame:CGRectMake(0, 0, 50,40) imageName:@"btnImage"];
    scanImageView.left              = Main_Screen_Width*30/375;
    scanImageView.top               = Main_Screen_Height*10/667;
    
    NSString *scanName              = @"扫码洗车";
    UIFont *scanNameFont            = [UIFont systemFontOfSize:16];
    UILabel *scanNameLabel          = [UIUtil drawLabelInView:scanView frame:[UIUtil textRect:scanName font:scanNameFont] font:scanNameFont text:scanName isCenter:NO];
    scanNameLabel.textColor         = [UIColor blackColor];
    scanNameLabel.centerX           = scanImageView.centerX;
    scanNameLabel.top               = scanImageView.bottom +Main_Screen_Height*10/667;
    
    UIView *cardBagView                   = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width*60/375, Main_Screen_Height*80/667) color:[UIColor clearColor]];
    cardBagView.left                      = scanView.right +Main_Screen_Width*50/375;
    cardBagView.top                       = sxView.bottom +Main_Screen_Height*10/375;
    
    UITapGestureRecognizer  *tapCardBagGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCardBagButtonClick:)];
    [cardBagView addGestureRecognizer:tapCardBagGesture];
    
    UIImageView *cardBagImageView      = [UIUtil drawCustomImgViewInView:cardBagView frame:CGRectMake(0, 0, 50,40) imageName:@"btnImage"];
    cardBagImageView.left              = Main_Screen_Width*30/375;
    cardBagImageView.top               = Main_Screen_Height*10/667;
    
    NSString *cardBagName              = @"卡包";
    UIFont *cardBagNameFont            = [UIFont systemFontOfSize:16];
    UILabel *cardBagNameLabel          = [UIUtil drawLabelInView:cardBagView frame:[UIUtil textRect:cardBagName font:cardBagNameFont] font:cardBagNameFont text:cardBagName isCenter:NO];
    cardBagNameLabel.textColor         = [UIColor blackColor];
    cardBagNameLabel.centerX           = cardBagImageView.centerX;
    cardBagNameLabel.top               = cardBagImageView.bottom +Main_Screen_Height*10/667;
    
    NSString *restName              = @"剩余8次";
    UIFont *restNameFont            = [UIFont systemFontOfSize:16];
    UILabel *restNameLabel          = [UIUtil drawLabelInView:scanView frame:[UIUtil textRect:restName font:restNameFont] font:restNameFont text:restName isCenter:NO];
    restNameLabel.textColor         = [UIColor grayColor];
    restNameLabel.centerX           = scanNameLabel.centerX;
    restNameLabel.top               = scanNameLabel.bottom +Main_Screen_Height*5/667;
    
    UIView *lineView                   = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*1/667) color:[UIColor grayColor]];
    lineView.top                       = cardBagView.bottom +Main_Screen_Height*20/667;
    
    NSString *latestActName              = @"热门活动";
    UIFont *latestActNameFont            = [UIFont systemFontOfSize:16];
    UILabel *latestActNameLabel          = [UIUtil drawLabelInView:self.contentView frame:[UIUtil textRect:latestActName font:latestActNameFont] font:latestActNameFont text:latestActName isCenter:NO];
    latestActNameLabel.textColor         = [UIColor blackColor];
    latestActNameLabel.centerX           = lineView.centerX;
    latestActNameLabel.top               = lineView.bottom +Main_Screen_Height*20/667;
    
    UIView *leftView                    = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, 60, Main_Screen_Height*1/667) color:[UIColor grayColor]];
    leftView.right                      = latestActNameLabel.left -Main_Screen_Width*10/375;
    leftView.centerY                    = latestActNameLabel.centerY;
    
    UIView *rightView                    = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, 60, Main_Screen_Height*1/667) color:[UIColor grayColor]];
    rightView.left                      = latestActNameLabel.right +Main_Screen_Width*10/375;
    rightView.centerY                    = latestActNameLabel.centerY;
    
    
    
    UIImageView *newImageView      = [UIUtil drawCustomImgViewInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width,150) imageName:@"03"];
    newImageView.top               = latestActNameLabel.bottom +Main_Screen_Height*10/667;
    
    NSString *newTitleName              = @"金山车友活动";
    UIFont *newTitleNameFont            = [UIFont systemFontOfSize:16];
    UILabel *newTitleNameLabel          = [UIUtil drawLabelInView:self.contentView frame:[UIUtil textRect:newTitleName font:newTitleNameFont] font:newTitleNameFont text:newTitleName isCenter:NO];
    newTitleNameLabel.textColor         = [UIColor blackColor];
    newTitleNameLabel.left              = Main_Screen_Width*10/375;
    newTitleNameLabel.top               = newImageView.bottom +Main_Screen_Height*10/667;
    NSString *lastTimeName              = @"截止: 7-26";
    UIFont *lastTimeNameFont            = [UIFont systemFontOfSize:16];
    UILabel *lastTimeNameLabel          = [UIUtil drawLabelInView:self.contentView frame:[UIUtil textRect:lastTimeName font:lastTimeNameFont] font:lastTimeNameFont text:lastTimeName isCenter:NO];
    lastTimeNameLabel.textColor         = [UIColor blackColor];
    lastTimeNameLabel.right             = Main_Screen_Width -Main_Screen_Width*10/375;
    lastTimeNameLabel.top               = newImageView.bottom +Main_Screen_Height*10/667;
    
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
    
    
}
- (void) tapScanButtonClick:(id)sender {
    
    
}
- (void) tapCardBagButtonClick:(id)sender {
    
    DSCardGroupController *cardGroupController      = [[DSCardGroupController alloc]init];
    cardGroupController.hidesBottomBarWhenPushed    = YES;
    [self.navigationController pushViewController:cardGroupController animated:YES];
    
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
