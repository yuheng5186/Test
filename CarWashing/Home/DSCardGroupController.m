//
//  DSCardGroupController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSCardGroupController.h"
#import <Masonry.h>
//#import "DiscountCategoryView.h"
//#import "DiscountController.h"
//#import "RechargeController.h"
#import "RechargeCell.h"
#import "RechargeDetailController.h"
#import "HTTPDefine.h"
#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "MBProgressHUD.h"
#import "UdStorage.h"
#import "CardBag.h"
#import "UIScrollView+EmptyDataSet.h"//第三方空白页
@interface DSCardGroupController ()<UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

//@property (nonatomic, weak) UIView *containerView;
//
//@property (nonatomic, weak) UIScrollView *cardScrollView;
//
//@property (nonatomic, weak) DiscountCategoryView *categoryView;
@property (nonatomic, weak) UITextField *activateTF;
@property (nonatomic, weak) UIButton *activateBtn;
@property (nonatomic, weak) UITableView *rechargeView;

@property (nonatomic, strong) NSMutableArray *CardbagData;

@end

static NSString *id_rechargeCell = @"id_rechargeCell";

@implementation DSCardGroupController

- (UITextField *)activateTF {
    
    if (!_activateTF) {
        
        UITextField *activateTF = [[UITextField alloc] init];
        activateTF.backgroundColor = [UIColor whiteColor];
        activateTF.placeholder = @"  请输入激活码";
        activateTF.font = [UIFont systemFontOfSize:Main_Screen_Height*14/667];
        activateTF.textColor = [UIColor colorFromHex:@"#c8c8c8"];
        activateTF.layer.cornerRadius = Main_Screen_Height*20/667;
        activateTF.layer.borderWidth  = 0.5;
        activateTF.layer.borderColor  = [UIColor colorFromHex:@"#c8c8c8"].CGColor;
        activateTF.clipsToBounds = YES;
        _activateTF = activateTF;
        [self.view addSubview:activateTF];
    }
    
    return _activateTF;
}


- (UIButton *)activateBtn {
    
    if (!_activateBtn) {
        
        UIButton *activateBtn = [[UIButton alloc] init];
        [activateBtn setTitle:@"激活卡" forState:UIControlStateNormal];
        activateBtn.backgroundColor = [UIColor colorFromHex:@"#febb02"];
        activateBtn.titleLabel.tintColor = [UIColor colorFromHex:@"#ffffff"];
        activateBtn.titleLabel.font = [UIFont systemFontOfSize:Main_Screen_Height*14/667];
        activateBtn.layer.cornerRadius = Main_Screen_Height*20/667;
        activateBtn.clipsToBounds = YES;
        [activateBtn addTarget:self action:@selector(jihuokapian:) forControlEvents:UIControlEventTouchUpInside];
        _activateBtn = activateBtn;
        
        [self.view addSubview:_activateBtn];
    }
    
    return _activateBtn;
}


- (UITableView *)rechargeView {
    
    if (!_rechargeView) {
        
        UITableView *rechargeView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rechargeView = rechargeView;
        _rechargeView.emptyDataSetSource=self;
        _rechargeView.emptyDataSetDelegate=self;
        [self.view addSubview:_rechargeView];
    }
    
    return _rechargeView;
}



- (void)drawNavigation {
    
    [self drawTitle:@"我的卡包"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    _CardbagData = [[NSMutableArray alloc]init];
    [self GetCardbagList];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.activateTF resignFirstResponder];
    
    [self.view endEditing:YES];
}

- (void)setupUI {
    
    //    [self setupCategoryView];
    //    [self setupScrollView];
    //
    //    [self addCardChildViewControllers];
    
    
    UIView *titleView                  = [UIUtil drawLineInView:self.view frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*60/667) color:[UIColor whiteColor]];
    titleView.top                      = 64;
    
    
    [self.activateTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView).mas_offset(Main_Screen_Width*10/375);
        make.top.equalTo(titleView).mas_offset(Main_Screen_Height*10/667);
        make.width.mas_equalTo(Main_Screen_Width*270/375);
        make.height.mas_equalTo(Main_Screen_Height*40/667);
    }];
    
    [self.activateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).mas_equalTo(-Main_Screen_Width*10/375);
        make.top.equalTo(self.view).mas_equalTo(64+Main_Screen_Height*10/667);
        make.width.mas_equalTo(Main_Screen_Width*75/375);
        make.height.mas_equalTo(Main_Screen_Height*40/667);
    }];
    
    
    [self.rechargeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom).mas_offset(0);
        make.left.equalTo(self.view).mas_offset(Main_Screen_Width*37.5/375);
        make.right.equalTo(self.view).mas_offset(-Main_Screen_Width*37.5/375);
        make.height.mas_equalTo(self.view.height-Main_Screen_Height*60/667-64);
    }];
    
    self.rechargeView.delegate = self;
    self.rechargeView.dataSource = self;
    
    [self.rechargeView registerNib:[UINib nibWithNibName:@"RechargeCell" bundle:nil] forCellReuseIdentifier:id_rechargeCell];
    self.rechargeView.rowHeight = Main_Screen_Height*192/667;
    self.rechargeView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.rechargeView.backgroundColor = [UIColor whiteColor];
     self.rechargeView.showsVerticalScrollIndicator = NO;
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(_activateTF.frame.origin.x,_activateTF.frame.origin.y,15.0, _activateTF.frame.size.height)];
    _activateTF.leftView = blankView;
    _activateTF.leftViewMode =UITextFieldViewModeAlways;
    
}

-(void)GetCardbagList
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"]
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Card/GetCardInfoList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            for(NSDictionary *dic in arr)
            {
                CardBag *model = [CardBag new];
                [model setValuesForKeysWithDictionary:dic];
                [_CardbagData addObject:model];
            }
            [_rechargeView reloadData];
        }
        else
        {
            [self.view showInfo:@"信息获取失败" autoHidden:YES interval:2];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        [self.navigationController popViewControllerAnimated:YES];
        
    }];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
//    return [_CardbagData count];
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:id_rechargeCell forIndexPath:indexPath];
    cell.contentView.backgroundColor = self.view.backgroundColor;
    cell.backgroundColor = self.view.backgroundColor;
    
    CardBag *card = (CardBag *)[_CardbagData objectAtIndex:indexPath.section];
    
    cell.CardnameLabel.text = card.CardName;
    cell.CarddesLabel.text = [NSString stringWithFormat:@"%@ 免费洗车%ld次",card.Description,card.CardCount];
    
    
    
    
    
    cell.CardTimeLabel.text = [NSString stringWithFormat:@"有效期: %@-%@",[self DateZhuan:card.ExpStartDates],[self DateZhuan:card.ExpEndDates]];
    
    if(card.CardUseState == 2)
    {
        cell.CardnameLabel.textColor = [UIColor colorFromHex:@"#ffffff"];
        cell.tagLabel.textColor = [UIColor colorFromHex:@"#ffffff"];
        cell.CarddesLabel.textColor = [UIColor colorFromHex:@"#ffffff"];
        cell.backgroundImgV.image = [UIImage imageNamed:@"bg_yishiyong"];
        
    }
    else if(card.CardUseState == 3)
    {
        cell.CardnameLabel.textColor = [UIColor colorFromHex:@"#ffffff"];
        cell.tagLabel.textColor = [UIColor colorFromHex:@"#ffffff"];
        cell.CarddesLabel.textColor = [UIColor colorFromHex:@"#ffffff"];
        cell.backgroundImgV.image = [UIImage imageNamed:@"bg_yiguoqi"];
    }
    
    
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSString *)DateZhuan:(NSString *)string
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate*inputDate = [inputFormatter dateFromString:string];
    NSDateFormatter*outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString*str = [outputFormatter stringFromDate:inputDate];
    return str;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10*Main_Screen_Height/667;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CardBag *card = (CardBag *)[_CardbagData objectAtIndex:indexPath.section];
    RechargeDetailController *rechargeDetailVC = [[RechargeDetailController alloc] init];
    rechargeDetailVC.hidesBottomBarWhenPushed = YES;
    rechargeDetailVC.card = card;
    [self.navigationController pushViewController:rechargeDetailVC animated:YES];
    
}

-(void)jihuokapian:(UIButton *)btn
{
    
    if(_activateTF.text.length == 0)
    {
        [self.view showInfo:@"请输入激活码" autoHidden:YES interval:2];
    }
    else
    {
        NSDictionary *mulDic = @{
                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                 @"ActivationCode":_activateTF.text
                                 };
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Card/ActivationCard",Khttp] success:^(NSDictionary *dict, BOOL success) {
            
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                if([[[dict objectForKey:@"JsonData"] objectForKey:@"Activationstate"] integerValue] == 3)
                {
                    [self.view showInfo:@"对不起，该卡不存在" autoHidden:YES interval:2];
                }
                else if([[[dict objectForKey:@"JsonData"] objectForKey:@"Activationstate"] integerValue] == 1)
                {
                    [self.view showInfo:@"激活成功" autoHidden:YES interval:2];
                    _CardbagData = [[NSMutableArray alloc]init];
                    [self GetCardbagList];
                }
                else if([[[dict objectForKey:@"JsonData"]objectForKey:@"Activationstate"] integerValue] == 2)
                {
                    if([[[dict objectForKey:@"JsonData"] objectForKey:@"CardUseState"] integerValue] == 1)
                    {
                        [self.view showInfo:@"对不起，该卡已被激活" autoHidden:YES interval:2];
                    }
                    else if([[[dict objectForKey:@"JsonData"] objectForKey:@"CardUseState"] integerValue] == 2)
                    {
                        [self.view showInfo:@"对不起，该卡已被使用" autoHidden:YES interval:2];
                    }
                    else{
                        [self.view showInfo:@"对不起，该卡已失效" autoHidden:YES interval:2];
                    }
                    
                    
                }
                else
                {
                    [self.view showInfo:@"激活失败" autoHidden:YES interval:2];
                }
                
                
                
            }
            else
            {
                [self.view showInfo:@"激活失败" autoHidden:YES interval:2];
            }
        } fail:^(NSError *error) {
            [self.view showInfo:@"激活失败" autoHidden:YES interval:2];
            
        }];

    }
    
    
}


//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 圆角弧度半径
//    CGFloat cornerRadius = 6.f;
//    // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
//    cell.backgroundColor = UIColor.clearColor;
//
//    // 创建一个shapeLayer
//    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
//    CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
//    // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
//    CGMutablePathRef pathRef = CGPathCreateMutable();
//    // 获取cell的size
//    // 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
//    CGRect bounds = CGRectInset(cell.bounds, 10, 0);
//
//    // CGRectGetMinY：返回对象顶点坐标
//    // CGRectGetMaxY：返回对象底点坐标
//    // CGRectGetMinX：返回对象左边缘坐标
//    // CGRectGetMaxX：返回对象右边缘坐标
//    // CGRectGetMidX: 返回对象中心点的X坐标
//    // CGRectGetMidY: 返回对象中心点的Y坐标
//
//    // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行
//
//    // CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
//    if (indexPath.row == 0) {
//        // 初始起点为cell的左下角坐标
//        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
//        // 起始坐标为左下角，设为p，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
//        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
//        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
//        // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
//        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
//
//    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
//        // 初始起点为cell的左上角坐标
//        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
//        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
//        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
//        // 添加一条直线，终点坐标为右下角坐标点并放到路径中去
//        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
//    } else {
//        // 添加cell的rectangle信息到path中（不包括圆角）
//        CGPathAddRect(pathRef, nil, bounds);
//    }
//    // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
//    layer.path = pathRef;
//    backgroundLayer.path = pathRef;
//    // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
//    CFRelease(pathRef);
//    // 按照shape layer的path填充颜色，类似于渲染render
//    // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
//    layer.fillColor = [UIColor whiteColor].CGColor;
//
//    // view大小与cell一致
//    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
//    // 添加自定义圆角后的图层到roundView中
//    [roundView.layer insertSublayer:layer atIndex:0];
//    roundView.backgroundColor = UIColor.clearColor;
//    // cell的背景view
//    cell.backgroundView = roundView;
//
//    // 以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
//    // 如果你 cell 已经取消选中状态的话,那以下方法是不需要的.
//    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
//    backgroundLayer.fillColor = [UIColor cyanColor].CGColor;
//    [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
//    selectedBackgroundView.backgroundColor = UIColor.clearColor;
//    cell.selectedBackgroundView = selectedBackgroundView;
//
//}



//- (void)addCardChildViewControllers{
//
//    DiscountController *discountVC = [[DiscountController alloc] init] ;
//    RechargeController *rechargeVC = [[RechargeController alloc] init];
//
//    [self addChildViewController:discountVC];
//    [self addChildViewController:rechargeVC];
//
//    [_containerView addSubview:discountVC.view];
//    [_containerView addSubview:rechargeVC.view];
//
//    [discountVC didMoveToParentViewController:self];
//    [rechargeVC didMoveToParentViewController:self];
//
//    [discountVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.leading.equalTo(_containerView);
//        make.size.equalTo(_cardScrollView);
//    }];
//
//    [rechargeVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_containerView);
//        make.leading.equalTo(discountVC.view.mas_trailing);
//        make.size.equalTo(_cardScrollView);
//    }];
//
//}
//
//
//#pragma mark - 设置分类视图
//- (void)setupCategoryView{
//
//    DiscountCategoryView *categoryView = [[DiscountCategoryView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
//
//    _categoryView = categoryView;
//
//    [self.view addSubview:categoryView];
//
//    categoryView.categoryBlock = ^(NSInteger index){
//
//        //修改scrollView的contentOffset
//        [self.cardScrollView setContentOffset:CGPointMake(index * self.cardScrollView.width, 0) animated:YES];
//    };
//}
//
//
//
//#pragma mark - 布局scrollView
//- (void)setupScrollView {
//
//
//
//    UIScrollView *cardScrollView =  [[UIScrollView alloc] init];
//    _cardScrollView = cardScrollView;
//
//    cardScrollView.delegate = self;
//    cardScrollView.bounces = NO;
//    cardScrollView.pagingEnabled = YES;
//
//    [self.view addSubview:cardScrollView];
//
//    [cardScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_categoryView.mas_bottom);
//        make.leading.trailing.bottom.equalTo(self.view);
//    }];
//
//
//    //容器视图
//    UIView *containerView = [[UIView alloc] init];
//    _containerView = containerView;
//    containerView.backgroundColor = [UIColor lightGrayColor];
//
//    [cardScrollView addSubview:containerView];
//
//    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(cardScrollView);
//        make.width.equalTo(cardScrollView).multipliedBy(2);
//        make.height.equalTo(cardScrollView);
//    }];
//
//}
//
//#pragma mark - scrollView的代理方法
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    if (scrollView.isTracking || scrollView.isDragging || scrollView.isDecelerating) {
//        CGFloat offsetX = scrollView.contentOffset.x / 2;
//        _categoryView.offsetX = offsetX;
//    }
//}

#pragma mark - 无数据占位
//无数据占位
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"kabao_kongbai"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"kabao_kongbai"];
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
    NSString *text = @"客官你还没有办理过卡";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: [UIColor colorFromHex:@"#4a4a4a"]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//设置按钮的文本和按钮的背景图片
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state  {
    //    NSLog(@"buttonTitleForEmptyDataSet:点击上传照片");
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],NSForegroundColorAttributeName:[UIColor whiteColor]};
    return [[NSAttributedString alloc] initWithString:@"去购卡" attributes:attributes];
}
#pragma mark-背景图片
//-(UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
//
//    return [UIImage imageNamed:@"mashangxiche-"];
//}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [UIImage imageNamed:@"qgouka"];
}
//是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
//是否允许点击，默认YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
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
    self.tabBarController.selectedIndex = 3;
}
/**
 *  调整垂直位置
 */
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -64.f-49;
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
