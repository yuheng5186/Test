//
//  BusinessDetailViewController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/27.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BusinessDetailViewController.h"
#import "BusinessDetailHeaderView.h"
#import <Masonry.h>
#import "BusinessDetailCell.h"
#import "BusinessEstimateCell.h"
#import "BusinessPayController.h"
#import "ShopViewController.h"
#import "BusinessMapController.h"
#import <MapKit/MapKit.h>


@interface BusinessDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak) BusinessDetailHeaderView *headerView;

@property (nonatomic, weak) UITableView *detailTableView;

@property (nonatomic, strong) NSIndexPath *lastPath;

@property (nonatomic, weak) BusinessDetailCell *detailCell;


#pragma mark - map
@property (nonatomic, assign) double currentLatitude;
@property (nonatomic, assign) double currentLongitute;
@property (nonatomic, assign) double targetLatitude;
@property (nonatomic, assign) double targetLongitute;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) CLLocationManager *manager;
@property (nonatomic, copy) CLLocation *newcllocation;


@end

static NSString *detailTableViewCell = @"detailTableViewCell";
static NSString *businessCommentCell = @"businessCommentCell";

@implementation BusinessDetailViewController

- (void)drawNavigation {
    
    [self drawTitle:@"商家详情"];
    
    [self drawRightImageButton:@"fenxiang" action:@selector(didClickShareButton:)];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.navigationController setNavigationBarHidden:YES];
    //self.title = @"商家详情";
    
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self setupUI];
}


- (void)setupUI {
    
    UIView *containHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 375/2 + 196)];
    [self.view addSubview:containHeadView];
    
    UIImageView *detaiImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 375/2)];
    
    detaiImgView.image = [UIImage imageNamed:@"hangdiantu"];
    
    [containHeadView addSubview:detaiImgView];
    
    
    BusinessDetailHeaderView *headerView = [BusinessDetailHeaderView businessDetailHeaderView];
    
    headerView.frame = CGRectMake(0, 375/2, Main_Screen_Width, 196);
    
    self.headerView = headerView;
    [containHeadView addSubview:headerView];
    //detaiImgView.bottom  = headerView.top;

    [headerView addTarget:self action:@selector(clickDetailView) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITableView *detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 124) style:UITableViewStyleGrouped];
    self.detailTableView = detailTableView;
    
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"BusinessDetailCell" bundle:nil];
    [detailTableView registerNib:nib forCellReuseIdentifier:detailTableViewCell];
    
    [detailTableView registerNib:[UINib nibWithNibName:@"BusinessEstimateCell" bundle:nil] forCellReuseIdentifier:businessCommentCell];
    
    //detailTableView.rowHeight = 100;
    
    detailTableView.tableHeaderView = containHeadView;
    
    [self.view addSubview:detailTableView];
    
    //表尾
    UIButton *commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    [commentBtn setTitle:@"查看全部评价" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor colorFromHex:@"#3a3a3a"] forState:UIControlStateNormal];
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    commentBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:commentBtn];
    
    //添加点击事件
    [commentBtn addTarget:self action:@selector(clickCommentButton) forControlEvents:UIControlEventTouchUpInside];
    
    detailTableView.tableFooterView = commentBtn;
    
    //底部支付栏
    UIView *payToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, Main_Screen_Height - 60, Main_Screen_Width, 60)];
    payToolBar.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:payToolBar];
    
    UILabel *lblPrice = [[UILabel alloc] init];
    lblPrice.text = @"¥24.00";
    lblPrice.font = [UIFont systemFontOfSize:18];
    lblPrice.textColor = [UIColor colorFromHex:@"#ff525a"];
    [payToolBar addSubview:lblPrice];
    
    UILabel *formerPriceLab = [[UILabel alloc] init];
    formerPriceLab.text = @"¥38.00";
    formerPriceLab.textColor = [UIColor colorFromHex:@"#999999"];
    formerPriceLab.font = [UIFont systemFontOfSize:13];
    [payToolBar addSubview:formerPriceLab];
    
    UILabel *lblCarType = [[UILabel alloc] init];
    lblCarType.text = @"标准洗车-五座轿车";
    lblCarType.font = [UIFont systemFontOfSize:13];
    lblCarType.textColor = [UIColor colorFromHex:@"#999999"];
    [payToolBar addSubview:lblCarType];
    
    UIButton *payBtn = [[UIButton alloc] init];
    payBtn.frame     = CGRectMake(Main_Screen_Width - 92, 0, 92, 60);
    [payBtn setTitle:@"去结算" forState:UIControlStateNormal];
    [payBtn setTintColor:[UIColor colorFromHex:@"#ffffff"]];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    //payBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    payBtn.backgroundColor = [UIColor colorFromHex:@"#febb02"];
    [payToolBar addSubview:payBtn];
    
    //跳转支付页面
    [payBtn addTarget:self action:@selector(clickPayButton) forControlEvents:UIControlEventTouchUpInside];
    
    //约束
    [lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(payToolBar).mas_offset(12);
        make.left.equalTo(payToolBar).mas_offset(20);
    }];
    
    [formerPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(lblPrice.mas_trailing).mas_offset(10);
        make.bottom.equalTo(lblPrice);
    }];
    
    [lblCarType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(lblPrice);
        make.top.mas_equalTo(lblPrice.mas_bottom).mas_offset(6);
    }];
    
    /*[payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
     make.width.mas_equalTo(120);
     make.height.mas_equalTo(80);
     make.right.top.equalTo(payToolBar);
     }];
     */
    
    UIButton *serviceBtn = [[UIButton alloc] init];
    [serviceBtn setImage:[UIImage imageNamed:@"kefuzixun"] forState:UIControlStateNormal];
    [serviceBtn addTarget:self action:@selector(didClickServiceBtn:) forControlEvents:UIControlEventTouchUpInside];
    [payToolBar addSubview:serviceBtn];
    
    UILabel *serviceLabel = [[UILabel alloc] init];
    serviceLabel.text = @"客服咨询";
    serviceLabel.font = [UIFont systemFontOfSize:13];
    serviceLabel.textColor = [UIColor colorFromHex:@"#999999"];
    [payToolBar addSubview:serviceLabel];
    
    
    [serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payToolBar).mas_offset(12);
        make.trailing.equalTo(payBtn.mas_leading).mas_equalTo(-37);
        make.width.height.mas_equalTo(20);
    }];
    
    [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(serviceBtn);
        make.top.equalTo(serviceBtn.mas_bottom).mas_offset(7);
    }];
    
}

#pragma mark - 点击拨打客服
- (void)didClickServiceBtn:(UIButton *)button {
    
    NSString *title = @"";
    
    NSString *message = @"是否拨打客服电话";
    
    [self showAlertWithTitle:title message:message];
}

#pragma mark - 点击查看全部评价
- (void)clickCommentButton {
    
    ShopViewController *commentVC = [[ShopViewController alloc] init];
    
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - 点击商家详情
- (void)clickDetailView{
    
    ShopViewController *shopController = [[ShopViewController alloc] init];
    
    [self.navigationController pushViewController:shopController animated:YES];
}

#pragma mark - 支付界面
- (void)clickPayButton {
    
    BusinessPayController *payController = [[BusinessPayController alloc] init];
    
    [self.navigationController pushViewController:payController animated:YES];
}


#pragma mark - tableView代理数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    if (businessDetailCell == nil) {
//        businessDetailCell = [BusinessDetailCell businessDetailCell];
//    }
    if (indexPath.section == 0) {
        BusinessDetailCell *businessDetailCell = [tableView dequeueReusableCellWithIdentifier:detailTableViewCell forIndexPath:indexPath];
        businessDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _detailCell = businessDetailCell;
        
        businessDetailCell.carLabel.text = @"标准洗车-五座轿车";
        businessDetailCell.clearLabel.text = @"整车泡沫冲洗擦干、轮胎轮轴冲洗清洁、车内吸尘、内饰脚垫等简单除尘";
        businessDetailCell.priceLabel.text = @"¥24.00";
        
        //单选状态
        NSInteger row = [indexPath row];
        NSInteger oldRow = [self.lastPath row];
        
        if (row == oldRow && self.lastPath != nil) {
            [businessDetailCell.stateButton setBackgroundImage:[UIImage imageNamed:@"xaunzhong"] forState:UIControlStateNormal];
        }else{
            
            [businessDetailCell.stateButton setBackgroundImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
        }
        
        return businessDetailCell;
    }
    
    BusinessEstimateCell *estimateCell = [tableView dequeueReusableCellWithIdentifier:businessCommentCell forIndexPath:indexPath];
    estimateCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return estimateCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 100;
    }
    
    return 110;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        NSInteger newRow = [indexPath row];
        NSInteger oldRow = (self.lastPath != nil)?[self.lastPath row]:-1;
        
        if (newRow != oldRow) {
            self.detailCell = [tableView cellForRowAtIndexPath:indexPath];
            
            [self.detailCell.stateButton setBackgroundImage:[UIImage imageNamed:@"xaunzhong"] forState:UIControlStateNormal];
            
            self.detailCell = [tableView cellForRowAtIndexPath:self.lastPath];
            
            [self.detailCell.stateButton setBackgroundImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
            
            self.lastPath = indexPath;
            
        }
    }
}


#pragma mark - 设置组头视图
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    UILabel *textLab = [[UILabel alloc] init];
    
    //textLab.backgroundColor = [UIColor colorFromHex:@"#dfdfdf"];
    textLab.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    textLab.font = [UIFont systemFontOfSize:14];
    
    if (section == 0) {
        textLab.text = @"服务活动";
    }else{
        textLab.text = @"评论 (58)";
    }
    
    return textLab.text;
}

//- (NSString *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


#pragma mark - 点击分享按钮
- (void)didClickShareButton:(UIButton *)button {
    
    
}


#pragma mark - 地图导航
- (IBAction)didClickSmallBtn:(UIButton *)sender {
    
//    BusinessMapController *mapVC = [[BusinessMapController alloc] init];
//    mapVC.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:mapVC animated:YES];
    
    
    
    //[self gothereWithAddress:@"外滩" andLat:@"121.24" andLon:@"31.00"];
    
    [self showMapNavigationViewWithtargetLatitude:31.00 targetLongitute:121.24 toName:@"松江"];
}

//方法子
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [PhoneHelper dial: @"1008611"];
        

        
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (IBAction)didClickShopPhoneBtn:(UIButton *)sender {
    
    NSString *message = @"是否拨打商家电话";
    NSString *title = @"";
    [self showAlertWithTitle:title message:message];
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.detailTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    if ([_detailTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_detailTableView.delegate tableView:_detailTableView didSelectRowAtIndexPath:indexPath];
    }
}



- (NSArray *)checkHasOwnApp {
    NSArray *mapSchemeArr = @[@"iosamap://navi",@"baidumap://map/",@"comgooglemaps://"];
    
    NSMutableArray *appListArr = [[NSMutableArray alloc] initWithObjects:@"苹果地图", nil];
    
    for (int i = 0; i < mapSchemeArr.count ; i++) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@
"%@",[mapSchemeArr objectAtIndex:i]]]]) {
            
            if (i ==0) {
                [appListArr addObject:@"高德地图"];
            }else if (i == 1){
                [appListArr addObject:@"百度地图"];
            }else if (i == 2){
                [appListArr addObject:@"谷歌地图"];
            }else if (i == 3){
                
            }
        }
    }
    
    return appListArr;
}

- (void)showMapNavigationViewFormcurrentLatitude:(double)currentLatitude currentLongitute:(double)currentLongitute TotargetLatitude:(double)targetLatitude targetLongitute:(double)targetLongitute toName:(NSString *)name{
    _currentLatitude = currentLatitude;
    _currentLongitute = currentLongitute;
    _targetLatitude = targetLatitude;
    _targetLongitute = targetLongitute;
    _name = name;
    NSArray *appListArr = [self checkHasOwnApp];
    NSString *sheetTitle = [NSString stringWithFormat:@"导航到 %@",name];
    UIActionSheet *sheet;
    if ([appListArr count] == 1) {
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:appListArr[0],nil];
    }else if ([appListArr count] == 2) {
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:appListArr[0],appListArr[1],nil];
    }else if ([appListArr count] == 3){
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:appListArr[0],appListArr[1],appListArr[2],nil];
    }else if ([appListArr count] == 4){
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:appListArr[0],appListArr[1],appListArr[2],appListArr[3],nil];
    }else if ([appListArr count] == 5){
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:appListArr[0],appListArr[1],appListArr[2],appListArr[3],appListArr[4],nil];
    }
    sheet.actionSheetStyle =UIActionSheetStyleBlackOpaque;
    [sheet showInView:self.view];
    
}


#pragma mark-UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *name =_name;
    
    float ios_version=[[[UIDevice currentDevice] systemVersion]floatValue];
    NSString *btnTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    
    if (buttonIndex ==0) {
        if (ios_version <6.0) {//ios6调用goole网页地图
            NSString *urlString = [[NSString alloc]
                                   initWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirfl=d",
                                   _currentLatitude,_currentLongitute,_targetLatitude,_targetLongitute];
            
            NSURL *aURL = [NSURL URLWithString:urlString];
            //打开网页google地图
            [[UIApplication sharedApplication] openURL:aURL];
        }else{//起点
            CLLocationCoordinate2D from =CLLocationCoordinate2DMake(_currentLatitude,_currentLongitute);
            MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:from addressDictionary:nil]];
            currentLocation.name =@"我的位置";
            
            //终点
            CLLocationCoordinate2D to =CLLocationCoordinate2DMake(_targetLatitude,_targetLongitute);
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
            NSLog(@"网页google地图:%f,%f",to.latitude,to.longitude);
            toLocation.name = name;
            NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation,nil];
            NSDictionary *options =@{
                                     MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                     MKLaunchOptionsMapTypeKey:
                                         [NSNumber numberWithInteger:MKMapTypeStandard],
                                     MKLaunchOptionsShowsTrafficKey:@YES
                                     };
            
            //打开苹果自身地图应用
            [MKMapItem openMapsWithItems:items launchOptions:options];
        }
    }
    if ([btnTitle isEqualToString:@"谷歌地图"]) {
        NSString *urlStr = [NSString stringWithFormat:@"comgooglemaps://?saddr=%.8f,%.8f&daddr=%.8f,%.8f&directionsmode=transit",_currentLatitude,_currentLongitute,_targetLatitude,_targetLongitute];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }
    else if ([btnTitle isEqualToString:@"高德地图"]){
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",_currentLatitude,_currentLongitute,@"我的位置",_targetLatitude,_targetLongitute,_name]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *r = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:r];
        //        NSLog(@"%@",_lastAddress);
        
    }
    
    else if ([btnTitle isEqualToString:@"腾讯地图"]){
        
        NSString *urlStr = [NSString stringWithFormat:@"qqmap://map/routeplan?type=drive&fromcoord=%f,%f&tocoord=%f,%f&policy=1",_currentLatitude,_currentLongitute,_targetLatitude,_targetLongitute];
        NSURL *r = [NSURL URLWithString:urlStr];
        [[UIApplication sharedApplication] openURL:r];
    }
    else if([btnTitle isEqualToString:@"百度地图"])
    {
        double AdressLat,AdressLon;
        double NowLat,NowLon;
        
//
//        bd_encrypt(_targetLatitude,_targetLongitute,&AdressLat,&AdressLon);
//        bd_encrypt(_currentLatitude,_currentLongitute, &NowLat, &NowLon);
        
        NSString *stringURL = [NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&&mode=driving",_currentLatitude,_currentLongitute,_targetLatitude,_targetLongitute];
        NSURL *url = [NSURL URLWithString:stringURL];
        [[UIApplication sharedApplication] openURL:url];
    }else if (actionSheet.cancelButtonIndex==buttonIndex){
        //解决点击取消后重复出现选择框的问题
        [actionSheet removeFromSuperview];
        [self stopLocation];
    }
    
    
    
}
- (void)showMapNavigationViewWithtargetLatitude:(double)targetLatitude targetLongitute:(double)targetLongitute toName:(NSString *)name{
    self.newcllocation=[[CLLocation alloc]init];
    [self startLocation];
    _targetLatitude = targetLatitude;
    _targetLongitute = targetLongitute;
    _name = name;
    [self showMapNavigationViewFormcurrentLatitude:self.newcllocation.coordinate.latitude currentLongitute:self.newcllocation.coordinate.longitude TotargetLatitude:_targetLatitude targetLongitute:_targetLongitute toName:_name];
}
//获取经纬度
-(void)startLocation
{
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager  authorizationStatus] != kCLAuthorizationStatusDenied)
    {
        _manager=[[CLLocationManager alloc]init];
        _manager.delegate=self;
        _manager.desiredAccuracy =kCLLocationAccuracyBest;
        [_manager requestAlwaysAuthorization];
        _manager.distanceFilter=100;
        [_manager startUpdatingLocation];
    }
    else
    {
        UIAlertView *alvertView=[[UIAlertView alloc]initWithTitle:@"提示"message:@"请到设置->隐私,打开定位服务"delegate:nil cancelButtonTitle:@"确定"otherButtonTitles: nil];
        [alvertView show];
    }
    
}
#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    self.newcllocation=newLocation;
    
    
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    [self stopLocation];
    
}
-(void)stopLocation
{
    _manager =nil;
}






//-(BOOL)canOpenUrl:(NSString *)string {
//    
//    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:string]];
//    
//}
//
//- (void)gothereWithAddress:(NSString *)address andLat:(NSString *)lat andLon:(NSString *)lon {
//    
//    if ([self canOpenUrl:@"baidumap://"]) {///跳转百度地图
//        
//        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%@,%@|name=%@&mode=driving&coord_type=bd09ll",lat, lon,address] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//        
//        return;
//        
//    }else if ([self canOpenUrl:@"iosamap://"]) {///跳转高德地图
//        
//        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%@&lon=%@&dev=0&style=2",@"神骑出行",@"TrunkHelper",lat, lon] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//        
//        return;
//        
//    }else{////跳转系统地图
//        
//        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
//        
//        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
//        
//        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:loc addressDictionary:nil]];
//        
//        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
//         
//                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
//                                       
//                                       MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
//        
//        return;
//        
//    }
//    
//}






@end
