//
//  CYPurchaseCardViewController.m
//  CarWashing
//
//  Created by apple on 2017/11/30.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYPurchaseCardViewController.h"
#import "payCardDetailCell.h"
#import <Masonry.h>
#import "CashViewController.h"
#import "BusinessPayCell.h"
#import "UdStorage.h"
#import "HTTPDefine.h"
#import "AFNetworkingTool.h"
#import "LCMD5Tool.h"
#import "DSCardGroupController.h"

#import "AlipayOrder.h"
#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "CYPurchaseTableViewCell.h"
#import "CYPurchaseTwoTableViewCell.h"
#import "CYPurchaseModel.h"
@interface CYPurchaseCardViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSString * payStyle;
    UIImageView * typeImageView;//类型label
    UILabel * moneyLabel;//类型label
    UILabel * timeLabel;//时间label
    UILabel *bottomPriceLab;
    UILabel *DiscountPriceLab;
    NSString * chooseMoney;//选择的团购类型钱
    NSInteger  Integralnum;//积分
    NSInteger ConfigCode;
}
@property (nonatomic, weak) UITableView *payCardView;

@property (nonatomic, strong) NSArray *payNameArray;
@property (nonatomic, strong) NSArray *payImageNameArr;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSIndexPath *lastPath;
@property (nonatomic, strong) NSIndexPath* selectStr;
@property (nonatomic, weak) BusinessPayCell *seleCell;


@end
static NSString *id_businessPaycell = @"id_businessPaycell";

@implementation CYPurchaseCardViewController

- (UITableView *)payCardView {
    if (!_payCardView) {
        UITableView *payCardView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64-60*Main_Screen_Height/667) style:UITableViewStylePlain];
        self.payCardView = payCardView;
        payCardView.backgroundColor=RGBAA(242, 242, 242, 1.0);
        payCardView.separatorStyle = UITableViewCellSeparatorStyleNone;
        payCardView.estimatedRowHeight = 0;
        payCardView.estimatedSectionFooterHeight = 0;
        payCardView.estimatedSectionHeaderHeight = 0;
        [self.view addSubview:payCardView];
    }
    return _payCardView;
}
- (void)drawNavigation {
    [self drawTitle:[NSString stringWithFormat:@"购买%@",self.choosecard.CardName]];
}
- (void) drawContent
{
    self.contentView.top                = self.navigationView.bottom;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(goBack) name:@"paysuccess" object:nil];
    NSArray *payNameArray = @[@"微信支付",@"支付宝支付"];
    NSArray *payImageNameArr = @[@"weixin",@"zhifubao"];
    self.payNameArray = payNameArray;
    self.payImageNameArr = payImageNameArr;
    
    [self setupUI];
    [self creatheaderView];
    payStyle = @"";
    chooseMoney =@"";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resultClickCancel) name:@"alipayresultCancel" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resultClickSuccess) name:@"alipayresultSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resultClickfail) name:@"alipayresultfail" object:nil];
    
    _listArray = [NSMutableArray array];
    self.listArray = (NSMutableArray *)[CYPurchaseModel mj_objectArrayWithKeyValuesArray:self.choosecard.GroupPurList];
    [self.payCardView reloadData];
}
-(void)resultClickCancel{
    [self.view showInfo:@"订单支付已取消" autoHidden:YES interval:2];
}
-(void)resultClickSuccess{
    [self.view showInfo:@"订单支付成功" autoHidden:YES interval:2];
}
-(void)resultClickfail{
    [self.view showInfo:@"订单支付失败" autoHidden:YES interval:2];
}
#pragma mark-支付成功回调
-(void)goBack{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"购买成功" message:@"点击立即查看" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //卡包
        DSCardGroupController *card=[[DSCardGroupController alloc]init];
        card.hidesBottomBarWhenPushed            = YES;
        [self.navigationController pushViewController:card animated:YES];
        
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)setupUI {
   
    self.payCardView.delegate = self;
    self.payCardView.dataSource = self;
    
  
//    [self.payCardView registerClass:[payCardDetailCell class] forCellReuseIdentifier:id_payDetailCell];
    
    [self.payCardView registerClass:[BusinessPayCell class] forCellReuseIdentifier:id_businessPaycell];
    
   
    
    //底部支付栏
    UIView *payBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Main_Screen_Height - 60*Main_Screen_Height/667, Main_Screen_Width, 60*Main_Screen_Height/667)];
    payBottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:payBottomView];
    //实际支付价格
    bottomPriceLab = [[UILabel alloc] init];
    bottomPriceLab.text = [NSString stringWithFormat:@"￥%@",self.choosecard.PaymentPrice];
    bottomPriceLab.font = [UIFont boldSystemFontOfSize:24*Main_Screen_Height/667];
    bottomPriceLab.textColor = [UIColor colorFromHex:@"#ff525a"];
    [payBottomView addSubview:bottomPriceLab];
    
    [bottomPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(payBottomView);
        make.left.equalTo(payBottomView).mas_offset(12);
    }];
    //原价
    DiscountPriceLab = [[UILabel alloc] init];
    DiscountPriceLab.text = [NSString stringWithFormat:@"￥0.01"];
    DiscountPriceLab.font = [UIFont boldSystemFontOfSize:15];
    DiscountPriceLab.textColor = [UIColor colorFromHex:@"#e6e6e6"];
    [payBottomView addSubview:DiscountPriceLab];
    [DiscountPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bottomPriceLab);
        make.left.equalTo(bottomPriceLab.mas_right).mas_offset(15*Main_Screen_Height/667);
//        make.size.mas_equalTo(CGSizeMake(100, 21));
    }];
    //划线
    UIView * linaVIew = [[UILabel alloc] init];
    linaVIew.backgroundColor = [UIColor colorFromHex:@"#e6e6e6"];
    [payBottomView addSubview:linaVIew];
    [linaVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(DiscountPriceLab);
        make.left.equalTo(DiscountPriceLab);
        make.right.equalTo(DiscountPriceLab);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *bottomPayButton = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width - 136*Main_Screen_Height/667, 0, 136*Main_Screen_Height/667, 60*Main_Screen_Height/667)];
    bottomPayButton.backgroundColor = [UIColor colorFromHex:@"#0161a1"];
    [bottomPayButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [bottomPayButton addTarget:self action:@selector(lijizhifu) forControlEvents:UIControlEventTouchUpInside];
    bottomPayButton.titleLabel.font = [UIFont systemFontOfSize:18*Main_Screen_Height/667];
    [bottomPayButton setTintColor:[UIColor whiteColor]];
    //方法子
    //    [bottomPayButton addTarget:self action:@selector(showAlertWithTitle:message:) forControlEvents:UIControlEventTouchUpInside];
    
    [payBottomView addSubview:bottomPayButton];
}
-(void)creatheaderView
{
    UIView * headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 150*Main_Screen_Height/667)];
    headerView.backgroundColor=[UIColor whiteColor];
    UIView * lineView=[[UIView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height-1, Main_Screen_Width, 1)];
    lineView.backgroundColor=RGBAA(242, 242, 242, 1.0);
    [headerView addSubview:lineView];
    self.payCardView.tableHeaderView = headerView;
    UIView * footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    footView.backgroundColor=RGBAA(242, 242, 242, 1.0);
    self.payCardView.tableFooterView = footView;
    //头部的东西
    UIView * coverView=[[UIView alloc]init];
    coverView.backgroundColor=[UIColor whiteColor];
    [headerView addSubview:coverView];
    
    [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView.mas_left).mas_offset(25);
        make.width.mas_equalTo((275/2));
        make.height.mas_equalTo((158/2));
    }];
    
    typeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (275/2), (158/2))];
    typeImageView.layer.cornerRadius = 5;
    typeImageView.layer.masksToBounds = YES;
    [coverView addSubview:typeImageView];
    
    if(self.choosecard.CardType == 1)
    {
        typeImageView.image = [UIImage imageNamed:@"qw_tiyanka"];
    }else if(self.choosecard.CardType == 2)
    {
        typeImageView.image = [UIImage imageNamed:@"qw_yueka"];
    }else if(self.choosecard.CardType == 3)
    {
        typeImageView.image = [UIImage imageNamed:@"qw_cika"];
    }else if(self.choosecard.CardType == 4)
    {
        typeImageView.image = [UIImage imageNamed:@"qw_nianka"];
    }
    
    moneyLabel = [[UILabel alloc]init];
    moneyLabel.text = [NSString stringWithFormat:@"¥ %@",self.choosecard.CardPrice];
    moneyLabel.textColor =[UIColor colorFromHex:@"#4a4a4a"];
    moneyLabel.font=[UIFont systemFontOfSize:18*Main_Screen_Height/667];
    [headerView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top).mas_offset(38*Main_Screen_Height/667);
        make.left.equalTo(typeImageView.mas_right).mas_offset(30*Main_Screen_Height/667);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    UILabel *qLabel = [[UILabel alloc]init];
    qLabel.text = @"有效期";
    qLabel.textColor =[UIColor colorFromHex:@"#999999"];
    qLabel.font=[UIFont systemFontOfSize:15*Main_Screen_Height/667];
    [headerView addSubview:qLabel];
    [qLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyLabel.mas_bottom).mas_offset(14*Main_Screen_Height/667);
        make.left.equalTo(typeImageView.mas_right).mas_offset(30*Main_Screen_Height/667);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    timeLabel = [[UILabel alloc]init];
    NSString *date = [self computeDateWithDays:self.choosecard.ExpiredDay];
    NSLog(@"date=%@", date);
    timeLabel.text = [NSString stringWithFormat:@"即日起～%@",date];
//    timeLabel.text = @"即日起～2017-08-20";
    timeLabel.textColor =[UIColor colorFromHex:@"#4a4a4a"];
    timeLabel.font=[UIFont systemFontOfSize:15*Main_Screen_Height/667];
    [headerView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qLabel.mas_bottom).mas_offset(14*Main_Screen_Height/667);
        make.left.equalTo(typeImageView.mas_right).mas_offset(30*Main_Screen_Height/667);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
}
//方法子
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    if (self.lastPath.row == 0) {
        message = @"蔷薇爱车想要打开微信";
    }else {
        message = @"蔷薇爱车想要打开支付宝";
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:OKAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.listArray.count;
    }else if (section==1){
        return 1;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString * cellOneID=@"cellOneID";
        CYPurchaseTableViewCell * CYPurchasecell = [_payCardView dequeueReusableCellWithIdentifier:cellOneID];
        if (CYPurchasecell ==nil) {
            CYPurchasecell = [[[NSBundle mainBundle]loadNibNamed:@"CYPurchaseTableViewCell" owner:self options:nil]lastObject];
            CYPurchasecell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [CYPurchasecell configModel:self.listArray[indexPath.row]];
        NSInteger row = [indexPath row];
        NSInteger oldRow1= [self.selectStr row];
        if (row == oldRow1 && self.selectStr != nil) {
            CYPurchasecell.chooseImageView.image=[UIImage imageNamed:@"sel_gouka"];
        }else{
            CYPurchasecell.chooseImageView.image=[UIImage imageNamed:@"nor_gouka"];
        }
        return CYPurchasecell;
    }else if (indexPath.section==1){
        static NSString * cellTwoID=@"cellTwoID";
        CYPurchaseTwoTableViewCell * CYPurchaseTwocell = [_payCardView dequeueReusableCellWithIdentifier:cellTwoID];
        if (CYPurchaseTwocell ==nil) {
            CYPurchaseTwocell = [[[NSBundle mainBundle]loadNibNamed:@"CYPurchaseTwoTableViewCell" owner:self options:nil]lastObject];
            
        }
        CYPurchaseTwocell.getScordLabel.text=[NSString stringWithFormat:@"获得%ld积分",Integralnum];
        return CYPurchaseTwocell;
    }
    BusinessPayCell *paycell = [tableView dequeueReusableCellWithIdentifier:id_businessPaycell forIndexPath:indexPath];
    _seleCell = paycell;
    
    paycell.chooseimageView.image = [UIImage imageNamed:self.payImageNameArr[indexPath.row]];
    paycell.showLabel.text = self.payNameArray[indexPath.row];
    paycell.showLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    paycell.showLabel.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    
    NSInteger row = [indexPath row];
    NSInteger oldRow = [self.lastPath row];
    
    if (row == oldRow && self.lastPath != nil) {
        [paycell.payWayBtn setBackgroundImage:[UIImage imageNamed:@"xaunzhong"] forState:UIControlStateNormal];
    }else{
        
        [paycell.payWayBtn setBackgroundImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    }
     return paycell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 ) {
        return 50*Main_Screen_Height/667;
    }else if (indexPath.section == 1){
        return 80;
    }
    
    return 50*Main_Screen_Height/667;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 2) {
        return 60;
    }else if (section==0)
    {
        return 0;
    }
    return 10;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0 ) {
        return nil;
    }else if (section == 1){
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 10)];
        view.backgroundColor=RGBAA(242, 242, 242, 1.0);
        return view;
    }
    UIView * chooseview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 70)];
    chooseview.backgroundColor=RGBAA(242, 242, 242, 1.0);
    
    UILabel *wayLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 30, Main_Screen_Width-24, 17)];
    wayLabel.text = @"请选择支付方式";
    wayLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    wayLabel.font = [UIFont systemFontOfSize:14];
    [chooseview addSubview:wayLabel];
    return chooseview;
}
#pragma mark - 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 2) {
        
        NSInteger newRow = [indexPath row];
        NSInteger oldRow = (self.lastPath != nil)?[self.lastPath row]:-1;
        
        if (newRow != oldRow) {
            self.seleCell = [tableView cellForRowAtIndexPath:indexPath];
            
            [self.seleCell.payWayBtn setBackgroundImage:[UIImage imageNamed:@"xaunzhong"] forState:UIControlStateNormal];
            
            self.seleCell = [tableView cellForRowAtIndexPath:self.lastPath];
            
            [self.seleCell.payWayBtn setBackgroundImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
            self.lastPath = indexPath;
        }
        if (indexPath.row==0) {
            payStyle = @"微信支付";
        }else if (indexPath.row==1){
            payStyle = @"支付宝支付";
        }
    }else if (indexPath.section==0){
        self.selectStr = indexPath;
        
        
        CYPurchaseModel * model = self.listArray[indexPath.row];
        chooseMoney = [NSString stringWithFormat:@"%@",model.PaymentPrice];
        bottomPriceLab.text = [NSString stringWithFormat:@"￥%@",chooseMoney];
        DiscountPriceLab.text =[NSString stringWithFormat:@"￥%@",model.CardPrice];
        ConfigCode = model.ConfigCode;
        Integralnum = model.Integralnum;
        [self.payCardView reloadData];
    }
}
#pragma mark-购卡支付
-(void)lijizhifu
{
    if ([chooseMoney isEqualToString:@""]) {
        [self.view showInfo:@"请选择购买的类型" autoHidden:YES];
        return;
    }
    if ([payStyle isEqualToString:@""]) {
        [self.view showInfo:@"请选择支付方式" autoHidden:YES];
        return;
    }
    if ([payStyle isEqualToString:@"微信支付"]) {
        //卡编号ConfigCode
        NSDictionary *mulDic = @{
                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                 @"PayMethod":@(1),
                                 @"ConfigCode":[NSString stringWithFormat:@"%ld",ConfigCode]
                                 };
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        NSLog(@"%@",params);
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Payment/PurchasePayment",Khttp] success:^(NSDictionary *dict, BOOL success) {
            NSLog(@"%@",dict);
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                NSDictionary *di = [NSDictionary dictionary];
                di = [dict objectForKey:@"JsonData"];
                
                NSMutableString *stamp = [di objectForKey:@"timestamp"];
                //调起微信支付
                PayReq *req= [[PayReq alloc] init];
                req.partnerId
                = [di objectForKey:@"partnerid"];
                req.prepayId
                = [di objectForKey:@"prepayid"];
                req.nonceStr
                = [di objectForKey:@"noncestr"];
                req.timeStamp
                = stamp.intValue;
                req.package
                = [di objectForKey:@"packag"];
                req.sign = [di objectForKey:@"sign"];
                BOOL result = [WXApi sendReq:req];
                
                NSLog(@"-=-=-=-=-%d", result);
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[di
                                                                                                            objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign
                      );
                
            }
            else
            {
                
                [self.view showInfo:@"信息获取失败,请检查网络" autoHidden:YES interval:2];
                
            }
            
            
            
            
        } fail:^(NSError *error) {
            
            [self.view showInfo:@"信息获取失败,请检查网络" autoHidden:YES interval:2];
        }];
    }else if ([payStyle isEqualToString:@"支付宝支付"]){
        //卡编号ConfigCode
        NSDictionary *mulDic = @{
                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                 @"PayMethod":@(2),
                                 @"ConfigCode":[NSString stringWithFormat:@"%ld",ConfigCode]
                                 };
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Payment/PurchasePayment",Khttp] success:^(NSDictionary *dict, BOOL success) {
            NSLog(@"---%@",dict);
            NSString *appScheme = @"QiangWei";
            [[AlipaySDK defaultService] payOrder:[NSString stringWithFormat:@"%@",dict[@"JsonData"][@"ordercode"]] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
                /**        * 状态码        * 9000 订单支付成功        * 8000 正在处理中        * 4000 订单支付失败        * 6001 用户中途取消        * 6002 网络连接出错        */
                //            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                ////                [self aliPayReslut];
                //            }else if ([resultDic[@"resultStatus"]isEqualToString:@"4000"]){
                //                [self.view showInfo:@"订单支付失败" autoHidden:YES interval:2];
                //
                //            }else if ([resultDic[@"resultStatus"]isEqualToString:@"6001"]){
                //                 [self.view showInfo:@"订单支付已取消" autoHidden:YES interval:2];
                //            }
            }];
        } fail:^(NSError *error) {
            NSLog(@"---错误%@",error);
        }];
    }
    
    
    
}

#pragma mark----当前日期加上天数
- (NSString *)computeDateWithDays:(NSInteger)days
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    NSDate *myDate = [formatter dateFromString:[NSString stringWithFormat:@"%@",currentTimeString]];
    NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * days];
    
    return [formatter stringFromDate:newDate];
}
@end
