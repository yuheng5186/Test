//
//  PurchaseViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/19.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "PurchaseViewController.h"
#import "PurchaseCardViewCell.h"
#import "PayPurchaseCardController.h"

#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"


#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]
@interface PurchaseViewController ()<UITableViewDelegate, UITableViewDataSource, JFLocationDelegate>

@property (nonatomic, weak) UITableView *purchaseCardView;

@property (nonatomic, strong) NSArray *titles;

/** 选择的结果*/
@property (strong, nonatomic) UILabel *resultLabel;
@property (nonatomic, strong) UIButton  *locationButton;
/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;

@end

static NSString *id_puchaseCard = @"purchaseCardCell";

@implementation PurchaseViewController

- (JFAreaDataManager *)manager {
    if (!_manager) {
        _manager = [JFAreaDataManager shareManager];
        [_manager areaSqliteDBData];
    }
    return _manager;
}



- (void) drawContent {
    
    self.statusView.hidden      = YES;
    
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    [self setupUI];
}


- (UITableView *)purchaseCardView {
    if (!_purchaseCardView) {
        
        UITableView *purchaseCardView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 108) style:UITableViewStylePlain];
        
        self.purchaseCardView = purchaseCardView;
        [self.view addSubview:purchaseCardView];
    }
    
    return _purchaseCardView;
}


- (void)setupUI {
    
    
    self.purchaseCardView.delegate = self;
    self.purchaseCardView.dataSource = self;
    
    [self.purchaseCardView registerClass:[PurchaseCardViewCell class] forCellReuseIdentifier:id_puchaseCard];
    
    self.purchaseCardView.rowHeight = 200;
    self.purchaseCardView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //定位按钮
    self.locationManager = [[JFLocation alloc] init];
    _locationManager.delegate = self;
    
    
    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*58/667) color:[UIColor whiteColor]];
    upView.top                      = 0;
    
    NSString *titleName              = @"购卡";
    UIFont *titleNameFont            = [UIFont boldSystemFontOfSize:18];
    UILabel *titleNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:titleName font:titleNameFont] font:titleNameFont text:titleName isCenter:NO];
    titleNameLabel.textColor         = [UIColor blackColor];
    titleNameLabel.centerX           = upView.centerX;
    titleNameLabel.centerY           = upView.centerY +Main_Screen_Height*10/667;
    
    self.locationButton        = [UIButton buttonWithType:UIButtonTypeCustom];
    self.locationButton.frame             = CGRectMake(0, 0, 100, 30);
    self.locationButton.backgroundColor   = [UIColor whiteColor];
    [self.locationButton setTitle:@"上海市" forState:UIControlStateNormal];
    [self.locationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.locationButton.titleLabel.font   = [UIFont systemFontOfSize:16];
    self.locationButton.left              = 10;
    self.locationButton.centerY           = titleNameLabel.centerY;
    [self.locationButton addTarget:self action:@selector(clickLocationButton) forControlEvents:UIControlEventTouchUpInside];
    [self.locationButton setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
    self.locationButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -80);
    [self.locationButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -60, 0, 0)];
    
    [upView addSubview:self.locationButton];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PurchaseCardViewCell *purchaseCardCell = [tableView dequeueReusableCellWithIdentifier:id_puchaseCard forIndexPath:indexPath];
    //purchaseCardCell.layer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor lightGrayColor]);
    purchaseCardCell.backgroundColor = [UIColor lightGrayColor];
    purchaseCardCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return purchaseCardCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PayPurchaseCardController *payCardController = [[PayPurchaseCardController alloc] init];
    
    payCardController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:payCardController animated:YES];
}


- (void)clickLocationButton {
    
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

#pragma mark - JFLocationDelegate
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
