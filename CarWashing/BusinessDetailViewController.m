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
#import "QWMerchantModel.h"

//新加的可展开的cell
#import "HeaderView.h"

#import "CYBusinessDetailModel.h"
#import "CYBusinessDetailModel1.h"
static NSString * const ReuseIdentifierHeader = @"header";
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
    NSInteger CyPrice;
    NSInteger CYOriginalPrice;
    NSString *CYTitle;
    NSInteger CySerCode;
    NSInteger chooseType;//选中
    NSInteger CYServerType;//没有服务
}


@property (nonatomic, strong) HYActivityView *activityView;

@property (nonatomic, weak) BusinessDetailHeaderView *headerView;

@property (nonatomic, weak) UITableView *detailTableView;

@property (nonatomic, strong) NSIndexPath *lastPath;

@property (nonatomic, weak) BusinessDetailCell *detailCell;

@property (nonatomic, strong) NSMutableArray *MerchantDetailData;

@property (nonatomic, strong) NSDictionary *dic;
@property(nonatomic,strong)QWMerchantModel *MerChantmodel;
@property(nonatomic,strong)QWMerComListModel *MerComListmodel;
@property(nonatomic,strong)QWMerSerListModel *MerSerListmodel;
#pragma mark - map
@property (nonatomic, strong)JXMapNavigationView *mapNavigationView;
//****8//
@property (nonatomic, strong) NSMutableArray      *CYDetailArray;//朝阳数据数组
@property (nonatomic, strong) NSMutableArray      *CYDetailArray1;//
@property (nonatomic, strong) NSMutableArray      *expendArray;//记录打开的分组
@property (nonatomic, strong) NSMutableArray      *selectArray;//记录选择的所有选项
@property (nonatomic, strong) NSIndexPath         * selectStr;
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
    _CYDetailArray = [NSMutableArray array];
    _CYDetailArray1 = [NSMutableArray array];
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
    NSLog(@"--传过来的id%@",params);
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@MerChant/GetStoreDetail",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"--%@",dict);
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            self.dic = [dict objectForKey:@"JsonData"];
               self.MerChantmodel=[[QWMerchantModel alloc]initWithDictionary:[dict objectForKey:@"JsonData"] error:nil];
            NSLog(@"%@",self.dic);
            //        [self.MerchantDetailData addObjectsFromArray:arr];
            self.CYDetailArray = (NSMutableArray*)[CYBusinessDetailModel mj_objectArrayWithKeyValuesArray:dict[@"JsonData"][@"ShopSerList"]];
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
    
    UIView *containHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width/2 + 196*Main_Screen_Height/667+10*Main_Screen_Height/667)];
    containHeadView.backgroundColor=RGBAA(242, 242, 242, 1.0);
    [self.view addSubview:containHeadView];
    
    UIImageView *detaiImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width/2)];
    
    detaiImgView.image = [UIImage imageNamed:@"hangdiantu"];
    if (!IsNullIsNull(self.MerChantmodel.Img)) {
        NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,self.MerChantmodel.Img];
        [detaiImgView sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"shangjiadingwei"]];
    }

    
    [containHeadView addSubview:detaiImgView];
    
    
    BusinessDetailHeaderView *headerView = [BusinessDetailHeaderView businessDetailHeaderView];
    
    headerView.frame = CGRectMake(0, Main_Screen_Width/2, Main_Screen_Width, 196*Main_Screen_Height/667);
    
    self.headerView = headerView;
    if (self.MerChantmodel!=nil) {
         headerView.merchantModel=self.MerChantmodel;
    }
  
        
//    headerView.nameLabel.text = self.dic[@"MerName"];
//    headerView.adressLabel.text = self.dic[@"MerAddress"];
//    [headerView.starImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@xing",[[NSString stringWithFormat:@"%@",self.dic[@"Score"]] substringToIndex:1]]]];
//    headerView.scoreLabel.text = [NSString stringWithFormat:@"%@分",self.dic[@"Score"]];
//    headerView.adressLabel2.text = self.dic[@"MerAddress"];
//    headerView.openTimeLabel.text = self.dic[@"ServiceTime"];
////    headerView.distanceLabel.text = [NSString stringWithFormat:@"%@km",self.dic[@"Distance"]];
    headerView.distanceLabel.text = [NSString stringWithFormat:@"%.2fkm",[self.distance doubleValue]];
    
//    headerView.ServiceNumLabel.text = [NSString stringWithFormat:@"服务%@单",self.dic[@"ServiceCount"]];
//    headerView.ServiceNumLabel.textColor  = [UIColor colorFromHex:@"#ff525a"];
//     NSString   *scoreString     = [NSString stringWithFormat:@"服务%@单",self.dic[@"ServiceCount"]];
//    if (self.dic[@"ServiceCount"]!=nil) {
//        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:scoreString];
//        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0, 2)];
//        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHex:@"#4a4a4a"] range:NSMakeRange(0, 2)];
//        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHex:@"#4a4a4a"] range:NSMakeRange([scoreString length]-1, 1)];
//        
//        headerView.ServiceNumLabel.attributedText   = AttributedStr;
//    }
//   
    
    
    
    
    if([self.dic[@"ShopType"] intValue] == 1)
    {
        headerView.shopTypeLabel.text = @"洗车服务";
    }
    
    headerView.freeCheckLabel.hidden = YES;
    headerView.qualityLabel.hidden = YES;
    
    NSArray *lab = [[self.dic objectForKey:@"MerFlag"] componentsSeparatedByString:@","];
    UILabel *MerflagsLabel;
    for (int i = 0; i < [lab count]; i++) {
        MerflagsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20*Main_Screen_Height/667 + i % 3 * 67*Main_Screen_Height/667,  i / 3 * 25*Main_Screen_Height/667 + 83*Main_Screen_Height/667, 60*Main_Screen_Height/667, 15*Main_Screen_Height/667)];
        MerflagsLabel.text = lab[i];
//        MerflagsLabel.backgroundColor = [UIColor redColor];
        [MerflagsLabel setFont:[UIFont fontWithName:@"Helvetica" size:11*Main_Screen_Height/667 ]];
        MerflagsLabel.textColor = [UIColor colorFromHex:@"#a8c4d7"];
//        MerflagsLabel.backgroundColor = [UIColor colorFromHex:@"#ff7556"];
        MerflagsLabel.textAlignment = NSTextAlignmentCenter;
        MerflagsLabel.layer.masksToBounds = YES;
        MerflagsLabel.layer.borderWidth=0.8*Main_Screen_Height/667;
        MerflagsLabel.layer.borderColor=[UIColor colorFromHex:@"#a8c4d7"].CGColor;
        MerflagsLabel.layer.cornerRadius = 7.5*Main_Screen_Height/667;
        [headerView addSubview:MerflagsLabel];
    }
    
    [headerView.favoriteButton addTarget:self
                          action:@selector(BtnClickCollect:)
                        forControlEvents:UIControlEventTouchUpInside];
    headerView.favoriteButton.selected = (self.MerChantmodel.IsCollection == 1)?YES:NO;
    
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
    
    
    UITableView *detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64 - 60*Main_Screen_Height/667) style:UITableViewStylePlain];
    detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    detailTableView.contentInset = UIEdgeInsetsMake(0, 0, 5, 0);
    self.detailTableView = detailTableView;
    
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"BusinessDetailCell" bundle:nil];
    [detailTableView registerNib:nib forCellReuseIdentifier:detailTableViewCell];
    
    [detailTableView registerNib:[UINib nibWithNibName:@"BusinessEstimateCell" bundle:nil] forCellReuseIdentifier:businessCommentCell];
    
    //detailTableView.rowHeight = 100;
    detailTableView.estimatedRowHeight = 100;
    detailTableView.rowHeight = UITableViewAutomaticDimension;
    
    detailTableView.tableHeaderView = containHeadView;
    
    [self.view addSubview:detailTableView];
    
    detailTableView.tableFooterView = [UIView new];
    [detailTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:ReuseIdentifierHeader];
    
    [detailTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
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
        lblPrice.font = [UIFont systemFontOfSize:18*Main_Screen_Height/667];
        lblPrice.textColor = [UIColor colorFromHex:@"#ff525a"];
        [payToolBar addSubview:lblPrice];
        
        formerPriceLab = [[UILabel alloc] init];
        formerPriceLab.text = @"0";
        formerPriceLab.textColor = [UIColor colorFromHex:@"#999999"];
        formerPriceLab.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        [payToolBar addSubview:formerPriceLab];
        
        lblCarType = [[UILabel alloc] init];
        lblCarType.text = @"";
        lblCarType.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
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
        formerPriceLab.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        [payToolBar addSubview:formerPriceLab];
        
        
        NSString *textStr = formerPriceLab.text;
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
        formerPriceLab.attributedText = attribtStr;
        
        
        
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
    payBtn.backgroundColor = [UIColor colorFromHex:@"#0161a1"];
    [payToolBar addSubview:payBtn];
    
    //跳转支付页面
    [payBtn addTarget:self action:@selector(clickPayButton) forControlEvents:UIControlEventTouchUpInside];
    
    //约束
    [lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(payToolBar).mas_offset(10*Main_Screen_Height/667);
        make.left.equalTo(payToolBar).mas_offset(20*Main_Screen_Height/667);
    }];
    
    [formerPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(lblPrice.mas_trailing).mas_offset(10*Main_Screen_Height/667);
        make.bottom.equalTo(lblPrice);
    }];
    
    [lblCarType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(lblPrice);
        make.top.mas_equalTo(lblPrice.mas_bottom).mas_offset(4*Main_Screen_Height/667);
    }];
    
    /*[payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
     make.width.mas_equalTo(120);
     make.height.mas_equalTo(80);
     make.right.top.equalTo(payToolBar);
     }];
     */
    
    UIButton *serviceBtn = [[UIButton alloc] init];
    [serviceBtn setImage:[UIImage imageNamed:@"kefu_service"] forState:UIControlStateNormal];
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
    
    UIButton *serviceAreaBtn = [[UIButton alloc] init];
    [serviceAreaBtn addTarget:self action:@selector(didClickServiceBtn:) forControlEvents:UIControlEventTouchUpInside];
    [payToolBar addSubview:serviceAreaBtn];
    
    [serviceAreaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(payToolBar);
        make.trailing.equalTo(payBtn.mas_leading).mas_equalTo(-37*Main_Screen_Height/667);
        make.width.mas_equalTo(50*Main_Screen_Height/667);
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
//            NSLog(@"%@",dict);
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
//               [self.view showInfo:@"收藏成功" autoHidden:YES interval:2];
            }
            else
            {
                [self.view showInfo:@"收藏失败" autoHidden:YES interval:2];
//                [self.navigationController popViewControllerAnimated:YES];
            }
            
            
            
            
        } fail:^(NSError *error) {
            [self.view showInfo:@"收藏失败" autoHidden:YES interval:2];
        }];

    
}

#pragma mark - 点击拨打客服
- (void)didClickServiceBtn:(UIButton *)button {
    [PhoneHelper dial: @"4006979558"];
//    NSString *message = @"是否拨打商家电话";
//    NSString *title = @"";
//    [self showAlertWithTitle:title message:message];
//    [PhoneHelper dial:self.dic[@"MerPhone"]];
}

#pragma mark - 点击查看全部评价
- (void)clickCommentButton {
    
    ShopViewController *commentVC = [[ShopViewController alloc] init];
    commentVC.isComment = YES;
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

    payController.SerMerChant = self.dic[@"MerName"];
    payController.SerProject = lblCarType.text;
    payController.Jprice = formerPriceLab.text;
    payController.Xprice = lblPrice.text;
    
    payController.MCode = self.dic[@"MerCode"];
    payController.SCode = [NSString stringWithFormat:@"%ld",CySerCode];
    
    payController.OrderCode = @"";
    
    
    [self.navigationController pushViewController:payController animated:YES];
}


#pragma mark - tableView代理数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.CYDetailArray.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == self.CYDetailArray.count)
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
        CYBusinessDetailModel * Cymodel = self.CYDetailArray[section];
        NSString *key = [NSString stringWithFormat:@"%@",Cymodel.Title];
        self.CYDetailArray1 = (NSMutableArray*)[CYBusinessDetailModel1 mj_objectArrayWithKeyValuesArray:Cymodel.serList];
    
        if ([self.expendArray containsObject:key]) {
            return self.CYDetailArray1.count;
        }else {
            return 0.5;
        }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    if (indexPath.section==self.CYDetailArray.count) {//评论的
        BusinessEstimateCell *estimateCell = [tableView dequeueReusableCellWithIdentifier:businessCommentCell forIndexPath:indexPath];
        
        
        [estimateCell.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,[[self.dic[@"MerComList"] objectAtIndex:indexPath.row] objectForKey:@"FromuserImg"]]] placeholderImage:[UIImage imageNamed:@"huiyuantou"]];
        if([[[self.dic[@"MerComList"] objectAtIndex:indexPath.row] objectForKey:@"FromuserName"] isKindOfClass:[NSNull class]])
        {
            estimateCell.phoneLabel.text = @"";
        }else
        {
            
            estimateCell.phoneLabel.text = [[self.dic[@"MerComList"] objectAtIndex:indexPath.row] objectForKey:@"FromuserName"];
        }
        //    [estimateCell.userScoreLabel setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@xing",[[NSString stringWithFormat:@"%@",self.dic[@"Score"]] substringToIndex:1]]]];
        if([[[self.dic[@"MerComList"] objectAtIndex:indexPath.row] objectForKey:@"Score"] isKindOfClass:[NSNull class]])
        {
            
        }else
        {
            [estimateCell.userScoreLabel setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@xing",[[NSString stringWithFormat:@"%@",[[self.dic[@"MerComList"] objectAtIndex:indexPath.row] objectForKey:@"Score"]] substringToIndex:1]]]];
        }
        
        //    estimateCell.commentLabel.text = [[self.dic[@"MerComList"] objectAtIndex:indexPath.row] objectForKey:@"CommentContent"];
        if([[[self.dic[@"MerComList"] objectAtIndex:indexPath.row] objectForKey:@"CommentContent"] isKindOfClass:[NSNull class]])
        {
            estimateCell.commentLabel.text = @"";
        }else
        {
            estimateCell.commentLabel.text = [[self.dic[@"MerComList"] objectAtIndex:indexPath.row] objectForKey:@"CommentContent"];
        }
        
        //    estimateCell.dateLabel.text = [[self.dic[@"MerComList"] objectAtIndex:indexPath.row] objectForKey:@"CommentDate"];
        if([[[self.dic[@"MerComList"] objectAtIndex:indexPath.row] objectForKey:@"CommentDate"] isKindOfClass:[NSNull class]])
        {
            estimateCell.dateLabel.text = @"";
        }else
        {
            estimateCell.dateLabel.text = [[self.dic[@"MerComList"] objectAtIndex:indexPath.row] objectForKey:@"CommentDate"];
        }
        estimateCell.timeLabel.hidden = YES;
        
        estimateCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return estimateCell;
    }
    
    CYBusinessDetailModel * Cymodel = self.CYDetailArray[indexPath.section];
    self.CYDetailArray1 = (NSMutableArray*)[CYBusinessDetailModel1 mj_objectArrayWithKeyValuesArray:Cymodel.serList];
    
   
    CYBusinessDetailModel1 * Cymodel1 = self.CYDetailArray1[indexPath.row];
//    NSString *name = Cymodel1.SerName;
    
    BusinessDetailCell *businessDetailCell = [tableView dequeueReusableCellWithIdentifier:detailTableViewCell forIndexPath:indexPath];
    businessDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
    _detailCell = businessDetailCell;
    
    NSInteger row = [indexPath row];
    NSInteger oldRow1= [self.selectStr row];
    if (row == oldRow1 && self.selectStr != nil) {
        businessDetailCell.stateButton.selected = YES;
    }else{
       businessDetailCell.stateButton.selected = NO;
    }
    
   
//    if ([self.selectArray containsObject:name]) {
//        businessDetailCell.stateButton.selected = YES;
//    }else {
//        businessDetailCell.stateButton.selected = NO;
//    }
    businessDetailCell.carLabel.text = Cymodel1.SerName;
    businessDetailCell.clearLabel.text = Cymodel1.SerComment;
    businessDetailCell.priceLabel.text = [NSString stringWithFormat:@"¥%ld",Cymodel1.CurrentPrice];
    businessDetailCell.originPriceLabel.text = [NSString stringWithFormat:@"¥%ld",Cymodel1.OriginalPrice];

    return businessDetailCell;
    
   
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50*Main_Screen_Height/667;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section>=0&&indexPath.section<self.CYDetailArray.count) {
        CYBusinessDetailModel * Cymodel = self.CYDetailArray[indexPath.section];
        //    NSString *key = [NSString stringWithFormat:@"%@",Cymodel.Title];
        self.CYDetailArray1 = (NSMutableArray*)[CYBusinessDetailModel1 mj_objectArrayWithKeyValuesArray:Cymodel.serList];
        CYBusinessDetailModel1 * Cymodel1 = self.CYDetailArray1[indexPath.row];
        CySerCode = Cymodel1.SerCode;
//        NSString *name = Cymodel1.SerName;
        NSInteger CurrentPrice = Cymodel1.CurrentPrice;
        NSInteger OriginalPrice = Cymodel1.OriginalPrice;
//        if ([self.selectArray containsObject:name]) {
//            [self.selectArray removeObject:name];
//            CyPrice = CyPrice-CurrentPrice;
//            CYOriginalPrice = CYOriginalPrice-OriginalPrice;
//        }else {
//            [self.selectArray addObject:name];
//            CyPrice = CyPrice+CurrentPrice;
//            CYOriginalPrice = CYOriginalPrice+OriginalPrice;
//        }
        lblPrice.text = [NSString stringWithFormat:@"¥%ld",CurrentPrice];
        
        formerPriceLab.text = [NSString stringWithFormat:@"¥%ld",OriginalPrice];
        NSString *textStr = formerPriceLab.text;
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
        formerPriceLab.attributedText = attribtStr;
        
        lblCarType.text = [NSString stringWithFormat:@"%@",Cymodel1.SerName];
        // 选中类型
        self.selectStr = indexPath;
        [self.detailTableView reloadData];
        NSLog(@"-00--%ld",CySerCode);

    }

}

#pragma mark - 设置组头视图

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==self.CYDetailArray.count) {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50*Main_Screen_Height/667)];
        v.backgroundColor=RGBAA(242, 242, 242, 1.0);
        UIView * whiteView=[[UIView alloc]initWithFrame:CGRectMake(0, 10*Main_Screen_Height/667, Main_Screen_Width, 40*Main_Screen_Height/667)];
        whiteView.backgroundColor=[UIColor whiteColor];
        [v addSubview:whiteView];
        UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, Main_Screen_Width, 40*Main_Screen_Height/667)];
        textLab.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        textLab.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
        textLab.text = [NSString stringWithFormat:@"评论 (%ld)",((NSArray *)self.dic[@"MerComList"]).count];
        [whiteView addSubview:textLab];
        UIView * lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 39*Main_Screen_Height/667, Main_Screen_Width, 1*Main_Screen_Height/667)];
        lineView.backgroundColor=RGBAA(242, 242, 242, 1.0);
        [whiteView addSubview:lineView];
        return v;
    }
    CYBusinessDetailModel * Cymodel = self.CYDetailArray[section];
    NSString *key = [NSString stringWithFormat:@"%@",Cymodel.Title];
    self.CYDetailArray1 = (NSMutableArray*)[CYBusinessDetailModel1 mj_objectArrayWithKeyValuesArray:Cymodel.serList];
   
    HeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ReuseIdentifierHeader];
    view.nameLabel.text = key;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, -2, self.view.bounds.size.width, 0.3)];
    lab.backgroundColor = [UIColor whiteColor];
    lab.alpha = 0.2;
    [view addSubview:lab];
    
    BOOL selectAll = YES;
    for (id object in self.CYDetailArray1) {
        if (![self.selectArray containsObject:object]) {
            selectAll = NO;
        }
    }
    [view.tap addTarget:self action:@selector(headerTap:)];
    
    if ([self.expendArray containsObject:key]) {
        view.jiantouInageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else {
        view.jiantouInageView.transform = CGAffineTransformIdentity;
    }
    return view;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (void)headerTap:(UITapGestureRecognizer *)tap {
   
   
        HeaderView *view = (HeaderView *)tap.view;
        NSString *key = view.nameLabel.text;
        NSInteger index = [self.CYDetailArray indexOfObject:key];
        
        if ([self.expendArray containsObject:key]) {
            [self.expendArray removeObject:key];
            [UIView animateWithDuration:0.1 animations:^{
                view.jiantouInageView.transform = CGAffineTransformIdentity;
            }];
        }else {
            [self.expendArray addObject:key];
            [UIView animateWithDuration:0.1 animations:^{
                view.jiantouInageView.transform = CGAffineTransformMakeRotation(M_PI_2);
            }];
        }
        [self.detailTableView reloadData];

   
//    [self.detailTableView reloadSections:[NSIndexSet indexSetWithIndex:index+1] withRowAnimation:UITableViewRowAnimationNone];
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
            
            
            NSDictionary *mulDic = @{
                                     @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                     @"ShareType":@1
                                     };
            NSDictionary *params = @{
                                     @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                     @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                     };
            
            [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@InviteShare/UserShare",Khttp] success:^(NSDictionary *dict, BOOL success) {
                
                if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
                {
                    //创建发送对象实例
                    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
                    sendReq.bText = NO;//不使用文本信息
                    sendReq.scene = 0;//0 = 好友列表 1 = 朋友圈 2 = 收藏
                    
                    //创建分享内容对象
                    WXMediaMessage *urlMessage = [WXMediaMessage message];
                    urlMessage.title = [[dict objectForKey:@"JsonData"] objectForKey:@"ShareTitle"];;//分享标题
                    urlMessage.description =[[dict objectForKey:@"JsonData"] objectForKey:@"ShareContent"];;//分享描述
                    [urlMessage setThumbImage:[UIImage imageNamed:@"loginIcon"]];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
                    
                    //创建多媒体对象
                    WXWebpageObject *webObj = [WXWebpageObject object];
                    webObj.webpageUrl = [NSString stringWithFormat:@"%@",[[dict objectForKey:@"JsonData"] objectForKey:@"InviteShareUrl"]];//分享链接
                    
                    //完成发送对象实例
                    urlMessage.mediaObject = webObj;
                    sendReq.message = urlMessage;
                    
                    //发送分享信息
                    [WXApi sendReq:sendReq];

                }
                else
                {
                     [self.view showInfo:@"分享失败，请重试" autoHidden:YES interval:2];
                    
                }
                
            } fail:^(NSError *error) {
                [self.view showInfo:@"分享失败，请重试" autoHidden:YES interval:2];
                
            }];

            
            
            
            
            
            
            
            
            
            
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"微信朋友圈" image:[UIImage imageNamed:@"btn_share_pengyouquan"] handler:^(ButtonView *buttonView){
            NSLog(@"点击微信朋友圈");
            NSDictionary *mulDic = @{
                                     @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                     @"ShareType":@1
                                     };
            NSDictionary *params = @{
                                     @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                     @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                     };
            
            [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@InviteShare/UserShare",Khttp] success:^(NSDictionary *dict, BOOL success) {
                
                if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
                {
                    //创建发送对象实例
                    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
                    sendReq.bText = NO;//不使用文本信息
                    sendReq.scene = 1;//0 = 好友列表 1 = 朋友圈 2 = 收藏
                    
                    //创建分享内容对象
                    WXMediaMessage *urlMessage = [WXMediaMessage message];
                    urlMessage.title = [[dict objectForKey:@"JsonData"] objectForKey:@"ShareTitle"];;//分享标题
                    urlMessage.description =[[dict objectForKey:@"JsonData"] objectForKey:@"ShareContent"];;//分享描述
                    [urlMessage setThumbImage:[UIImage imageNamed:@"loginIcon"]];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
                    
                    //创建多媒体对象
                    WXWebpageObject *webObj = [WXWebpageObject object];
                    webObj.webpageUrl = [NSString stringWithFormat:@"%@",[[dict objectForKey:@"JsonData"] objectForKey:@"InviteShareUrl"]];//分享链接
                    
                    //完成发送对象实例
                    urlMessage.mediaObject = webObj;
                    sendReq.message = urlMessage;
                    
                    //发送分享信息
                    [WXApi sendReq:sendReq];
                    
                }
                else
                {
                    [self.view showInfo:@"分享失败，请重试" autoHidden:YES interval:2];
                    
                }
                
            } fail:^(NSError *error) {
                [self.view showInfo:@"分享失败，请重试" autoHidden:YES interval:2];
                
            }];
            
        }];
        [self.activityView addButtonView:bv];
        
    }
    
    [self.activityView show];
    
    
}


#pragma mark - 地图导航
- (IBAction)didClickSmallBtn:(UIButton *)sender {
    
    NSLog(@"%@--%@",[NSString stringWithFormat:@"%@",self.dic[@"Ym"]],[NSString stringWithFormat:@"%@",self.dic[@"Xm"]]);
    [self.mapNavigationView showMapNavigationViewWithtargetLatitude:[self.dic[@"Ym"] doubleValue] targetLongitute:[self.dic[@"Xm"] doubleValue] toName:self.dic[@"MerName"]];
    [self.view addSubview:_mapNavigationView];

}

////方法子
//- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    [alertController addAction:cancelAction];
//    
//    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        [PhoneHelper dial: self.dic[@"MerPhone"]];
//        
//    }];
//    [alertController addAction:OKAction];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
//    
//}


#pragma mark - 拨打商家电话
- (IBAction)didClickShopPhoneBtn:(UIButton *)sender {
    
//    NSString *message = @"是否拨打商家电话";
//    NSString *title = @"";
//    [self showAlertWithTitle:title message:message];
//    NSLog(@"self.dic == %@",self.dic[@"MerPhone"]);
    [PhoneHelper dial: self.dic[@"MerPhone"]];

}

- (void)viewWillAppear:(BOOL)animated {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.lastPath = indexPath;
//    [self.detailTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
//    if ([_detailTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
//        [_detailTableView.delegate tableView:_detailTableView didSelectRowAtIndexPath:indexPath];
//    }
}
#pragma mark---懒加载
- (NSMutableArray *)expendArray {
    if (!_expendArray) {
        _expendArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _expendArray;
}

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _selectArray;
}
@end
