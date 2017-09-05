//
//  AllOrderController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "AllOrderController.h"
#import "SuccessPayCell.h"
#import "DelayPayCell.h"
#import "CancelPayCell.h"
#import "OrderDetailController.h"
#import "UIScrollView+EmptyDataSet.h"//第三方空白页

#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "HTTPDefine.h"
#import "MBProgressHUD.h"
#import "UdStorage.h"

@interface AllOrderController ()<UITableViewDelegate, UITableViewDataSource, PushVCDelegate,DelayPayCellPushVCDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, weak) UITableView *allOrderListView;

@property (nonatomic)NSInteger page;
@property (nonatomic, strong) NSMutableArray *OrderDataArray;

@end

static NSString *id_successPayCell = @"id_successPayCell";
static NSString *id_delayPayCell = @"id_delayPayCell";
static NSString *id_cancelCell = @"id_cancelCell";

@implementation AllOrderController

- (UITableView *)allOrderListView {
    
    if (!_allOrderListView) {
        UITableView *allOrderListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height  - 64 - 44) style:UITableViewStyleGrouped];
        _allOrderListView = allOrderListView;
        [self.view addSubview:_allOrderListView];
    }
    return _allOrderListView;
}


- (void) drawContent
{
    self.statusView.hidden      = YES;
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
    self.contentView.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allOrderListView.delegate = self;
    self.allOrderListView.dataSource = self;
    self.allOrderListView.emptyDataSetSource=self;
    self.allOrderListView.emptyDataSetDelegate=self;
    [self.allOrderListView registerNib:[UINib nibWithNibName:@"SuccessPayCell" bundle:nil] forCellReuseIdentifier:id_successPayCell];
    [self.allOrderListView registerNib:[UINib nibWithNibName:@"DelayPayCell" bundle:nil] forCellReuseIdentifier:id_delayPayCell];
    [self.allOrderListView registerNib:[UINib nibWithNibName:@"CancelPayCell" bundle:nil] forCellReuseIdentifier:id_cancelCell];
    
    
    self.page = 0 ;
    
    [self setupRefresh];
    
     
}

-(void)setupRefresh
{
    self.allOrderListView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        
        [self headerRereshing];
        
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.allOrderListView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.allOrderListView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.allOrderListView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        
        [self footerRereshing];
        
    }];
}

- (void)headerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self setData];
        
    });
}

- (void)footerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        self.page++;
//        _otherarray = [NSMutableArray new];
        [self setDataMore];
        
        
        //
        //
        //
        //
        //        // 刷新表格
        //
        //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        
    });
}

-(void)setData
{
//    NSDictionary *mulDic = @{
//                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
//                             @"PageIndex":@0,
//                             @"PageSize":@10
//                             };
//    NSDictionary *params = @{
//                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
//                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
//                             };
//    
//    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Integral/GetIntegralList",Khttp] success:^(NSDictionary *dict, BOOL success) {
//        
//        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
//        {
//            self.page = 0;
//            self.OrderDataArray = [[NSMutableArray alloc]init];
//            NSArray *arr = [NSArray array];
//            arr = [[dict objectForKey:@"JsonData"] objectForKey:@"integList"];
//            if(arr.count == 0)
//            {
//                //                [self.view showInfo:@"暂无更多数据" autoHidden:YES interval:2];
//                [self.allOrderListView reloadData];
//                [self.allOrderListView.mj_header endRefreshing];
//            }
//            else
//            {
//                [self.OrderDataArray addObjectsFromArray:arr];
//                [self.allOrderListView reloadData];
//                [self.allOrderListView.mj_header endRefreshing];
//            }
//            
//        }
//        else
//        {
//            [self.allOrderListView showInfo:@"数据请求失败" autoHidden:YES interval:2];
//            [self.allOrderListView.mj_header endRefreshing];
//        }
//        
//    } fail:^(NSError *error) {
//        [self.allOrderListView showInfo:@"获取失败" autoHidden:YES interval:2];
        [self.allOrderListView.mj_header endRefreshing];
//    }];
    
}

-(void)setDataMore
{
//    NSDictionary *mulDic = @{
//                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
//                             @"PageIndex":[NSString stringWithFormat:@"%ld",self.page],
//                             @"PageSize":@10
//                             };
//    NSDictionary *params = @{
//                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
//                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
//                             };
//    
//    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Integral/GetIntegralList",Khttp] success:^(NSDictionary *dict, BOOL success) {
//        
//        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
//        {
//            
//            NSArray *arr = [NSArray array];
//            arr = [[dict objectForKey:@"JsonData"] objectForKey:@"integList"];
//            if(arr.count == 0)
//            {
//                [self.allOrderListView showInfo:@"暂无更多数据" autoHidden:YES interval:2];
//                self.page--;
//                [self.allOrderListView reloadData];
//                [self.allOrderListView.mj_footer endRefreshing];
//            }
//            else
//            {
//                [self.OrderDataArray addObjectsFromArray:arr];
//                [self.allOrderListView reloadData];
//                [self.allOrderListView.mj_footer endRefreshing];
//            }
//            
//        }
//        else
//        {
//            self.page--;
//            [self.allOrderListView showInfo:@"数据请求失败" autoHidden:YES interval:2];
//            [self.allOrderListView.mj_footer endRefreshing];
//        }
//        
//    } fail:^(NSError *error) {
//        self.page--;
//        [self.allOrderListView showInfo:@"获取失败" autoHidden:YES interval:2];
        [self.allOrderListView.mj_footer endRefreshing];
//    }];
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SuccessPayCell *successCell = [tableView dequeueReusableCellWithIdentifier:id_successPayCell forIndexPath:indexPath];
        successCell.delegate = self;
        return successCell;
    }else if (indexPath.section == 1){
        
        DelayPayCell *delayCell = [tableView dequeueReusableCellWithIdentifier:id_delayPayCell forIndexPath:indexPath];
        delayCell.delegate = self;
        return delayCell;
    }
    
    CancelPayCell *cancelCell = [tableView dequeueReusableCellWithIdentifier:id_cancelCell forIndexPath:indexPath];
    
    return cancelCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        
        OrderDetailController *orderDetailVC = [[OrderDetailController alloc] init];
        orderDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderDetailVC animated:YES];
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150*Main_Screen_Height/667;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}



#pragma mark - 实现success的代理方法
- (void)pushController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self.navigationController pushViewController:viewController animated:animated];
}


- (void)pushVC:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self.navigationController pushViewController:viewController animated:animated];
}

#pragma mark - 无数据占位
//无数据占位
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"dingdan_kongbai"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"dingdan_kongbai"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0,   1.0)];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
}
//设置文字（上图下面的文字，我这个图片默认没有这个文字的）是富文本样式，扩展性很强！

//这个是设置标题文字的
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"你还没有订单信息";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: [UIColor colorFromHex: @"#4a4a4a"]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//设置占位图空白页的背景色( 图片优先级高于文字)

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
}
//设置按钮的文本和按钮的背景图片
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state  {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],NSForegroundColorAttributeName:[UIColor whiteColor]};
    return [[NSAttributedString alloc] initWithString:@"马上去洗车" attributes:attributes];
}
-(UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
     return [UIImage imageNamed:@"qxiche"];
}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [UIImage imageNamed:@"qxiche"];
}
//是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
//是否允许点击，默认YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return NO;
}
//是否允许滚动，默认NO
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
//图片是否要动画效果，默认NO
- (BOOL) emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView {
    return YES;
}
//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    NSLog(@"空白页点击事件");
}
//空白页按钮点击事件
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    return NSLog(@"空白页按钮点击事件");
}
/**
 *  调整垂直位置
 */
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -64.f-44;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
