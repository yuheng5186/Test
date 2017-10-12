//
//  MapViewController.m
//  CarWashing
//
//  Created by apple on 2017/10/10.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MapViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "APIKey.h"
//自定义的大头针
#import "AudioModel.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import <Masonry.h>
#import "BusinessDetailViewController.h"

#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "HTTPDefine.h"
#import "CyMapModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
@interface MapViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>
{
    NewPagedFlowView *pageFlowView;
}
@property (nonatomic,strong) MAMapView * mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic,retain) NSMutableArray *locationArray;
@property (nonatomic,strong) CyMapModel *MerChantmodel;
@property (nonatomic,strong) NSDictionary *dicData;
@property (nonatomic,strong) NSMutableArray  *dataArray;

@end

@implementation MapViewController
- (void) drawContent {
    
    self.statusView.hidden      = YES;
    
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
   
    
}
-(void)getData{
    NSDictionary *mulDic = @{
                             @"Xm":@(121.527685),
                             //                             @"Area":@"上海市"
                             @"Ym":@(31.190149)
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Merchant/GetStoreMapList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            self.dicData = dict;
            self.dataArray =[CyMapModel mj_objectArrayWithKeyValuesArray:dict[@"JsonData"]];
            [pageFlowView reloadData];
        }
        else
        {
            [self.view showInfo:@"商家信息获取失败" autoHidden:YES interval:2];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        NSLog(@"---%@",dict);
    } fail:^(NSError *error) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.backgroundColor= [UIColor colorFromHex:@"f6f6f6"];
    _dataArray = [NSMutableArray array];
    [self getData];
    [self showMapView];
//    [self initAnnotations];
    UIView *titleView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, 64) color:[UIColor clearColor]];
    titleView.top                      = 0;
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 8, 70, 64);
    [rightBtn setImage:[UIImage imageNamed:@"ditu_fanhui"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:rightBtn];
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height-(170*Main_Screen_Height/667), Main_Screen_Width, 170*Main_Screen_Height/667)];
    [self.contentView addSubview:bottomView];
    //无限轮播图
    pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 160*Main_Screen_Height/667)];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0;
    //    pageFlowView.minimumPageScale = 0.85;
//    pageFlowView.orginPageCount = self.imageArray.count;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    [bottomView addSubview:pageFlowView];
    [pageFlowView stopTimer];
}
////添加多个大头针
//- (void)initAnnotations
//{
//    NSMutableArray *coordinates = [NSMutableArray array];
//    for (int i = 0; i < self.locationArray.count; i++)
//    {
//        AudioModel *model = [AudioModel new];
//        MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
//        a1.coordinate = CLLocationCoordinate2DMake(model.latitude, model.longitude);
//        [coordinates addObject:a1];
//    }
//    [self.mapView addAnnotations:coordinates];
//}


-(void)showMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    //设置成NO表示关闭指南针；YES表示显示指南针
    self.mapView.showsCompass= NO;
    //设置成NO表示不显示比例尺；YES表示显示比例尺
    self.mapView.showsScale= NO;
    //缩放等级
    [self.mapView setZoomLevel:16 animated:YES];
    //开启定位
    self.mapView.showsUserLocation = YES;
    [self.contentView addSubview:self.mapView];
    
    CLLocationCoordinate2D coor ;
    coor.latitude = 31.190149;
    coor.longitude = 121.527685;
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = coor;
    //设置地图的定位中心点坐标
    self.mapView.centerCoordinate = coor;
    //将点添加到地图上，即所谓的大头针
    [self.mapView addAnnotation:pointAnnotation];
//    CLLocationCoordinate2D coordinates[10] = {
//        {39.992520, 116.336170},
//        {39.992520, 116.336170},
//        {39.998293, 116.352343},
//        {40.004087, 116.348904},
//        {40.001442, 116.353915},
//        {39.989105, 116.353915},
//        {39.989098, 116.360200},
//        {39.998439, 116.360201},
//        {39.979590, 116.324219},
//        {39.978234, 116.352792}};
//
//    for (int i = 0; i < 10; ++i)
//    {
//        MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
//        a1.coordinate = coordinates[i];
//        a1.title      = [NSString stringWithFormat:@"anno: %d", i];
//        a1.coordinate = coor;
//        //设置地图的定位中心点坐标
//        self.mapView.centerCoordinate = coor;
//        [self.locationArray addObject:a1];
//    }
//
//    [self.mapView addAnnotations:self.locationArray];
}
#pragma mark -------  MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
//    MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
    //设置点的经纬度
//    point.coordinate = _currentUL.location.coordinate;
    CLLocation *currentLocation = [[CLLocation alloc]initWithLatitude:31.190149 longitude:121.527685];
    
    // 初始化编码器
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        //获取当前城市位置信息，其中CLPlacemark包括name、thoroughfare、subThoroughfare、locality、subLocality等详细信息
        CLPlacemark *mark = [placemarks lastObject];
        NSString *cityName = mark.locality;
       NSLog(@"城市 - %@", cityName);
//        self.currentCity  = cityName;
    }];
}
#pragma mark ----大头针
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    //大头针标注
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {//判断是否是自己的定位气泡，如果是自己的定位气泡，不做任何设置，显示为蓝点，如果不是自己的定位气泡，比如大头针就会进入
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAAnnotationView*annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.frame = CGRectMake(0, 0, 100, 100);
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        //annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;           //设置标注可以拖动，默认为NO
        //设置大头针显示的图片
        annotationView.image = [UIImage imageNamed:@"dahuang"];
        //点击大头针显示的左边的视图
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        UILabel * addlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        addlabel.text = @"哈哈哈";
        addlabel.textAlignment = NSTextAlignmentCenter;
        addlabel.textColor=[UIColor colorFromHex:@"#999999"];
        [view addSubview:addlabel];
//        UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fenxiangzhuanqian"]];
        annotationView.leftCalloutAccessoryView = view;
        
        //点击大头针显示的右边视图
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
        rightButton.backgroundColor = [UIColor colorFromHex:@"#0161a1"];
        [rightButton setTitle:@"导航" forState:UIControlStateNormal];
        annotationView.rightCalloutAccessoryView = rightButton;
//
//        //        annotationView.image = [UIImage imageNamed:@"redPin"];
        return annotationView;
    }
    return nil;
}
#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(330*Main_Screen_Height/667, 160*Main_Screen_Height/667);
}
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    CyMapModel * model =self.dataArray[subIndex];
    //跳转商家详情
    BusinessDetailViewController *detailController = [[BusinessDetailViewController alloc] init];
    detailController.hidesBottomBarWhenPushed      = YES;
    detailController.MerCode                       =model.MerCode;
    detailController.distance                      = model.Distance;
    [self.navigationController pushViewController:detailController animated:YES];
    
}


#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.dataArray.count;
}


- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    CyMapModel * model = self.dataArray[index];
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, 330*Main_Screen_Height/667, 160*Main_Screen_Height/667)];
        bannerView.layer.cornerRadius = 4*Main_Screen_Height/667;
        bannerView.backgroundColor=[UIColor whiteColor];
        bannerView.layer.masksToBounds = YES;
    }
    else
    {
        //删除cell的所有子视图
        while ([bannerView.subviews lastObject] != nil)
        {
            [(UIView*)[bannerView.subviews lastObject] removeFromSuperview];
        }
    }
    //左边的店铺图片
    UIImageView * leftImageVIew =[[UIImageView alloc]initWithFrame:CGRectMake(20*Main_Screen_Height/667, 20*Main_Screen_Height/667, 80*Main_Screen_Height/667, 80*Main_Screen_Height/667)];
    leftImageVIew.backgroundColor=[UIColor whiteColor];
//    leftImageVIew.image =[UIImage imageNamed:@"Store"];
    [leftImageVIew sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,model.Img]] placeholderImage:nil];
    [bannerView addSubview:leftImageVIew];
    
    UILabel * rzlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50*Main_Screen_Height/667, 20*Main_Screen_Height/667)];
    rzlabel.text = @"V认证";
    rzlabel.font=[UIFont systemFontOfSize:11.0];
    rzlabel.textColor = [UIColor whiteColor];
    rzlabel.backgroundColor=[UIColor colorWithRed:250/255.0 green:172/255.0 blue:0/255.0 alpha:1.0];
    rzlabel.layer.cornerRadius = 2;
    rzlabel.layer.masksToBounds=YES;
    [bannerView addSubview:rzlabel];
    //店铺名称
    UILabel * namelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100*Main_Screen_Height/667, 20*Main_Screen_Height/667)];
//    namelabel.text = @"金雷快修店";
    namelabel.text=[NSString stringWithFormat:@"%@",model.MerName];
    namelabel.font=[UIFont systemFontOfSize:15.0];
    namelabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    [bannerView addSubview:namelabel];
    //店铺类型
    UILabel * typelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50*Main_Screen_Height/667, 20*Main_Screen_Height/667)];
    typelabel.text =@"汽车美容";
//     typelabel.text = [NSString stringWithFormat:@"%@",model.MerName];
    typelabel.font=[UIFont systemFontOfSize:13.0];
    typelabel.textColor = [UIColor colorFromHex:@"#868686"];
    [bannerView addSubview:typelabel];
    //店铺评分
    UILabel * gradelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200*Main_Screen_Height/667, 20*Main_Screen_Height/667)];
    gradelabel.text = [NSString stringWithFormat:@"评分：%ld分",model.Score];
    gradelabel.font=[UIFont systemFontOfSize:15.0];
    gradelabel.textColor = [UIColor colorFromHex:@"#999999"];
    [bannerView addSubview:gradelabel];
    //营业时间
    UILabel * timelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200*Main_Screen_Height/667, 20*Main_Screen_Height/667)];
    timelabel.text = [NSString stringWithFormat:@"营业时间：%@",model.ServiceTime];
    timelabel.font=[UIFont systemFontOfSize:15.0];
    timelabel.textColor = [UIColor colorFromHex:@"#999999"];
    [bannerView addSubview:timelabel];
    //黄图
    UIView * yellowview = [[UIView alloc]init];
    yellowview.backgroundColor=[UIColor colorFromHex:@"#fffbe1"];
    [bannerView addSubview:yellowview];
    //地址
    UILabel * addresslabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200*Main_Screen_Height/667, 20*Main_Screen_Height/667)];
    
    addresslabel.text =[NSString stringWithFormat:@"%@",model.MerAddress];
    addresslabel.font=[UIFont systemFontOfSize:13.0];
    addresslabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    [bannerView addSubview:addresslabel];
    //距离
    UILabel * distancelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60*Main_Screen_Height/667, 20*Main_Screen_Height/667)];
//    distancelabel.text = @"1.25km";
    distancelabel.text =[NSString stringWithFormat:@"%@km",model.Distance];
    distancelabel.font=[UIFont systemFontOfSize:15.0];
    distancelabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    [bannerView addSubview:distancelabel];

    //约束
    [rzlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftImageVIew.mas_top);
        make.left.equalTo(leftImageVIew.mas_right).mas_offset(11*Main_Screen_Height/667);
    }];
    //约束
    [namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftImageVIew.mas_top).offset(-3);
        make.left.equalTo(rzlabel.mas_right).mas_offset(10*Main_Screen_Height/667);
    }];
    //约束
    [typelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftImageVIew.mas_top).offset(-2);
        make.right.equalTo(bannerView.mas_right).mas_offset(-15*Main_Screen_Height/667);
    }];
    //约束
    [gradelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rzlabel.mas_bottom).offset(10*Main_Screen_Height/667);
        make.left.equalTo(rzlabel.mas_left);
    }];
    //约束
    [timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gradelabel.mas_bottom).offset(10*Main_Screen_Height/667);
        make.left.equalTo(rzlabel.mas_left);
    }];
    //约束
    [yellowview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bannerView.mas_bottom);
        make.left.equalTo(bannerView.mas_left);
        make.right.equalTo(bannerView.mas_right);
        make.height.mas_equalTo(40*Main_Screen_Height/667);
    }];
    //约束
    [addresslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yellowview.mas_left).offset(20*Main_Screen_Height/667);
        make.centerY.mas_equalTo(yellowview.mas_centerY);
    }];
    //约束
    [distancelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(yellowview.mas_right).offset(-15*Main_Screen_Height/667);
        make.centerY.mas_equalTo(yellowview.mas_centerY);
    }];
    return bannerView;
}

-(void)rightBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)locationArray{
    
    if (_locationArray == nil) {
        _locationArray = [NSMutableArray new];
        NSArray* a = @[@{@"latitude":@"30.281843",
                               @"longitude":@"120.102193",
                               @"title":@"test-title-1",
                               @"subtitle":@"test-sub-title-11"},
                             @{@"latitude":@"30.290144",
                               @"longitude":@"120.146696‎",
                               @"title":@"test-title-2",
                               @"subtitle":@"test-sub-title-22"},
                             @{@"latitude":@"30.248076",
                               @"longitude":@"120.164162‎",
                               @"title":@"test-title-3",
                               @"subtitle":@"test-sub-title-33"},
                             @{@"latitude":@"30.425622",
                               @"longitude":@"120.299605",
                               @"title":@"test-title-4",
                               @"subtitle":@"test-sub-title-44"}
                             ];
        [_locationArray addObjectsFromArray:a];
    }
    return _locationArray;
}



@end
