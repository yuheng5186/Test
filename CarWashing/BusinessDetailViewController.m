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
#import <CoreLocation/CoreLocation.h>

#import "ShareView.h"
#import "UIView+TYAlertView.h"
#import "TYAlertController+BlurEffects.h"
#import "HTTPDefine.h"
#import "LCMD5Tool.h"
#import "UdStorage.h"
#import "AFNetworkingTool.h"

#import "JXMapNavigationView.h"
#import "HYActivityView.h"
#import "MBProgressHUD.h"

#import "UIImageView+WebCache.h"

@interface BusinessDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, CLLocationManagerDelegate>
{
    MBProgressHUD *HUD;
    UILabel *lblPrice;
    UILabel *formerPriceLab;
    UILabel *lblCarType;
    
    NSString *title;
    UIImage *image;
    NSURL *url;
    enum WXScene scene;
    
    NSArray *activity;
}


@property (nonatomic, strong) HYActivityView *activityView;

@property (nonatomic, weak) BusinessDetailHeaderView *headerView;

@property (nonatomic, weak) UITableView *detailTableView;

@property (nonatomic, strong) NSIndexPath *lastPath;

@property (nonatomic, weak) BusinessDetailCell *detailCell;

@property (nonatomic, strong) NSMutableArray *MerchantDetailData;

@property (nonatomic, strong) NSDictionary *dic;

#pragma mark - map
@property (nonatomic, strong)JXMapNavigationView *mapNavigationView;


@end

static NSString *detailTableViewCell = @"detailTableViewCell";
static NSString *businessCommentCell = @"businessCommentCell";

@implementation BusinessDetailViewController

- (JXMapNavigationView *)mapNavigationView{
    if (_mapNavigationView == nil) {
        _mapNavigationView = [[JXMapNavigationView alloc]init];
    }
    return _mapNavigationView;
}

- (void)drawNavigation {
    
    [self drawTitle:@"商家详情"];
    
    [self drawRightImageButton:@"fenxiang" action:@selector(didClickShareButton:)];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.navigationController setNavigationBarHidden:YES];
    //self.title = @"商家详情";
    
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.dic = [[NSMutableDictionary alloc]init];
    
    self.MerchantDetailData = [[NSMutableArray alloc]init];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.removeFromSuperViewOnHide =YES;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"加载中";
    HUD.minSize = CGSizeMake(132.f, 108.0f);
    
    [self setMerChantDetailData];
    
    
}

-(void)setMerChantDetailData
{
    [self.MerchantDetailData removeAllObjects];
    
    NSDictionary *mulDic = @{
                             @"MerCode":[NSString stringWithFormat:@"%ld",self.MerCode],
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@MerChant/GetStoreDetail",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            self.dic = [dict objectForKey:@"JsonData"];
            //        [self.MerchantDetailData addObjectsFromArray:arr];
            
            [self setupUI];
            [HUD setHidden:YES];
        }
        else
        {
            [self.view showInfo:@"商家信息获取失败" autoHidden:YES interval:2];
            [self.navigationController popViewControllerAnimated:YES];
        }
      
        
        
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)setupUI {
    
    UIView *containHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width/2 + 196)];
    [self.view addSubview:containHeadView];
    
    UIImageView *detaiImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width/2)];
    
//    detaiImgView.image = [UIImage imageNamed:@"hangdiantu"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,self.dic[@"Img"]];
        NSURL *url=[NSURL URLWithString:ImageURL];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *img=[UIImage imageWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            detaiImgView.image = img;
        });
    });

    
    [containHeadView addSubview:detaiImgView];
    
    
    BusinessDetailHeaderView *headerView = [BusinessDetailHeaderView businessDetailHeaderView];
    
    headerView.frame = CGRectMake(0, Main_Screen_Width/2, Main_Screen_Width, 196);
    
    self.headerView = headerView;
    
    headerView.nameLabel.text = self.dic[@"MerName"];
    headerView.adressLabel.text = self.dic[@"MerAddress"];
    [headerView.starImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@xing",[[NSString stringWithFormat:@"%@",self.dic[@"Score"]] substringToIndex:1]]]];
    headerView.scoreLabel.text = [NSString stringWithFormat:@"%@分",self.dic[@"Score"]];
    headerView.adressLabel2.text = self.dic[@"MerAddress"];
    headerView.openTimeLabel.text = self.dic[@"ServiceTime"];
    headerView.distanceLabel.text = [NSString stringWithFormat:@"%@km",self.dic[@"Distance"]];
    
    headerView.ServiceNumLabel.text = [NSString stringWithFormat:@"服务%@单",self.dic[@"ServiceCount"]];
    if([self.dic[@"ShopType"] intValue] == 1)
    {
        headerView.shopTypeLabel.text = @"洗车服务";
    }
    
    headerView.freeCheckLabel.hidden = YES;
    headerView.qualityLabel.hidden = YES;
    
    NSArray *lab = [[self.dic objectForKey:@"MerFlag"] componentsSeparatedByString:@","];
    UILabel *MerflagsLabel;
    for (int i = 0; i < [lab count]; i++) {
        MerflagsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + i % 3 * 67,  i / 3 * 25 + 83, 60, 15)];
        MerflagsLabel.text = lab[i];
        MerflagsLabel.backgroundColor = [UIColor redColor];
        [MerflagsLabel setFont:[UIFont fontWithName:@"Helvetica" size:11 ]];
        MerflagsLabel.textColor = [UIColor colorFromHex:@"#fefefe"];
        MerflagsLabel.backgroundColor = [UIColor colorFromHex:@"#ff7556"];
        MerflagsLabel.textAlignment = NSTextAlignmentCenter;
        MerflagsLabel.layer.masksToBounds = YES;
        MerflagsLabel.layer.cornerRadius = 7.5*Main_Screen_Height/667;
        [headerView addSubview:MerflagsLabel];
    }
    
    [headerView.favoriteButton addTarget:self
                          action:@selector(BtnClickCollect:)
                        forControlEvents:UIControlEventTouchUpInside];
    headerView.favoriteButton.selected = ([[self.dic objectForKey:@"IsCollection"] intValue] == 1)?YES:NO;
    
//    if([self.dic objectForKey:@"MerFlag"])
//    {
//        if([lab count] <= 3)
//        {
//           
//        }
//        else if(([lab count] > 3) && ([lab count] <= 6))
//        {
//            containHeadView.frame = CGRectMake(0, 0, Main_Screen_Width, 375/2 + 196+15);
//            headerView.frame = CGRectMake(0, 375/2, Main_Screen_Width, 196+15);
//            headerView.separateView.frame.origin.y
//            
//        }
//        else
//        {
//            containHeadView.frame = CGRectMake(0, 0, Main_Screen_Width, 375/2 + 196+30);
//            headerView.frame = CGRectMake(0, 375/2, Main_Screen_Width, 196+30);
//        }
//        
//    }
   

    
    
    
    [containHeadView addSubview:headerView];
    //detaiImgView.bottom  = headerView.top;

    [headerView addTarget:self action:@selector(clickDetailView) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITableView *detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 - 60*Main_Screen_Height/667) style:UITableViewStyleGrouped];
    detailTableView.contentInset = UIEdgeInsetsMake(0, 0, 5, 0);
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
    UIButton *commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50*Main_Screen_Height/667)];
    [commentBtn setTitle:@"查看全部评价" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor colorFromHex:@"#3a3a3a"] forState:UIControlStateNormal];
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:12*Main_Screen_Height/667];
    commentBtn.backgroundColor = [UIColor whiteColor];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 215*Main_Screen_Height/667)];
//    v.backgroundColor = [UIColor redColor];
    
    if([self.dic[@"CommentCount"] integerValue]>0)
    {
        [self.view addSubview:commentBtn];
        //添加点击事件
        [commentBtn addTarget:self action:@selector(clickCommentButton) forControlEvents:UIControlEventTouchUpInside];
        
        detailTableView.tableFooterView = commentBtn;
    }else
    {
        [self.view addSubview:v];
        
        
        UIImageView *ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(120*Main_Screen_Height/667, 27*Main_Screen_Height/667, 135*Main_Screen_Height/667, 120*Main_Screen_Height/667)];
        ImgView.image = [UIImage imageNamed:@"pinglun_kongbai"];
        [v addSubview:ImgView];
        
        UILabel *nocommentlab = [[UILabel alloc]initWithFrame:CGRectMake(0, ImgView.frame.origin.y+ImgView.frame.size.height+17*Main_Screen_Height/667, Main_Screen_Width, 14*Main_Screen_Height/667)];
        nocommentlab.text = @"暂无评价信息";
        nocommentlab.font = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
        nocommentlab.textAlignment = NSTextAlignmentCenter;
        nocommentlab.textColor = [UIColor colorFromHex:@"#999999"];
        [v addSubview:nocommentlab];
        detailTableView.tableFooterView = v;
    }
    
//    [self.view addSubview:commentBtn];
    
    
    
    //底部支付栏
    UIView *payToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, Main_Screen_Height - 60*Main_Screen_Height/667, Main_Screen_Width, 60*Main_Screen_Height/667)];
    payToolBar.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:payToolBar];
    
    

    if([self.dic[@"MerSerList"] count] == 0)
    {
        lblPrice = [[UILabel alloc] init];
        lblPrice.text = @"0";
        lblPrice.font = [UIFont systemFontOfSize:18];
        lblPrice.textColor = [UIColor colorFromHex:@"#ff525a"];
        [payToolBar addSubview:lblPrice];
        
        formerPriceLab = [[UILabel alloc] init];
        formerPriceLab.text = @"0";
        formerPriceLab.textColor = [UIColor colorFromHex:@"#999999"];
        formerPriceLab.font = [UIFont systemFontOfSize:13];
        [payToolBar addSubview:formerPriceLab];
        
        lblCarType = [[UILabel alloc] init];
        lblCarType.text = @"";
        lblCarType.font = [UIFont systemFontOfSize:13];
        lblCarType.textColor = [UIColor colorFromHex:@"#999999"];
        [payToolBar addSubview:lblCarType];
    }
    else
    {
        lblPrice = [[UILabel alloc] init];
        lblPrice.text = [NSString stringWithFormat:@"¥%@",[[self.dic[@"MerSerList"] objectAtIndex:0] objectForKey:@"CurrentPrice"]];
        lblPrice.font = [UIFont systemFontOfSize:18*Main_Screen_Height/667];
        lblPrice.textColor = [UIColor colorFromHex:@"#ff525a"];
        [payToolBar addSubview:lblPrice];
        
        formerPriceLab = [[UILabel alloc] init];
        formerPriceLab.text = [NSString stringWithFormat:@"¥%@",[[self.dic[@"MerSerList"] objectAtIndex:0] objectForKey:@"OriginalPrice"]];
        formerPriceLab.textColor = [UIColor colorFromHex:@"#999999"];
        formerPriceLab.font = [UIFont systemFontOfSize:13];
        [payToolBar addSubview:formerPriceLab];
        
        lblCarType = [[UILabel alloc] init];
        lblCarType.text = [[self.dic[@"MerSerList"] objectAtIndex:0] objectForKey:@"SerName"];
        lblCarType.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        lblCarType.textColor = [UIColor colorFromHex:@"#999999"];
        [payToolBar addSubview:lblCarType];
    }
    

    
    UIButton *payBtn = [[UIButton alloc] init];
    payBtn.frame     = CGRectMake(Main_Screen_Width - 92*Main_Screen_Height/667, 0, 92*Main_Screen_Height/667, 60*Main_Screen_Height/667);
    [payBtn setTitle:@"去结算" forState:UIControlStateNormal];
    [payBtn setTintColor:[UIColor colorFromHex:@"#ffffff"]];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:18*Main_Screen_Height/667];
    //payBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    payBtn.backgroundColor = [UIColor colorFromHex:@"#febb02"];
    [payToolBar addSubview:payBtn];
    
    //跳转支付页面
    [payBtn addTarget:self action:@selector(clickPayButton) forControlEvents:UIControlEventTouchUpInside];
    
    //约束
    [lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(payToolBar).mas_offset(12*Main_Screen_Height/667);
        make.left.equalTo(payToolBar).mas_offset(20*Main_Screen_Height/667);
    }];
    
    [formerPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(lblPrice.mas_trailing).mas_offset(10*Main_Screen_Height/667);
        make.bottom.equalTo(lblPrice);
    }];
    
    [lblCarType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(lblPrice);
        make.top.mas_equalTo(lblPrice.mas_bottom).mas_offset(6*Main_Screen_Height/667);
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
        make.top.equalTo(payToolBar).mas_offset(12*Main_Screen_Height/667);
        make.trailing.equalTo(payBtn.mas_leading).mas_equalTo(-37*Main_Screen_Height/667);
        make.width.height.mas_equalTo(20*Main_Screen_Height/667);
    }];
    
    [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(serviceBtn);
        make.top.equalTo(serviceBtn.mas_bottom).mas_offset(7*Main_Screen_Height/667);
    }];
    
}

#pragma mark - 点击取消/收藏
-(void)BtnClickCollect:(UIButton *)button
{
//    if (button.selected)
//    {
    
    
        
        NSDictionary *mulDic = @{
                                 @"MerCode":[NSString stringWithFormat:@"%ld",self.MerCode],
                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
//                                 @"IsFavourite":[UdStorage getObjectforKey:@"Account_Id"],
                                 };
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@MerChant/AddFavouriteMerchant",Khttp] success:^(NSDictionary *dict, BOOL success) {
            NSLog(@"%@",dict);
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
//               [self.view showInfo:@"收藏成功" autoHidden:YES interval:2];
            }
            else
            {
//                [self.view showInfo:@"收藏失败" autoHidden:YES interval:2];
//                [self.navigationController popViewControllerAnimated:YES];
            }
            
            
            
            
        } fail:^(NSError *error) {
//            [self.view showInfo:@"收藏失败" autoHidden:YES interval:2];
        }];

        
//    }
//    else
//    {
//        NSLog(@"no");
//    }
    
}

#pragma mark - 点击拨打客服
- (void)didClickServiceBtn:(UIButton *)button {
//    NSString *message = @"是否拨打商家电话";
//    NSString *title = @"";
//    [self showAlertWithTitle:title message:message];
    [PhoneHelper dial: self.dic[@"MerPhone"]];
}

#pragma mark - 点击查看全部评价
- (void)clickCommentButton {
    
    ShopViewController *commentVC = [[ShopViewController alloc] init];
    
    commentVC.dic = self.dic;
    
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - 点击商家详情
- (void)clickDetailView{
    
    ShopViewController *shopController = [[ShopViewController alloc] init];
    
    shopController.dic = self.dic;
    
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
    if(section == 1)
    {
        if([self.dic[@"MerComList"] count]>5)
        {
            return 5;
        }
        else
        {
            return [self.dic[@"MerComList"] count];
        }
    }
    else
    {
        return [self.dic[@"MerSerList"] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    if (businessDetailCell == nil) {
//        businessDetailCell = [BusinessDetailCell businessDetailCell];
//    }
    if (indexPath.section == 0) {
        BusinessDetailCell *businessDetailCell = [tableView dequeueReusableCellWithIdentifier:detailTableViewCell forIndexPath:indexPath];
        businessDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _detailCell = businessDetailCell;
        
        businessDetailCell.carLabel.text = [[self.dic[@"MerSerList"] objectAtIndex:indexPath.row] objectForKey:@"SerName"];
        businessDetailCell.clearLabel.text = [[self.dic[@"MerSerList"] objectAtIndex:indexPath.row] objectForKey:@"SerComment"];
        businessDetailCell.priceLabel.text = [NSString stringWithFormat:@"¥%@",[[self.dic[@"MerSerList"] objectAtIndex:indexPath.row] objectForKey:@"CurrentPrice"]];
        businessDetailCell.originPriceLabel.text = [NSString stringWithFormat:@"¥%@",[[self.dic[@"MerSerList"] objectAtIndex:indexPath.row] objectForKey:@"OriginalPrice"]];
        
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
    
    
    
    [estimateCell.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,[[self.dic[@"MerComList"] objectAtIndex:indexPath.row] objectForKey:@"FromuserImg"]]] placeholderImage:[UIImage imageNamed:@"xichebaidi"]];
    
    estimateCell.phoneLabel.text = [[self.dic[@"MerComList"] objectAtIndex:indexPath.row] objectForKey:@"FromuserName"];
    [estimateCell.userScoreLabel setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@xing",[[NSString stringWithFormat:@"%@",self.dic[@"Score"]] substringToIndex:1]]]];
    estimateCell.commentLabel.text = [[self.dic[@"MerComList"] objectAtIndex:indexPath.row] objectForKey:@"CommentContent"];
    estimateCell.dateLabel.text = [[self.dic[@"MerComList"] objectAtIndex:indexPath.row] objectForKey:@"CommentDate"];
    estimateCell.timeLabel.hidden = YES;
    
    estimateCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return estimateCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 100*Main_Screen_Height/667;
    }
    
    return 110*Main_Screen_Height/667;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40*Main_Screen_Height/667;
    
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
            
            lblPrice.text = [NSString stringWithFormat:@"¥%@",[[self.dic[@"MerSerList"] objectAtIndex:self.lastPath.row] objectForKey:@"CurrentPrice"]];
            formerPriceLab.text = [NSString stringWithFormat:@"¥%@",[[self.dic[@"MerSerList"] objectAtIndex:self.lastPath.row] objectForKey:@"OriginalPrice"]];
            lblCarType.text = [[self.dic[@"MerSerList"] objectAtIndex:self.lastPath.row] objectForKey:@"SerName"];
            
            
//            NSLog(@"%ld",self.lastPath.row);
            
            
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
        textLab.text = [NSString stringWithFormat:@"评论 (%@)",self.dic[@"CommentCount"]];
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
    
//    ShareView *shareView = [ShareView createViewFromNib];
//    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:shareView preferredStyle:TYAlertControllerStyleAlert];
//    
//    [alertController setBlurEffectWithView:self.view];
//    //[alertController setBlurEffectWithView:(UIView *)view style:(BlurEffectStyle)blurStyle];
//    [self presentViewController:alertController animated:YES completion:nil];
    if (!self.activityView) {
        self.activityView = [[HYActivityView alloc]initWithTitle:@"" referView:self.view];
        
        //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
        self.activityView.numberOfButtonPerLine = 6;
        
        ButtonView *bv ;
        
        bv = [[ButtonView alloc]initWithText:@"微信" image:[UIImage imageNamed:@"btn_share_weixin"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信");
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.text                = @"简单文本分享测试";
            req.bText               = YES;
            // 目标场景
            // 发送到聊天界面  WXSceneSession
            // 发送到朋友圈    WXSceneTimeline
            // 发送到微信收藏  WXSceneFavorite
            req.scene               = WXSceneSession;
            [WXApi sendReq:req];
            
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"微信朋友圈" image:[UIImage imageNamed:@"btn_share_pengyouquan"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信朋友圈");
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.text                = @"简单文本分享测试";
            req.bText               = YES;
            // 目标场景
            // 发送到聊天界面  WXSceneSession
            // 发送到朋友圈    WXSceneTimeline
            // 发送到微信收藏  WXSceneFavorite
            req.scene               = WXSceneTimeline;
            [WXApi sendReq:req];
            
        }];
        [self.activityView addButtonView:bv];
        
    }
    
    [self.activityView show];
    
    
}


#pragma mark - 地图导航
- (IBAction)didClickSmallBtn:(UIButton *)sender {
    

    [self.mapNavigationView showMapNavigationViewWithtargetLatitude:22.488260 targetLongitute:113.915049 toName:@"中海油华英加油站"];
    [self.view addSubview:_mapNavigationView];

}

//方法子
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [PhoneHelper dial: self.dic[@"MerPhone"]];
        
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


#pragma mark - 拨打商家电话
- (IBAction)didClickShopPhoneBtn:(UIButton *)sender {
    
    NSString *message = @"是否拨打商家电话";
    NSString *title = @"";
    [self showAlertWithTitle:title message:message];

}

- (void)viewWillAppear:(BOOL)animated {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.lastPath = indexPath;
//    [self.detailTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
//    if ([_detailTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
//        [_detailTableView.delegate tableView:_detailTableView didSelectRowAtIndexPath:indexPath];
//    }
}














@end
