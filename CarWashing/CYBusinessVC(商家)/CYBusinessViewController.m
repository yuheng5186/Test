//
//  CYBusinessViewController.m
//  CarWashing
//
//  Created by apple on 2017/12/4.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYBusinessViewController.h"

#import "QWMclistTableViewCell.h"

#import "JSDropDownMenu.h"
#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"
#import "CoreLocation/CoreLocation.h"

#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "HTTPDefine.h"
#import "MBProgressHUD.h"
#import "UdStorage.h"

#import "CoreLocation/CoreLocation.h"
#import "UIScrollView+EmptyDataSet.h"//第三方空白页
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#import "BusinessDetailViewController.h"
//地图
#import "MapViewController.h"
//model
#import "CYBusinessModel.h"
#import "CYShoplistModel.h"
#import "CyShopList2MOdel.h"
@interface CYBusinessViewController ()<UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,AMapLocationManagerDelegate,JSDropDownMenuDataSource,JSDropDownMenuDelegate>
{
    
    NSMutableArray *_data1;
    NSMutableArray *_data2;
    NSMutableArray *_data3;
    NSArray        *food;
    NSArray        *addressArr;
    
    NSInteger      _currentData1Index;
    NSInteger      _currentData2Index;
    NSInteger      showType;
    NSInteger      _currentData3Index;
    NSMutableArray * titleArray;
    NSMutableArray * valueArray;
    
    NSString * lau;
    NSString * lon;
}
@property (nonatomic, weak) UITableView *salerListView;
@property (nonatomic)NSInteger page;
@property (nonatomic)NSInteger weiyi;
@property (nonatomic)NSInteger ServiceCode;
@property (nonatomic,strong) NSString *DefaultSort;
@property (nonatomic,strong) NSString *areastr;
@property (nonatomic,strong) NSString *citystr;
@property (strong, nonatomic) AMapLocationManager* locationManager;
@property (nonatomic, strong) NSMutableArray *MerchantData;
@property (nonatomic, strong) NSMutableArray *shopListArray;
@property (nonatomic, strong) NSDictionary *dicData;
@end

static NSString *id_salerListCell = @"salerListViewCell";

@implementation CYBusinessViewController

- (void) drawContent {
    
    self.statusView.hidden      = YES;
    
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
    //    [self drawRightImageButton:@"pinglundianzan" action:@selector(rightBtnClick)];
    
}
#pragma mark------ 数据请求
-(void)getData{
    NSDictionary *mulDic = @{
                             @"City":self.citystr,
                             @"Area":self.areastr,
                             @"ShopType":@(showType),
                             @"ServiceCode":@(self.ServiceCode),
                             @"DefaultSort":self.DefaultSort,
                             @"Ym":[UdStorage getObjectforKey:@"Ym"],
                             @"Xm":[UdStorage getObjectforKey:@"Xm"],
                             @"PageIndex":@0,
                             @"PageSize":@10
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    NSLog(@"商家数据请求-%@",params);
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Merchant/GetStoreNewList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"商家数据请求-%@",dict);
        self.dicData = dict;
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            [self.MerchantData removeAllObjects];
            
            self.MerchantData = (NSMutableArray*)[CYBusinessModel mj_objectArrayWithKeyValuesArray:dict[@"JsonData"][@"merList"]];
            self.shopListArray = (NSMutableArray*)[CYShoplistModel mj_objectArrayWithKeyValuesArray:dict[@"JsonData"][@"shopList"]];
    
            if (self.MerchantData.count==0) {
                [self.view showInfo:@"暂无数据" autoHidden:YES interval:2];
                [self.salerListView reloadData];
                //                [self.salerListView.mj_header endRefreshing];
            }else{
                [self.salerListView reloadData];
                //                [self.salerListView.mj_header endRefreshing];
            }
            
        }
        else
        {
            [self.view showInfo:@"数据请求失败" autoHidden:YES interval:2];
            [self.salerListView.mj_header endRefreshing];
        }
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        [self.salerListView.mj_header endRefreshing];
    }];
}
#pragma mark------ viewDidLoad相关
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.areastr=@"";
    self.citystr=@"青岛市";
    self.DefaultSort=@"1";
    self.page = 0;
    self.weiyi = 0;
    self.ServiceCode =0;
    showType = 0;
    _MerchantData = [NSMutableArray array];
    _shopListArray = [NSMutableArray array];
    titleArray = [NSMutableArray array];
    valueArray = [NSMutableArray array];
    food = @[@"全部", @"普洗-5座轿车", @"精洗-5座轿车", @"普洗-7座轿车", @"全车打蜡-5座轿车", @"全车打蜡-7座轿车", @"内饰清洗-5座轿车", @"内饰清洗-7座轿车"];
    addressArr = @[@"全部",@"市南区",@"市北区",@"李沧区",@"崂山区",@"黄岛区",@"城阳区",@"即墨区",@"胶州市",@"平度市", @"莱西市",@"红岛经济区"];
    
    _data1 = [NSMutableArray arrayWithObjects:@{@"title":@"汽车服务", @"data":food}, @{@"title":@"汽车美容", @"data":food},@{@"title":@"维修服务", @"data":food},@{@"title":@"保养服务", @"data":food},@{@"title":@"安装服务", @"data":addressArr}, nil];
    _data2 = [NSMutableArray arrayWithObjects:@"默认排序", @"附近优先", @"评分最高", @"服务最多", nil];
    
    _data3 = [NSMutableArray arrayWithObjects:@{@"title":@"青岛市", @"data":addressArr},nil];
    
    
    JSDropDownMenu *menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:45];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    
    [self.view addSubview:menu];
    [self setupUI];
    [self getData];
    
    
}
- (void)setupUI {
    
    UIView *titleView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, 64) color:[UIColor colorFromHex:@"#0161a1"]];
    titleView.top                      = 0;
    
    NSString *titleName              = @"商家";
    UIFont *titleNameFont            = [UIFont boldSystemFontOfSize:18];
    UILabel *titleNameLabel          = [UIUtil drawLabelInView:titleView frame:[UIUtil textRect:titleName font:titleNameFont] font:titleNameFont text:titleName isCenter:NO];
    titleNameLabel.textColor         = [UIColor whiteColor];
    titleNameLabel.centerX           = titleView.centerX;
    titleNameLabel.centerY           = titleView.centerY +8;
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(titleView.frame.size.width-60, 8, 60, 64);
    [rightBtn setImage:[UIImage imageNamed:@"dingwei2"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(mapClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:rightBtn];
    
    //
    self.salerListView.delegate = self;
    self.salerListView.dataSource = self;
    self.salerListView.emptyDataSetSource=self;
    self.salerListView.emptyDataSetDelegate=self;
    self.salerListView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

//
//
//    [self setupRefresh];
    
}
#pragma mark ------ tableView代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.MerchantData count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYBusinessModel * model = self.MerchantData[indexPath.row];
    NSArray *lab = [model.MerFlag componentsSeparatedByString:@","];
   
        if([lab count] <= 3)
        {
            return 130*Main_Screen_Height/667;
        }
        else if(([lab count] > 3) && ([lab count] <= 6))
        {
            return 145*Main_Screen_Height/667;
        }
        else
        {
            return 160*Main_Screen_Height/667;
        }
        return 110*Main_Screen_Height/667;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier=@"Cell";
    [tableView registerClass:[QWMclistTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    QWMclistTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    if (cell == nil)
    {
        cell = [[QWMclistTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    else
    {
        //删除cell的所有子视图
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    [cell setlayoutCell];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    [cell setUpCellWithDic:self.MerchantData[indexPath.row]];
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CYBusinessModel * model = self.MerchantData[indexPath.row];
    //跳转商家详情
    BusinessDetailViewController *detailController = [[BusinessDetailViewController alloc] init];
    detailController.hidesBottomBarWhenPushed      = YES;
    detailController.MerCode                       = model.MerCode;
    detailController.distance                      = [NSString stringWithFormat:@"%ld",model.Distance];
    [self.navigationController pushViewController:detailController animated:YES];
}

#pragma mark -----定位跳转
-(void)mapClick
{
    MapViewController * mapView = [[MapViewController alloc]init];
    mapView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mapView animated:YES];
}
#pragma mark -----下拉筛选相关
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 3;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    return NO;
}
//是否展开右边
-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    if (column==1) {
        return YES;
    }else if (column==0){
        return YES;
    }
    return NO;
    
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    if (column==1) {
        return 0.3;
    }else if (column==0){
        return 0.3;
    }
    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==1) {
        
        return _currentData1Index;
        
    }
    if (column==0) {
        
        return _currentData2Index;
    }
    if (column==2) {
        
        return _currentData3Index;
    }
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    
    if (column==1) {
        CYShoplistModel * model = self.shopListArray[leftRow];
        if (leftOrRight==0) {
            return self.shopListArray.count;
        } else{
            [titleArray removeAllObjects];
            [valueArray removeAllObjects];
            if (model.serList.count!=0) {
                NSLog(@"-==-=%ld",model.serList.count);
                for (int i=0;i<model.serList.count; i++) {
                    [titleArray addObject:[NSString stringWithFormat:@"%@",model.serList[i][@"Title"]]];
                    [valueArray addObject:[NSString stringWithFormat:@"%@",model.serList[i][@"Value"]]];
                }
                return model.serList.count;
            }
            return 0;
        }
    } else if (column==0){
        if (leftOrRight==0) {
            
            return _data3.count;
        } else{
            
            NSDictionary *menuDic = [_data3 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] count];
        }
        
    } else if (column==2){
        
        return _data2.count;
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0: return @"青岛市";
            break;
        case 1: return @"全部门店";
            break;
        case 2: return @"默认排序";
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
   
    if (indexPath.column==1) {
        if (indexPath.leftOrRight==0) {
            CYShoplistModel * model = self.shopListArray[indexPath.row];
            return [NSString stringWithFormat:@"%@",model.Title];
        } else{//点击第一列
             return [NSString stringWithFormat:@"%@",titleArray[indexPath.row]];
        }
    } else if (indexPath.column==0) {
        if (indexPath.leftOrRight==0) {
            NSDictionary *menuDic = [_data3 objectAtIndex:indexPath.row];
            return [menuDic objectForKey:@"title"];
        } else{
            NSInteger leftRow = indexPath.leftRow;
            NSDictionary *menuDic = [_data3 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
        }
    } else {
        return _data2[indexPath.row];
    }
}
- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 1) {
        
        if(indexPath.leftOrRight==0){
            CYShoplistModel * model = self.shopListArray[indexPath.row];
            _currentData1Index = indexPath.row;
            NSLog(@"服务左边--%ld", model.Value);
            showType = model.Value;
        }
        if (indexPath.leftOrRight==1)
        {
            NSString * valueStr =[NSString stringWithFormat:@"%@",valueArray[indexPath.row]];
            self.ServiceCode = [[NSString stringWithFormat:@"%@",valueStr]integerValue];
            NSLog(@"服务右边--%ld", self.ServiceCode);
            [self getData];
        }
        
    } else if(indexPath.column == 0){
        
        if(indexPath.leftOrRight==0){
            
            _currentData2Index = indexPath.row;
            NSLog(@"服务类型--%@", _data3[_currentData2Index][@"title"]);
            self.citystr=@"青岛市";
            
        }
        if (indexPath.leftOrRight==1)
        {
            NSLog(@"服务品牌--%@", addressArr[indexPath.row]);
            if ([[NSString stringWithFormat:@"%@",addressArr[indexPath.row]]isEqualToString:@"全部"]) {
                self.areastr = @"";
            }else{
                self.areastr=[NSString stringWithFormat:@"%@",addressArr[indexPath.row]];
            }
            [self getData];
        }
        NSLog(@"地区--%@",_data3[_currentData2Index]);
        
    } else{
        _currentData3Index = indexPath.row;
        if (indexPath.row==0) {
            self.DefaultSort = @"1";
        }else if (indexPath.row==1){
            self.DefaultSort = @"2";
        }else if (indexPath.row==2){
            self.DefaultSort = @"3";
        }else{
            self.DefaultSort = @"4";
        }
         NSLog(@"距离--%@",self.DefaultSort);
        [self getData];
    }
    
    
}
#pragma mark---懒加载
- (UITableView *)salerListView {
    if (nil == _salerListView) {
        UITableView *salerListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 45, Main_Screen_Width, Main_Screen_Height-64 - 45-49)];
        salerListView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _salerListView = salerListView;
        
        [self.view addSubview:salerListView];
        
    }
    return _salerListView;
}

@end
