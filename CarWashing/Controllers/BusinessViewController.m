//
//  BusinessViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/19.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BusinessViewController.h"
#import "SalerListViewCell.h"
#import "YZPullDownMenu.h"
#import "YZMenuButton.h"
#import "YZSortViewController.h"
#import "YZAllCourseViewController.h"
#import "JPCityViewController.h"
#import "BusinessDetailViewController.h"

#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "HTTPDefine.h"


@interface BusinessViewController ()<UITableViewDelegate, UITableViewDataSource,YZPullDownMenuDataSource>
{
    
}

@property (nonatomic, weak) UITableView *salerListView;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSMutableDictionary *pramsDic;

@property (nonatomic, strong) NSMutableArray *MerchantData;


@end

static NSString *id_salerListCell = @"salerListViewCell";

@implementation BusinessViewController


- (UITableView *)salerListView {
    if (nil == _salerListView) {
        UITableView *salerListView = [[UITableView alloc] initWithFrame:CGRectMake(0, Main_Screen_Height*108/667, Main_Screen_Width, Main_Screen_Height) style:UITableViewStylePlain];
        _salerListView = salerListView;
        [self.view addSubview:salerListView];
        
    }
    return _salerListView;
}

- (void) drawContent {
    
    self.statusView.hidden      = YES;
    
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.title = @"商家";

    self.navigationController.navigationBar.hidden = YES;
    
    [self setSearchMenu];
    
    self.pramsDic = [[NSMutableDictionary alloc]init];
    NSArray *array1 = [[NSArray alloc] initWithObjects:@"上海市",@"浦东新区", nil];
    NSDictionary *dic = @{@"0":array1,@"1":@"普洗-5座轿车",@"2":@"默认排序"};
    self.pramsDic  = [NSMutableDictionary dictionaryWithDictionary:dic];
    self.MerchantData = [[NSMutableArray alloc]init];
    [self setData];
    
    
    
    
    //    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //    [center addObserver:self selector:@selector(noticeupdatexuanze:) name:YZUpdateMenuTitleNote object:nil];
    
    
    NSNotificationCenter *observer = [[NSNotificationCenter defaultCenter] addObserverForName:YZUpdateMenuTitleNote object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        // 获取列
        NSInteger col = [self.childViewControllers indexOfObject:note.object];
        
        // 获取所有值
        NSArray *allValues = note.userInfo.allValues;
        
        // 不需要设置标题,字典个数大于1，或者有数组
        if (allValues.count > 1 || [allValues.firstObject isKindOfClass:[NSArray class]]) return ;
        
        NSString *str = allValues.firstObject;
        if ([str containsString:@":"]) {
            NSArray *array = [allValues.firstObject componentsSeparatedByString:@":"];
            // 设置按钮标题
            [self.pramsDic setValue:array forKey:[NSString stringWithFormat:@"%ld",(long)col]];
        } else {
            // 设置按钮标题
            [self.pramsDic setValue:allValues.firstObject forKey:[NSString stringWithFormat:@"%ld",(long)col]];
        }
        
        
        
        
        
        
        [self setData];
        
    }];

    
    
    [self setupUI];
    
    
    
    

}


- (void)setupUI {
    
    UIView *titleView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*64/667) color:[UIColor colorFromHex:@"#293754"]];
    titleView.top                      = 0;
    
    NSString *titleName              = @"商家";
    UIFont *titleNameFont            = [UIFont boldSystemFontOfSize:14];
    UILabel *titleNameLabel          = [UIUtil drawLabelInView:titleView frame:[UIUtil textRect:titleName font:titleNameFont] font:titleNameFont text:titleName isCenter:NO];
    titleNameLabel.textColor         = [UIColor whiteColor];
    titleNameLabel.centerX           = titleView.centerX;
    titleNameLabel.centerY           = titleView.centerY +Main_Screen_Height*10/667;
    
    //
    self.salerListView.delegate = self;
    self.salerListView.dataSource = self;
    self.salerListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *nib = [UINib nibWithNibName:@"SalerListViewCell" bundle:nil];
    
    [self.salerListView registerNib:nib forCellReuseIdentifier:id_salerListCell];
    
    
    self.salerListView.contentInset = UIEdgeInsetsMake(0, 0, 180*Main_Screen_Height/667, 0);
   
    
}


#pragma mark - 代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.MerchantData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *lab = [[[self.MerchantData objectAtIndex:indexPath.row]objectForKey:@"MerFlag"] componentsSeparatedByString:@","];
    if([[self.MerchantData objectAtIndex:indexPath.row]objectForKey:@"MerFlag"])
    {
        if([lab count] <= 3)
        {
            return 110;
        }
        else if(([lab count] > 3) && ([lab count] <= 6))
        {
            return 125;
        }
        else
        {
            return 140;
        }
        
    }
    else
        return 110;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SalerListViewCell *salerListViewCell = [tableView dequeueReusableCellWithIdentifier:id_salerListCell forIndexPath:indexPath];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,[[self.MerchantData objectAtIndex:indexPath.row] objectForKey:@"Img"]];
        NSURL *url=[NSURL URLWithString:ImageURL];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *img=[UIImage imageWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            salerListViewCell.shopImageView.image = img;
        });
    });
    salerListViewCell.shopNameLabel.text = [[self.MerchantData objectAtIndex:indexPath.row]objectForKey:@"MerName"];
    salerListViewCell.shopAdressLabel.text = [[self.MerchantData objectAtIndex:indexPath.row]objectForKey:@"MerAddress"];
//    salerListViewCell.freeTestLabel.text = [[self.MerchantData objectAtIndex:indexPath.row]objectForKey:@"MerName"];
//    salerListViewCell.qualityLabel.text = [[self.MerchantData objectAtIndex:indexPath.row]objectForKey:@"MerName"];
    salerListViewCell.distanceLabel.text = [NSString stringWithFormat:@"%@km",[[self.MerchantData objectAtIndex:indexPath.row]objectForKey:@"Distance"]];
    
    if([[[self.MerchantData objectAtIndex:indexPath.row]objectForKey:@"ShopType"] intValue] == 1)
    {
        salerListViewCell.typeShopLabel.text = @"洗车服务";
    }
    
    
    
    salerListViewCell.ScoreLabel.text = [NSString stringWithFormat:@"%@分",[[self.MerchantData objectAtIndex:indexPath.row]objectForKey:@"Score"]];
    
    [salerListViewCell.starView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@xing",[[NSString stringWithFormat:@"%@",[[self.MerchantData objectAtIndex:indexPath.row]objectForKey:@"Score"]] substringToIndex:1]]]];
    
    NSArray *lab = [[[self.MerchantData objectAtIndex:indexPath.row]objectForKey:@"MerFlag"] componentsSeparatedByString:@","];
    
    for (int i = 0; i < [lab count]; i++) {
        UILabel *MerflagsLabel = [[UILabel alloc] initWithFrame:CGRectMake(115 + i % 3 * 67,  i / 3 * 25 + 88, 60, 15)];
        MerflagsLabel.text = lab[i];
        MerflagsLabel.backgroundColor = [UIColor redColor];
        [MerflagsLabel setFont:[UIFont fontWithName:@"Helvetica" size:11 ]];
        MerflagsLabel.textColor = [UIColor colorFromHex:@"#fefefe"];
        MerflagsLabel.backgroundColor = [UIColor colorFromHex:@"#ff7556"];
        MerflagsLabel.textAlignment = NSTextAlignmentCenter;
        MerflagsLabel.layer.masksToBounds = YES;
        MerflagsLabel.layer.cornerRadius = 7.5;
        [salerListViewCell.contentView addSubview:MerflagsLabel];
    }
    
    salerListViewCell.qualityLabel.hidden = YES;
    salerListViewCell.freeTestLabel.hidden = YES;
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, salerListViewCell.contentView.frame.size.height -0.5,self.contentView.frame.size.width,0.5)];
    view2.backgroundColor = [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1.0f];
    [salerListViewCell.contentView addSubview:view2];
    
    salerListViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [_salerListView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    return salerListViewCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //跳转商家详情
    BusinessDetailViewController *detailController = [[BusinessDetailViewController alloc] init];
    detailController.hidesBottomBarWhenPushed      = YES;
    detailController.MerCode                       = [[[self.MerchantData objectAtIndex:indexPath.row] objectForKey:@"MerCode"] integerValue];
    [self.navigationController pushViewController:detailController animated:YES];
}




#pragma mark - 搜索下拉
- (void)setSearchMenu {
    
    // 创建下拉菜单
    YZPullDownMenu *menu = [[YZPullDownMenu alloc] init];
    menu.frame = CGRectMake(0, Main_Screen_Height*64/667, Main_Screen_Width, Main_Screen_Height*44/667);
    [self.view addSubview:menu];
    
    
    // 设置下拉菜单代理
    menu.dataSource = self;
    
//    NSArray *array1 = [[NSArray alloc] initWithObjects:@"上海市",@"浦东新区", nil];
//    NSDictionary *dic = @{@"0":array1,@"1":@"普洗-5座轿车",@"2":@"默认排序"};
    
    // 初始化标题
    _titles = @[@"浦东新区",@"普洗-5座轿车",@"默认排序"];
    
//    NSLog(@"%@",self.pramsDic);
    
    // 添加子控制器
    [self setupAllChildViewController];
}


#pragma mark - 添加子控制器
- (void)setupAllChildViewController
{
    JPCityViewController *cityVC = [[JPCityViewController alloc] init];
    YZAllCourseViewController *allCourse = [[YZAllCourseViewController alloc] init];
    YZSortViewController *sort = [[YZSortViewController alloc] init];
    
    [self addChildViewController:cityVC];
    [self addChildViewController:allCourse];
    [self addChildViewController:sort];
    
}

#pragma mark - YZPullDownMenuDataSource
// 返回下拉菜单多少列
- (NSInteger)numberOfColsInMenu:(YZPullDownMenu *)pullDownMenu
{
    return 3;
}

// 返回下拉菜单每列按钮
- (UIButton *)pullDownMenu:(YZPullDownMenu *)pullDownMenu buttonForColAtIndex:(NSInteger)index
{
    YZMenuButton *button = [YZMenuButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:_titles[index] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorFromHex:@"#999999"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorFromHex:@"#999999"] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"xiala"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"shangla"] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:12*Main_Screen_Height/667];
    
    return button;
}

// 返回下拉菜单每列对应的控制器
- (UIViewController *)pullDownMenu:(YZPullDownMenu *)pullDownMenu viewControllerForColAtIndex:(NSInteger)index
{
    return self.childViewControllers[index];
}

// 返回下拉菜单每列对应的高度
- (CGFloat)pullDownMenu:(YZPullDownMenu *)pullDownMenu heightForColAtIndex:(NSInteger)index
{
    // 第1列 高度
    if (index == 0) {
        return 270;
    }
    
    // 第2列 高度
    if (index == 1) {
        return 180;
    }
    
    // 第3列 高度
    return 180;
}

-(void)setData
{
    [self.MerchantData removeAllObjects];
//    NSLog(@"%@",self.pramsDic);
    
    NSString *DefaultSort;
    
    if([[self.pramsDic objectForKey:@"2"] isEqualToString:@"默认排序"])
    {
        DefaultSort = @"1";
    }
    else if([[self.pramsDic objectForKey:@"2"] isEqualToString:@"附近优先"])
    {
        DefaultSort = @"2";
    }
    else if([[self.pramsDic objectForKey:@"2"] isEqualToString:@"评分最高"])
    {
        DefaultSort = @"3";
    }
    else
    {
        DefaultSort = @"4";
    }
    
    
    NSDictionary *mulDic = @{
                             @"City":[[self.pramsDic objectForKey:@"0"] objectAtIndex:0],
                             @"Area":[[self.pramsDic objectForKey:@"0"] objectAtIndex:1],
                             @"ShopType":@1,
                             @"ServiceCode":@101,
                             @"DefaultSort":DefaultSort,
                             @"Ym":@31.192255,
                             @"Xm":@121.52334,
                             @"PageIndex":@0,
                             @"PageSize":@10
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@MerChant/GetStoreList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        
        
        NSArray *arr = [NSArray array];
        arr = [dict objectForKey:@"JsonData"];
        [self.MerchantData addObjectsFromArray:arr];
        [_salerListView reloadData];
        
        
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
    }];

}

//-(void)noticeupdatexuanze:(NSNotification *)sender{
//    NSInteger col = [self.childViewControllers indexOfObject:sender.object];
//    
//    // 获取所有值
//    NSArray *allValues = note.userInfo.allValues;
//    
//    // 不需要设置标题,字典个数大于1，或者有数组
//    if (allValues.count > 1 || [allValues.firstObject isKindOfClass:[NSArray class]]) return ;
//    
//    
//    
//    [self.pramsDic setValue:allValues.firstObject forKey:[NSString stringWithFormat:@"%ld",(long)col]];
//    
//    [self setData];
//}

-(void)viewWillAppear:(BOOL)animated
{
//    [self setSearchMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
