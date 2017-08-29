//
//  DSCarClubDetailController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/28.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSCarClubDetailController.h"

#import "DSActivityDetailCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "IQKeyboardManager.h"
#import "UIScrollView+EmptyDataSet.h"//第三方空白页

#import "HTTPDefine.h"
#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "CarClubNews.h"
#import "UdStorage.h"
#import "MBProgressHUD.h"


@interface DSCarClubDetailController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    CarClubNews *newsDetail;
    
    
}

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray    *modelsArray;
@property (nonatomic, strong) NSMutableArray    *moreArray;
@property (nonatomic, strong) UIImageView       *userImageView;
@property (nonatomic, strong) UIImageView       *seeImageView;
@property (nonatomic, strong) UILabel           *seeNumber;
@property (nonatomic, strong) UILabel           *textTitleLabel;
@property (nonatomic, strong) UILabel           *textContentLabel;
@property (nonatomic, strong) UIImageView       *textImageView;
@property (nonatomic, strong) UIButton          *goodButton;
@property (nonatomic, strong) UILabel           *goodNumberLabel;

@property (nonatomic, strong) UILabel           *userName;
@property (nonatomic, strong) UILabel           *sayTime;
@property (nonatomic, strong) UILabel           *titleLab;
@property (nonatomic, strong) UILabel           *contentLab;
@property (nonatomic, strong) UILabel           *sayNumberLab;

@property (nonatomic, strong) UITextField       *userSayTextField;
@property (nonatomic, strong) UIButton          *sayButton;
@property (nonatomic, strong) UIButton          *downGoodButton;
@property (nonatomic, strong) UILabel           *sayShowLabel;
@property (nonatomic, strong) UILabel           *goodShowLabel;
@property (nonatomic, strong)UIView *downView;
@property (nonatomic)NSInteger page;

@property (nonatomic, strong) TPKeyboardAvoidingScrollView *scrollView;

@end

@implementation DSCarClubDetailController

- (void)drawNavigation {
    
    [self drawTitle:@"活动详情"];
    
}

- (void) drawContent
{
    self.contentView.top                = 44;
    self.contentView.height             = self.view.height;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//     [IQKeyboardManager sharedManager].enable = YES;
    // Do any additional setup after loading the view.
    
    newsDetail = [[CarClubNews alloc]init];
    self.page = 0;
    
    //添加监听，当键盘出现时收到消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)name:UIKeyboardWillShowNotification object:nil];
    //添加监听，当键盘退出时收到消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)name:UIKeyboardWillHideNotification object:nil];
    
     [self createSubView];
}
// 当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    // 获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;

    if (self.userSayTextField.text.length ==0) {//键盘弹出
        
        self.downView.frame = CGRectMake(0, Main_Screen_Height -Main_Screen_Height*100/667, Main_Screen_Width, Main_Screen_Height*60/667);
    }else{
        CGRect rect =CGRectMake(0, Main_Screen_Height -Main_Screen_Height*100/667, Main_Screen_Width, Main_Screen_Height*60/667);
        self.downView.frame = rect;
    }
}
// 当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{

    if (self.userSayTextField.text.length ==0) {//键盘弹出
        
        self.downView.frame = CGRectMake(0, Main_Screen_Height -Main_Screen_Height*100/667, Main_Screen_Width, Main_Screen_Height*60/667);
    }else{
        CGRect rect =CGRectMake(0, Main_Screen_Height -Main_Screen_Height*100/667, Main_Screen_Width, Main_Screen_Height*60/667);
        self.downView.frame = rect;
    }

}


- (void) createSubView {

    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height-Main_Screen_Height*100/667)];
    self.tableView.top              = 0;

    if (Main_Screen_Height == 568) {
        self.tableView.top              = 0;

    }

    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
#pragma maek-空白页
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    //    self.tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    //    self.tableView.scrollEnabled    = NO;
    //    self.tableView.tableFooterView  = [UIView new];
//    self.tableView.contentInset     = UIEdgeInsetsMake(0, 0, 180, 0);
    [self.contentView addSubview:self.tableView];
    self.tableView.backgroundColor=[UIColor clearColor];
    
    [self setupRefresh];
}

- (void) createHeaderView {
    UIView *header = [UIView new];
    header.width = [UIScreen mainScreen].bounds.size.width;
    header.backgroundColor  = [UIColor whiteColor];
    

    
    
    UIImageView *userImageView  = [UIImageView new];
    userImageView.image         = [UIImage imageNamed:@"icon0.jpg"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,newsDetail.FromusrImg];
        NSURL *url=[NSURL URLWithString:ImageURL];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *img=[UIImage imageWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [userImageView setImage:img];
        });
    });
    self.userImageView          = userImageView;
    [header addSubview:userImageView];
    
    
    userImageView.sd_layout
    .leftSpaceToView(header, 10*Main_Screen_Height/667)
    .topSpaceToView(header, 10*Main_Screen_Height/667)
    .heightIs(40*Main_Screen_Height/667)
    .widthIs(40*Main_Screen_Height/667);
    userImageView.sd_cornerRadiusFromWidthRatio     = @(0.5);
    
    
    UILabel *userName                   = [UILabel new];
    userName.textColor                  = [UIColor blackColor];
    userName.font                       = [UIFont systemFontOfSize:14];
    userName.textColor                  = [UIColor colorFromHex:@"#3a3a3a"];
    userName.text                       = newsDetail.FromusrName;
    self.userName                       = userName;
    [header addSubview:userName];
    
    userName.sd_layout
    .leftSpaceToView(userImageView, 10*Main_Screen_Height/667)
    .topSpaceToView(header, 10*Main_Screen_Height/667)
    .heightIs(20*Main_Screen_Height/667)
    .widthIs(150*Main_Screen_Height/667);
    
    
    UILabel *seeNumberLabel                   = [UILabel new];
    seeNumberLabel.textColor                  = [UIColor blackColor];
    seeNumberLabel.font                       = [UIFont systemFontOfSize:12];
    seeNumberLabel.textColor                  = [UIColor colorFromHex:@"#868686"];
    seeNumberLabel.text                       = [NSString stringWithFormat:@"%ld",newsDetail.Readcount];
    self.seeNumber                            = seeNumberLabel;
    [header addSubview:seeNumberLabel];
    
    seeNumberLabel.sd_layout
    .rightSpaceToView(header, 10*Main_Screen_Height/667)
    .topSpaceToView(header, 10*Main_Screen_Height/667)
    .heightIs(20*Main_Screen_Height/667)
    .widthIs(40*Main_Screen_Height/667);
    
    
    UIImageView *seeImageView  = [UIImageView new];
    seeImageView.image         = [UIImage imageNamed:@"yanjing.jpg"];
    self.seeImageView          = seeImageView;
    [header addSubview:seeImageView];
    
    
    seeImageView.sd_layout
    .rightSpaceToView(seeNumberLabel, 5*Main_Screen_Height/667)
    .topSpaceToView(header, 12*Main_Screen_Height/667)
    .heightIs(15*Main_Screen_Height/667)
    .widthIs(15*Main_Screen_Height/667);
    
    
    
    
    UILabel *sayTimeLab                 = [UILabel new];
    sayTimeLab.textColor                = [UIColor colorFromHex:@"#999999"];
    sayTimeLab.text                     = newsDetail.ActDate;
    sayTimeLab.font                     = [UIFont systemFontOfSize:11*Main_Screen_Height/667];
    self.sayTime                        = sayTimeLab;
    [header addSubview:sayTimeLab];
    
    
    sayTimeLab.sd_layout
    .leftEqualToView(userName)
    .topSpaceToView(userName, 5*Main_Screen_Height/667)
    .widthIs(150*Main_Screen_Height/667)
    .heightIs(20*Main_Screen_Height/667);
    
    
    
    
    
    UIView *backgroudView               = [UIView new];
    backgroudView.width                 = [UIScreen mainScreen].bounds.size.width;
    backgroudView.backgroundColor       = [UIColor colorFromHex:@"#f6f6f6"];
    [header addSubview:backgroudView];
    
    backgroudView.sd_layout
    .topSpaceToView(sayTimeLab, 10*Main_Screen_Height/667)
    .leftEqualToView(header)
    .heightIs(300*Main_Screen_Height/667);
    
    UILabel *textTitleLabel                 = [UILabel new];
    textTitleLabel.textColor                = [UIColor colorFromHex:@"#4a4a4a"];
    textTitleLabel.text                     = newsDetail.ActivityName;
    textTitleLabel.font                     = [UIFont systemFontOfSize:14];
    self.textTitleLabel                     = textTitleLabel;
    [backgroudView addSubview:textTitleLabel];
    
    
    textTitleLabel.sd_layout
    .leftSpaceToView(backgroudView, 10*Main_Screen_Height/667)
    .topSpaceToView(backgroudView, 10*Main_Screen_Height/667)
    .widthIs(250*Main_Screen_Height/667)
    .heightIs(40*Main_Screen_Height/667);
    
    UILabel *textContentLabel                 = [UILabel new];
    textContentLabel.textColor                = [UIColor colorFromHex:@"#999999"];
    textContentLabel.text                     = newsDetail.Comment;
    textContentLabel.font                     = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    textContentLabel.numberOfLines            = 0;
    self.textContentLabel                     = textContentLabel;
    [backgroudView addSubview:textContentLabel];
    
    
    textContentLabel.sd_layout
    .leftEqualToView(textTitleLabel)
    .rightSpaceToView(backgroudView, 10*Main_Screen_Height/667)
    .topSpaceToView(textTitleLabel, 10*Main_Screen_Height/667)
    .autoHeightRatio(0);
    
    UIImageView *textImageView  = [UIImageView new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,newsDetail.IndexImg];
        NSURL *url=[NSURL URLWithString:ImageURL];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *img=[UIImage imageWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [textImageView setImage:img];
        });
    });
    self.textImageView          = textImageView;
    [backgroudView addSubview:textImageView];
    
    textImageView.sd_layout
    .topSpaceToView(textContentLabel, 10*Main_Screen_Height/667)
    .leftEqualToView(textContentLabel)
    .widthRatioToView(textContentLabel, 1)
    .heightIs(200*Main_Screen_Height/667);
    
    
    UIButton    *goodButton = [UIButton new];
    [goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
    goodButton.backgroundColor  = [UIColor whiteColor];
    [goodButton addTarget:self action:@selector(goodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.goodButton         = goodButton;
    [backgroudView addSubview:goodButton];
    
    goodButton.sd_layout
    .topSpaceToView(textImageView, 10*Main_Screen_Height/667)
    .centerXEqualToView(textImageView)
    .heightIs(50*Main_Screen_Height/667)
    .widthIs(50*Main_Screen_Height/667);
    goodButton.layer.cornerRadius = goodButton.size.width/2;
    
    
    
    UILabel  *goodNumberLabel                = [UILabel new];
    goodNumberLabel.textColor                = [UIColor colorFromHex:@"#999999"];
    goodNumberLabel.text                     = @"共有168人点赞过";
    goodNumberLabel.font                     = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    self.goodNumberLabel                     = goodNumberLabel;
    goodNumberLabel.textAlignment            = NSTextAlignmentCenter;
    [backgroudView addSubview:goodNumberLabel];
    
    goodNumberLabel.sd_layout
    .topSpaceToView(goodButton, 10*Main_Screen_Height/667)
    .centerXEqualToView(goodButton)
    .widthIs(150*Main_Screen_Height/667)
    .heightIs(20*Main_Screen_Height/667);
    
    
    [backgroudView setupAutoHeightWithBottomView:goodNumberLabel bottomMargin:10];
    
    
    
    UILabel *sayNumberLab                   = [UILabel new];
    sayNumberLab.textColor                  = [UIColor blackColor];
    sayNumberLab.font                       = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
    sayNumberLab.text                       = @"评论（0）";
    self.sayNumberLab                       = sayNumberLab;
    [header addSubview:sayNumberLab];
    
    sayNumberLab.sd_layout
    .leftSpaceToView(header, 10*Main_Screen_Height/667)
    .topSpaceToView(backgroudView, 10*Main_Screen_Height/667)
    .widthIs(100*Main_Screen_Height/667)
    .heightIs(20*Main_Screen_Height/667);
    
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [header addSubview:bottomLine];
    
    bottomLine.sd_layout
    .topSpaceToView(sayNumberLab, 10*Main_Screen_Height/667)
    .leftSpaceToView(header, 0)
    .rightSpaceToView(header, 0)
    .heightIs(1);
    
    

    [header setupAutoHeightWithBottomView:bottomLine bottomMargin:10*Main_Screen_Height/667];
    [header layoutSubviews];
    self.tableView.tableHeaderView  = header;
    
    if(_modelsArray.count == 0)
    {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 215*Main_Screen_Height/667)];
        v.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:v];
        
        
        UIImageView *ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(120*Main_Screen_Width/375, 27*Main_Screen_Height/667, 135*Main_Screen_Width/375, 120*Main_Screen_Height/667)];
        ImgView.image = [UIImage imageNamed:@"pinglun_kongbai"];
        [v addSubview:ImgView];
        
        UILabel *nocommentlab = [[UILabel alloc]initWithFrame:CGRectMake(0, ImgView.frame.origin.y+ImgView.frame.size.height+17*Main_Screen_Height/667, Main_Screen_Width, 14*Main_Screen_Height/667)];
        nocommentlab.text = @"暂无评价信息";
        nocommentlab.font = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
        nocommentlab.textAlignment = NSTextAlignmentCenter;
        nocommentlab.textColor = [UIColor colorFromHex:@"#999999"];
        [v addSubview:nocommentlab];
        self.tableView.tableFooterView = v;
    }
    

    
    
    
    self.downView = [UIView new];
    self.downView .frame = CGRectMake(0, Main_Screen_Height -
                                      Main_Screen_Height*100/667, Main_Screen_Width, Main_Screen_Height*60/667);
    self.downView .backgroundColor  = [UIColor whiteColor];
    
    
    self.userSayTextField                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-150, Main_Screen_Height*40/667)];
    self.userSayTextField.placeholder    = @"    我来说两句...";
    self.userSayTextField.delegate       = self;
    self.userSayTextField.returnKeyType  = UIReturnKeyDone;
    self.userSayTextField.textAlignment  = NSTextAlignmentLeft;
    self.userSayTextField.font           = [UIFont systemFontOfSize:12*Main_Screen_Height/667];
    self.userSayTextField.backgroundColor= [UIColor whiteColor];
    self.userSayTextField.layer.cornerRadius    = Main_Screen_Height*20/667;
    self.userSayTextField.layer.borderWidth     = 1;
    self.userSayTextField.layer.borderColor     = [UIColor colorFromHex:@"#b4b4b4"].CGColor;
    self.userSayTextField.left           = Main_Screen_Width*10/375 ;
    self.userSayTextField.top            = Main_Screen_Height*5/667;
    [self.userSayTextField addTarget:self action:@selector(userSayTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.downView  addSubview:self.userSayTextField];
    
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(self.userSayTextField.frame.origin.x,self.userSayTextField.frame.origin.y,15.0, self.userSayTextField.frame.size.height)];
    self.userSayTextField.leftView = blankView;
    self.userSayTextField.leftViewMode =UITextFieldViewModeAlways;
    
    
    UIButton    *sayButton = [UIButton new];
    [sayButton setImage:[UIImage imageNamed:@"huodongxiangqingxiaoxi"] forState:UIControlStateNormal];
    sayButton.backgroundColor  = [UIColor whiteColor];
    [sayButton addTarget:self action:@selector(sayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.sayButton         = sayButton;
    [self.downView  addSubview:sayButton];
    
    sayButton.sd_layout
    .leftSpaceToView(self.userSayTextField, 10*Main_Screen_Height/667)
    .centerYEqualToView(self.userSayTextField)
    .heightIs(20*Main_Screen_Height/667)
    .widthIs(20*Main_Screen_Height/667);
    
    
    UILabel *sayShowLabel                   = [UILabel new];
    sayShowLabel.textColor                  = [UIColor colorFromHex:@"#999999"];
    sayShowLabel.font                       = [UIFont systemFontOfSize:12*Main_Screen_Height/667];
    sayShowLabel.text                       = @"369";
    self.sayShowLabel                       = sayShowLabel;
    [self.downView  addSubview:sayShowLabel];
    
    sayShowLabel.sd_layout
    .leftSpaceToView(sayButton, 5)
    .topSpaceToView(self.downView , 12*Main_Screen_Height/667)
    .widthIs(40*Main_Screen_Height/667)
    .heightIs(20*Main_Screen_Height/667);
    
    UIButton    *downGoodButton = [UIButton new];
    [downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
    downGoodButton.backgroundColor  = [UIColor whiteColor];
    [downGoodButton addTarget:self action:@selector(downGoodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.downGoodButton         = downGoodButton;
    [self.downView  addSubview:downGoodButton];
    
    downGoodButton.sd_layout
    .leftSpaceToView(self.sayShowLabel, 5*Main_Screen_Height/667)
    .centerYEqualToView(self.userSayTextField)
    .heightIs(20*Main_Screen_Height/667)
    .widthIs(20*Main_Screen_Height/667);
    
    
    UILabel *goodShowLabel                   = [UILabel new];
    goodShowLabel.textColor                  = [UIColor colorFromHex:@"#999999"];
    goodShowLabel.font                       = [UIFont systemFontOfSize:12*Main_Screen_Height/667];
    goodShowLabel.text                       = @"369";
    self.goodShowLabel                       = goodShowLabel;
    [self.downView  addSubview:goodShowLabel];
    
    goodShowLabel.sd_layout
    .leftSpaceToView(downGoodButton, 0)
    .topSpaceToView(self.downView , 12*Main_Screen_Height/667)
    .widthIs(40*Main_Screen_Height/667)
    .heightIs(20*Main_Screen_Height/667);
    
    self.goodNumberLabel.text = [NSString stringWithFormat:@"共有%ld人点赞过",newsDetail.GiveCount];
    self.sayNumberLab.text = [NSString stringWithFormat:@"评论(%ld)",newsDetail.CommentCount];
    if(newsDetail.IsGive == 1)
    {
        [self.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
        self.goodButton.selected = YES;
        
        [self.downGoodButton setImage:[UIImage imageNamed:@"xiaohongshou"] forState:UIControlStateNormal];
        self.downGoodButton.selected = YES;
    }
    else
    {
        [self.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
        self.goodButton.selected = NO;
        
        
        [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
        self.downGoodButton.selected = NO;
    }
    self.sayShowLabel.text = [NSString stringWithFormat:@"%ld",newsDetail.CommentCount];
    self.goodShowLabel.text = [NSString stringWithFormat:@"%ld",newsDetail.GiveCount];
    
    [self.downView  layoutSubviews];

    [self.contentView addSubview:self.downView ];
    
//    [self.scrollView addSubview:self.contentView];
//    [self.view addSubview:self.scrollView];

}

-(void)requestActivityDetail
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"ActivityCode":[NSString stringWithFormat:@"%ld",self.ActivityCode]
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    //
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/GetActivityInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
//            [self.view showInfo:@"获取数据成功" autoHidden:YES interval:2];
            
            NSDictionary *dic = [dict objectForKey:@"JsonData"];
            
            [newsDetail setValuesForKeysWithDictionary:dic];
            
            
            NSArray *arr = [NSArray array];
            arr = [dic objectForKey:@"actModelList"];
            for(NSDictionary *dic in arr)
            {

//                NSLog(@"%@",dic);
                DSUserModel *model = [DSUserModel new];
            
                [model setValuesForKeysWithDictionary:dic];
                [_modelsArray addObject:model];
            }

       
//            self.userName.text = newsDetail.FromusrName;
//            self.sayTime.text = newsDetail.ActDate;
//            self.seeNumber.text = [NSString stringWithFormat:@"%ld",newsDetail.Readcount];
//            self.textTitleLabel.text = newsDetail.ActivityName;
//            self.textContentLabel.text = newsDetail.Comment;
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                                                NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,newsDetail.IndexImg];
//                                                NSURL *url=[NSURL URLWithString:ImageURL];
//                                                NSData *data=[NSData dataWithContentsOfURL:url];
//                                                UIImage *img=[UIImage imageWithData:data];
//                                                dispatch_sync(dispatch_get_main_queue(), ^{
//                                                    [self.textImageView setImage:img];
//                                                });
//                                            });
//            self.goodNumberLabel.text = [NSString stringWithFormat:@"共有%ld人点赞过",newsDetail.GiveCount];
//            self.sayNumberLab.text = [NSString stringWithFormat:@"评论(%ld)",newsDetail.CommentCount];
//            if(newsDetail.IsGive == 1)
//            {
//                [self.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
//                [self.downGoodButton setImage:[UIImage imageNamed:@"xiaohongshou"] forState:UIControlStateNormal];
//                self.goodButton.selected = YES;
//                self.downGoodButton.selected = YES;
//            }
//            else
//            {
//                [self.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
//                [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
//                self.goodButton.selected = NO;
//                self.downGoodButton.selected = NO;
//            }
//            self.sayShowLabel.text = [NSString stringWithFormat:@"%ld",newsDetail.CommentCount];
//            self.goodShowLabel.text = [NSString stringWithFormat:@"%ld",newsDetail.GiveCount];
            
//
           [self createHeaderView];
            [_tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }
        else
        {
            [self.view showInfo:@"获取数据失败" autoHidden:YES interval:2];
            [self.tableView.mj_header endRefreshing];
        }
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取数据失败" autoHidden:YES interval:2];
        [self.tableView.mj_header endRefreshing];
    }];

}

-(void)setupRefresh
{
    
    
    
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        
        [self headerRereshing];
        
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        
        [self footerRereshing];
        
    }];
    
    
}

- (void)headerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _modelsArray = [NSMutableArray new];
        self.page = 0 ;
        
        [self requestActivityDetail];
        
    });
}


- (void)footerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(_modelsArray.count == 0)
        {
            [self requestCommentList];
        }
        else
        {
            self.page++;
            _moreArray = [NSMutableArray array];
            [self requestCommentList2];
            
            
//            if(_moreArray.count == 0)
//            {
//                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                hud.removeFromSuperViewOnHide =YES;
//                hud.mode = MBProgressHUDModeText;
//                hud.labelText = @"无更多数据";
//                hud.minSize = CGSizeMake(132.f, 108.0f);
//                [hud hide:YES afterDelay:3];
//                [self.tableView.mj_footer endRefreshing];
//                self.page--;
//            }
//            else
//            {
//                
//                
//                [self.tableView reloadData];
//                [self.tableView.mj_footer endRefreshing];
//            }
        }
        
        
        
        
        // 刷新表格
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        
    });
}


-(void)requestCommentList
{
    NSDictionary *mulDic = @{
                             @"ActivityCode":[NSString stringWithFormat:@"%ld",self.ActivityCode],
                             @"PageIndex":[NSString stringWithFormat:@"%ld",self.page],
                             @"PageSize":@10
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/GetActivityCommentList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
//            [self.view showInfo:@"获取数据成功" autoHidden:YES interval:2];
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            for(NSDictionary *dic in arr)
            {
                DSUserModel *model = [DSUserModel new];
                [model setValuesForKeysWithDictionary:dic];
                [_modelsArray addObject:model];
            }
            [_tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
            
        }
        else
        {
            [self.view showInfo:@"获取数据失败" autoHidden:YES interval:2];
            [self.tableView.mj_footer endRefreshing];
        }
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取数据失败" autoHidden:YES interval:2];
        [self.tableView.mj_footer endRefreshing];
    }];

}

-(void)requestCommentList2
{
    NSDictionary *mulDic = @{
                             @"ActivityCode":[NSString stringWithFormat:@"%ld",self.ActivityCode],
                             @"PageIndex":[NSString stringWithFormat:@"%ld",self.page],
                             @"PageSize":@10
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/GetActivityCommentList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            //            [self.view showInfo:@"获取数据成功" autoHidden:YES interval:2];
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            for(NSDictionary *dic in arr)
            {
                DSUserModel *model = [DSUserModel new];
                [model setValuesForKeysWithDictionary:dic];
                [_moreArray addObject:model];
            }
            if(_moreArray.count == 0)
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.removeFromSuperViewOnHide =YES;
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"无更多数据";
                hud.minSize = CGSizeMake(132.f, 108.0f);
                [hud hide:YES afterDelay:3];
                [self.tableView.mj_footer endRefreshing];
                self.page--;
            }
            else
            {
                [_modelsArray addObjectsFromArray:_moreArray];
                [_tableView reloadData];
                [self.tableView.mj_footer endRefreshing];
            }
            
            
            
        }
        else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.removeFromSuperViewOnHide =YES;
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"无更多数据";
            hud.minSize = CGSizeMake(132.f, 108.0f);
            [hud hide:YES afterDelay:3];
            [self.tableView.mj_footer endRefreshing];
            self.page--;
            
            
//            [self.view showInfo:@"获取数据失败" autoHidden:YES interval:2];
            
        }
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取数据失败" autoHidden:YES interval:2];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}


- (TPKeyboardAvoidingScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.contentView.bounds];
    }
    return _scrollView;
}


- (void) userSayTextFieldChanged:(UITextField *)sender {


    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
       return YES;
}
- (void) sayButtonClick:(id)sender {

    [self.userSayTextField becomeFirstResponder];
    
}
- (void) downGoodButtonClick:(UIButton *)sender {

    if (sender.selected == NO) {
        
        
        NSDictionary *mulDic = @{
                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                 @"SupTypeCode":[NSString stringWithFormat:@"%ld",self.ActivityCode],
                                 @"SupType": @1
                                 };
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/AddActivitySupporInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
            
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                [self.view showInfo:@"点赞成功" autoHidden:YES interval:2];
                
                [self.downGoodButton setImage:[UIImage imageNamed:@"xiaohongshou"] forState:UIControlStateNormal];
                self.goodShowLabel.text                     = [NSString stringWithFormat:@"%ld",newsDetail.GiveCount+1];
                newsDetail.GiveCount++;
                self.goodNumberLabel.text = [NSString stringWithFormat:@"共有%ld人点赞过",newsDetail.GiveCount];
                [self.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
                self.goodButton.selected = YES;
            }
            else
            {
                [self.view showInfo:@"点赞失败" autoHidden:YES interval:2];
                [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
                self.downGoodButton.selected = NO;
            }
            
        } fail:^(NSError *error) {
            [self.view showInfo:@"点赞失败" autoHidden:YES interval:2];
            [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
            self.downGoodButton.selected = NO;
        }];
        
        
        
    }else {
        
        
        NSDictionary *mulDic = @{
                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                 @"SupTypeCode":[NSString stringWithFormat:@"%ld",self.ActivityCode],
                                 @"SupType": @1
                                 };
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/AddActivitySupporInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
            
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                [self.view showInfo:@"取消点赞成功" autoHidden:YES interval:2];
                self.goodShowLabel.text = [NSString stringWithFormat:@"%ld",newsDetail.GiveCount-1];
                [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
               
                newsDetail.GiveCount--;
                [self.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
                self.goodNumberLabel.text                     = [NSString stringWithFormat:@"共有%ld人点赞过",newsDetail.GiveCount];
                self.goodButton.selected = NO;
            }
            else
            {
                [self.view showInfo:@"取消点赞失败" autoHidden:YES interval:2];
                [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
                self.downGoodButton.selected = YES;
            }
            
        } fail:^(NSError *error) {
            [self.view showInfo:@"取消点赞失败" autoHidden:YES interval:2];
            [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
            self.downGoodButton.selected = YES;
        }];
        
        
        
        
        
    }

    
    sender.selected = !sender.selected;
}
- (void) goodButtonClick:(UIButton *)sender {

    if (sender.selected == NO) {
        
        
        NSDictionary *mulDic = @{
                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                 @"SupTypeCode":[NSString stringWithFormat:@"%ld",self.ActivityCode],
                                 @"SupType": @1
                                 };
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/AddActivitySupporInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
            
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                [self.view showInfo:@"点赞成功" autoHidden:YES interval:2];
                
                [self.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
                self.goodNumberLabel.text                     = [NSString stringWithFormat:@"共有%ld人点赞过",newsDetail.GiveCount + 1];
                newsDetail.GiveCount++;
                self.goodShowLabel.text = [NSString stringWithFormat:@"%ld",newsDetail.GiveCount];
                [self.downGoodButton setImage:[UIImage imageNamed:@"xiaohongshou"] forState:UIControlStateNormal];
                self.downGoodButton.selected = YES;
            }
            else
            {
                [self.view showInfo:@"点赞失败" autoHidden:YES interval:2];
                [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
                self.downGoodButton.selected = NO;
            }
            
        } fail:^(NSError *error) {
            [self.view showInfo:@"点赞失败" autoHidden:YES interval:2];
            [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
            self.downGoodButton.selected = NO;
        }];

        
    
    }else {
        
        
        NSDictionary *mulDic = @{
                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                 @"SupTypeCode":[NSString stringWithFormat:@"%ld",self.ActivityCode],
                                 @"SupType": @1
                                 };
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/AddActivitySupporInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
            
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                [self.view showInfo:@"取消点赞成功" autoHidden:YES interval:2];
                
                [self.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
                self.goodNumberLabel.text                     = [NSString stringWithFormat:@"共有%ld人点赞过",newsDetail.GiveCount - 1];
                newsDetail.GiveCount--;
                self.goodShowLabel.text = [NSString stringWithFormat:@"%ld",newsDetail.GiveCount];
                [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
                self.downGoodButton.selected = NO;
            }
            else
            {
                [self.view showInfo:@"取消点赞失败" autoHidden:YES interval:2];
                [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
                self.downGoodButton.selected = YES;
            }
            
        } fail:^(NSError *error) {
            [self.view showInfo:@"取消点赞失败" autoHidden:YES interval:2];
            [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
            self.downGoodButton.selected = YES;
        }];
        
        
        
        

    }

    sender.selected = !sender.selected;
    
    
}


//- (void) creatModelsWithCount:(NSInteger)count {
//    
//    if (!_modelsArray) {
//        _modelsArray = [NSMutableArray new];
//    }
//    
//    NSArray *iconImageNamesArray = @[@"icon0.jpg",
//                                     @"icon1.jpg",
//                                     @"icon2.jpg",
//                                     @"icon3.jpg",
//                                     @"icon4.jpg",
//                                     ];
//    
//    NSArray *starImageArray      = @[@"5xing.jpg",
//                                     @"4xing.jpg",
//                                     @"3xing.jpg",
//                                     @"2xing.jpg",
//                                     @"1xing.jpg",
//                                     ];
//    
//    NSArray *namesArray = @[@"158****1856",
//                            @"风口上的猪",
//                            @"梅超风",
//                            @"我叫郭德纲",
//                            @"Hello Kitty"];
//    
//    NSArray *textArray = @[@"游泳。 最重要的是保持平和安详的心态。正所谓：心静自然凉。我经常用这一招，很有效果。",
//                           @"在饮食方面，一方面体弱人群要适量饮用淡盐水；另一方面，少吃油腻食品。",
//                           @"少吃多餐且清淡",
//                           @"合理的安排休息时间，每天保证8小时足够的睡眠以保持充分的体能，可有效达到防暑目的哦.",
//                           @"尽量不要上午10点至下午16点出门"
//                           ];
//    
//    
//    
//    for (int i = 0; i < iconImageNamesArray.count; i++) {
//        //        int iconRandomIndex = arc4random_uniform(5);
//        //        int nameRandomIndex = arc4random_uniform(5);
//        //        int contentRandomIndex = arc4random_uniform(5);
//        
//        DSUserModel *model = [DSUserModel new];
////        model.iconName = iconImageNamesArray[i];
////        model.name = namesArray[i];
////        model.content = textArray[i];
////        model.sayTime   = @"2017-7-31";
////        model.starName  = starImageArray[i];
//        
//        //        DSUserModel *model = [DSUserModel new];
//        //        model.iconName = iconImageNamesArray[i];
//        //        model.name = namesArray[i];
//        //        model.content = textArray[i];
//        
//        // 模拟“有或者无图片”
//        
//        [self.modelsArray addObject:model];
//    }
//    
//}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_modelsArray count];
    
//    return self.modelsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    DSActivityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[DSActivityDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStatic];
    }
    DSUserModel *model=(DSUserModel *)self.modelsArray[indexPath.row];
    cell.thumbOnclick=^(UIButton *btn){
        if (btn.selected) {
            [self addCommentariesSupportTypeid:[NSString stringWithFormat:@"%ld",model.CommentCode] andSupType:@"2"];
             [self.view showInfo:@"取消点赞!" autoHidden:YES];
        }else{
             [self.view showInfo:@"点赞成功!" autoHidden:YES];
            [self addCommentariesSupportTypeid:[NSString stringWithFormat:@"%ld",model.CommentCode] andSupType:@"2"];
        }
        btn.selected=!btn.selected;
    
    };
    if(self.modelsArray.count == 0)
    {
        
    }
    else
    {
        cell.model  = self.modelsArray[indexPath.row];
    }
    
    
    return cell;
}

#pragma mark-评论支持
-(void)addCommentariesSupportTypeid:(NSString *)SupTypeCodestr andSupType:(NSString *)SupTypestr{
    NSLog(@"添加评论借口参数：%ld==%@",(long)self.ActivityCode,self.userSayTextField.text);
    //1#文章;2#评论
    //    "Account_Id": "404832711505",
    //    "SupTypeCode": "100001",
    //    "SupType": "2"
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"SupTypeCode":SupTypeCodestr,
                             @"SupType":SupTypestr
                             };
    NSLog(@"添加评论借口参数：%@",mulDic);
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/AddActivitySupporInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"%@",dict);
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
//            [self.view showInfo:[dict objectForKey:@"ResultMessage"] autoHidden:YES interval:2];
            //            self.dic = [dict objectForKey:@"JsonData"];
            //        [self.MerchantDetailData addObjectsFromArray:arr];
            
            [self headerRereshing];
        }
        else
        {
            [self.view showInfo:@"评论支持添加失败" autoHidden:YES interval:2];
            //            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
        
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取失败" autoHidden:YES interval:2];
    }];
    
    
}

#pragma mark-添加评论借口
-(void)addCommentariesData{
    //    "JsonData": {"ActivityCode": 1001,"Account_Id": "404832711505",
    //        "Comment": "第一条测试"}
    
    NSLog(@"添加评论借口参数：%ld==%@",(long)self.ActivityCode,self.userSayTextField.text);
    //    ht://192.168.3.101:8090/api/Activity/AddActivityCommentInfo
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"ActivityCode":[NSString stringWithFormat:@"%ld",self.ActivityCode],
                             @"Comment":self.userSayTextField.text
                             };
    NSLog(@"添加评论借口参数：%@",mulDic);
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/AddActivityCommentInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"%@",dict);
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            [self.view showInfo:@"评论添加成功" autoHidden:YES interval:2];
            //            self.dic = [dict objectForKey:@"JsonData"];
            //        [self.MerchantDetailData addObjectsFromArray:arr];
            
            [self headerRereshing];
        }
        else
        {
            [self.view showInfo:@"评论添加失败" autoHidden:YES interval:2];
            //            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
        
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"评论添加失败" autoHidden:YES interval:2];
    }];
    
    
}
#pragma mark-监听键盘的done事件
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%@",textField.text);
    if(textField.text.length == 0)
    {
        
    }else
    {
        [self addCommentariesData];
    }
    
    textField.text = @"";
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSNotification * notice = [NSNotification notificationWithName:@"update" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}

#pragma mark - 无数据占位
//无数据占位
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"pinglun_kongbai"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"pinglun_kongbai"];
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
    NSString *text = @"暂无评论信息";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//设置占位图空白页的背景色( 图片优先级高于文字)


// 返回可以点击的按钮 上面带文字
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
    return [[NSAttributedString alloc] initWithString:@"afdfdgfd" attributes:attribute];
}


- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [UIImage imageNamed:@"pinglun_kongbai"];
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
{//偏移量计算逻辑 ->
//    当前屏幕一半的高度 = (获取屏幕的的高度->减去导航栏高度)/2
    //判断headerView高度是否超过屏幕的一半
    BOOL isHeader =  (CGRectGetHeight(self.tableView.tableHeaderView.frame)>(self.view.bounds.size.height-64)/2);
    //计算偏移量 (bgView 为空白占位图)
//    CGFloat height=CGRectGetHeight(self.tableView.tableHeaderView.frame.size.height-(self.view.bounds.size.height-64)/2));
//    return isHeader?self.tableView.tableHeaderView.frame.size.height-(self.view.bounds.size.height-64)/2:-64;
    return 450*Main_Screen_Height/667;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.userSayTextField resignFirstResponder];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    
    if(self.modelsArray.count == 0)
    {
        return 0;
    }
    else
    {
        return [self.tableView cellHeightForIndexPath:indexPath model:self.modelsArray[indexPath.row] keyPath:@"model" cellClass:[DSActivityDetailCell class] contentViewWidth:[self cellContentViewWith]];
    }
    
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
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
