//
//  CYDetailViewController.m
//  CarWashing
//
//  Created by apple on 2017/11/28.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYDetailViewController.h"
#import "UIView+SDAutoLayout.h"
#import "SDWeiXinPhotoContainerView.h"

#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIImageView+WebCache.h"
#import "DSActivityDetailCell.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "IQKeyboardManager.h"
#import "HTTPDefine.h"
#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "CarClubNews.h"
#import "UdStorage.h"
#import "MBProgressHUD.h"

@interface CYDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    CarClubNews *newsDetail;
    UILabel     * titleLabel;
    UIView      * whiteView;
    UIView      * backView;
    NSInteger    DeleteType;
    CGFloat     imageHeight;
    SDWeiXinPhotoContainerView *_picContainerView;
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
@property (nonatomic, strong)NSDictionary *dicData;

@property (nonatomic, strong) TPKeyboardAvoidingScrollView *scrollView;
@end

@implementation CYDetailViewController
- (void)drawNavigation {
    
    [self drawTitle:@"详情"];
    if ([self.deleteStr isEqualToString:@"是"]) {
        [self drawRightImageButton:[NSString stringWithFormat:@"dian-1"] action:@selector(deleteBtnClick)];
    }
    
    
}
- (void) drawContent
{
    self.contentView.top                 = 64;
    self.contentView.height              = self.view.height;
    self.contentView.backgroundColor     = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //是否显示键盘上的工具条
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    newsDetail = [[CarClubNews alloc]init];
    self.page = 0;
    
    [self createSubView];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
}
- (void) createSubView {
    
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height-Main_Screen_Height*60/667-64)];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    if ([self.showType isEqualToString:@"二手车"]) {
        self.tableView.top              = 50;
        self.tableView.height =Main_Screen_Height-Main_Screen_Height*60/667-64-50;
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, Main_Screen_Width, 50)];
        titleLabel.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:titleLabel];
    }else{
        self.tableView.top              = 0;
        Main_Screen_Height-Main_Screen_Height*60/667-64;
    }
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    
    
    [self.contentView addSubview:self.tableView];
    
    
    _modelsArray = [NSMutableArray new];
    self.page = 0 ;
    [self requestActivityDetail];
}
#pragma mark - - -- 创建头 --
- (void) createHeaderView {
    UIView *header = [UIView new];
    header.width = [UIScreen mainScreen].bounds.size.width;
    header.backgroundColor  = [UIColor whiteColor];
    self.tableView.tableHeaderView  = header;
    NSString *tempStringJack = [[NSString alloc]init];
    ////////////////////////////////////////////////////////////
    if ([self.showType isEqualToString:@"二手车"]) {
        tempStringJack = [NSString stringWithFormat:@"%@",newsDetail.CarComment];
        
    }else{
        tempStringJack = [NSString stringWithFormat:@"%@",newsDetail.Comment];
    }
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGSize size = [tempStringJack boundingRectWithSize:CGSizeMake(Main_Screen_Width-(20*Main_Screen_Height/667), 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
     if ([[self.dicData[@"JsonData"]allKeys]containsObject:@"IndexImg"] )
     {
         if (![self.dicData[@"JsonData"][@"IndexImg"]isEqualToString:@""]) {
             NSArray *urlArray = [newsDetail.IndexImg componentsSeparatedByString:@","];
             if (urlArray.count==1) {
                 imageHeight = 230;
                 
             }else if (urlArray.count>1&&urlArray.count<3){
                 imageHeight = 80;
             }else if (urlArray.count>=3&&urlArray.count<=6){
                 imageHeight = 160;
             }else if (urlArray.count>6){
                 imageHeight = 250;
             }
         }else{
             imageHeight = 0;
         }
     }
     else{
         if (![self.dicData[@"JsonData"][@"Img"]isEqualToString:@""]) {
             imageHeight = 230;
         }else{
             imageHeight = 0;
         }
     }
    
   header.height = (65+40+105+30)*Main_Screen_Height/667+imageHeight+size.height;
    #pragma mark ---用户信息相关 65
    //用户头像
    self.userImageView  = [UIImageView new];
    self.userImageView.layer.cornerRadius = 20*Main_Screen_Height/667;
    self.userImageView.layer.masksToBounds = YES;
    NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,newsDetail.FromusrImg];
    
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"huiyuantou"]];
    [header addSubview:self.userImageView];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(header.mas_left).mas_offset(10*Main_Screen_Height/667);
        make.top.mas_equalTo(header.mas_top).mas_offset(10*Main_Screen_Height/667);
        make.size.mas_equalTo(CGSizeMake(40*Main_Screen_Height/667, 40*Main_Screen_Height/667));
    }];
    
    //用户名
    self.userName                   = [UILabel new];
    self.userName.textColor                  = [UIColor blackColor];
    self.userName.font                       = [UIFont systemFontOfSize:17];
    self.userName.textColor                  = [UIColor colorFromHex:@"#3a3a3a"];
    self.userName.text                       = newsDetail.FromusrName;
    [header addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userImageView.mas_right).mas_offset(10*Main_Screen_Height/667);
        make.top.mas_equalTo(header.mas_top).mas_offset(10*Main_Screen_Height/667);
        make.size.mas_equalTo(CGSizeMake(150*Main_Screen_Height/667, 20*Main_Screen_Height/667));
    }];
    
    //浏览量
    self.seeNumber                  = [UILabel new];
    self.seeNumber.textColor                  = [UIColor blackColor];
    self.seeNumber.font                       = [UIFont systemFontOfSize:16];
    self.seeNumber.textColor                  = [UIColor colorFromHex:@"#868686"];
    self.seeNumber.text                       = [NSString stringWithFormat:@"%ld",newsDetail.Readcount];
    [header addSubview:self.seeNumber];
    [self.seeNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(header.mas_right);
        make.top.mas_equalTo(header.mas_top).mas_offset(25*Main_Screen_Height/667);
        make.size.mas_equalTo(CGSizeMake(40*Main_Screen_Height/667, 20*Main_Screen_Height/667));
    }];
    
   //浏览的死图片
    self.seeImageView  = [UIImageView new];
    self.seeImageView.image         = [UIImage imageNamed:@"yanjing.jpg"];
    [header addSubview:self.seeImageView];
    [self.seeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.seeNumber.mas_left).mas_offset(-5*Main_Screen_Height/667);
        make.top.mas_equalTo(header.mas_top).mas_offset(27*Main_Screen_Height/667);
        make.size.mas_equalTo(CGSizeMake(15*Main_Screen_Height/667, 15*Main_Screen_Height/667));
    }];
 
    //时间
    self.sayTime                 = [UILabel new];
    self.sayTime.textColor                = [UIColor colorFromHex:@"#999999"];
    self.sayTime.text                     = newsDetail.ActDate;
    self.sayTime.font                     = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    [header addSubview:self.sayTime];
    [self.sayTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userName.mas_left);
        make.top.mas_equalTo(self.userName.mas_bottom).mas_offset(5*Main_Screen_Height/667);
        make.size.mas_equalTo(CGSizeMake(150*Main_Screen_Height/667, 20*Main_Screen_Height/667));
    }];
#pragma mark ---//下面内容View
    UIView *backgroudView               = [UIView new];
    backgroudView.width                 = [UIScreen mainScreen].bounds.size.width;
    backgroudView.backgroundColor       = [UIColor colorFromHex:@"#f6f6f6"];
    [header addSubview:backgroudView];
    if ([[self.dicData[@"JsonData"]allKeys]containsObject:@"IndexImg"] ){
        
        if (![self.dicData[@"JsonData"][@"IndexImg"]isEqualToString:@""]) {
            NSArray *urlArray = [newsDetail.IndexImg componentsSeparatedByString:@","];
            if (urlArray.count==1) {
                [backgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(header.mas_left);
                    make.right.mas_equalTo(header.mas_right);
                    make.top.mas_equalTo(self.sayTime.mas_bottom).mas_offset(10*Main_Screen_Height/667);
                    make.height.mas_equalTo(((40+105)*Main_Screen_Height/667)+size.height+imageHeight);
                }];
            }else if (urlArray.count>1&&urlArray.count<3){
                [backgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(header.mas_left);
                    make.right.mas_equalTo(header.mas_right);
                    make.top.mas_equalTo(self.sayTime.mas_bottom).mas_offset(10*Main_Screen_Height/667);
                    make.height.mas_equalTo(((40+95)*Main_Screen_Height/667)+size.height+imageHeight);
                }];
            }else if (urlArray.count>=3&&urlArray.count<=6){
                [backgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(header.mas_left);
                    make.right.mas_equalTo(header.mas_right);
                    make.top.mas_equalTo(self.sayTime.mas_bottom).mas_offset(10*Main_Screen_Height/667);
                    make.height.mas_equalTo(((40+95)*Main_Screen_Height/667)+size.height+imageHeight);
                }];
            }else if (urlArray.count>6){
                [backgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(header.mas_left);
                    make.right.mas_equalTo(header.mas_right);
                    make.top.mas_equalTo(self.sayTime.mas_bottom).mas_offset(10*Main_Screen_Height/667);
                    make.height.mas_equalTo(((40+105)*Main_Screen_Height/667)+size.height+imageHeight);
                }];
            }
            
        }else{//没有图
            [backgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(header.mas_left);
                make.right.mas_equalTo(header.mas_right);
                make.top.mas_equalTo(self.sayTime.mas_bottom).mas_offset(10*Main_Screen_Height/667);
                make.height.mas_equalTo(((imageHeight+40+95)*Main_Screen_Height/667)+size.height);
            }];
            
        }
    }
    else{
        if (![self.dicData[@"JsonData"][@"Img"]isEqualToString:@""]) {
            [backgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(header.mas_left);
                make.right.mas_equalTo(header.mas_right);
                make.top.mas_equalTo(self.sayTime.mas_bottom).mas_offset(10*Main_Screen_Height/667);
                make.height.mas_equalTo(((40+105)*Main_Screen_Height/667)+size.height+imageHeight);
            }];
        }else{
            [backgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(header.mas_left);
                make.right.mas_equalTo(header.mas_right);
                make.top.mas_equalTo(self.sayTime.mas_bottom).mas_offset(10*Main_Screen_Height/667);
                make.height.mas_equalTo(((imageHeight+40+95)*Main_Screen_Height/667)+size.height);
            }];
        }
    }
    
    //文本标题
    self.textTitleLabel                 = [UILabel new];
    self.textTitleLabel.textColor                = [UIColor colorFromHex:@"#4a4a4a"];
    ////////////////////////////////////////////////////////////
    if ([self.showType isEqualToString:@"二手车"]) {
        self.textTitleLabel.text = [NSString stringWithFormat:@"%@年生产   行驶%@公里",self.carBrithYear,self.loopNum];
    }else{
        self.textTitleLabel.text                     = newsDetail.ActivityName;
    }
    self.textTitleLabel.font                     = [UIFont systemFontOfSize:16];
    [backgroudView addSubview:self.textTitleLabel];
    [self.textTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backgroudView.mas_left).mas_offset(10*Main_Screen_Height/667);
        make.top.mas_equalTo(backgroudView.mas_top).mas_offset(10*Main_Screen_Height/667);
        make.size.mas_equalTo(CGSizeMake(250*Main_Screen_Height/667, 30*Main_Screen_Height/667));
    }];
    //文本内容
    self.textContentLabel                 = [UILabel new];
    self.textContentLabel.textColor                = [UIColor colorFromHex:@"#999999"];
    self.textContentLabel.numberOfLines            = 0;
    self.textContentLabel.font = [UIFont systemFontOfSize:13];
    self.textContentLabel.textColor = [UIColor grayColor];
    self.textContentLabel.text = tempStringJack;
    ////////////////////////////////////////////////////////////
    [backgroudView addSubview:self.textContentLabel];
    [self.textContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textTitleLabel.mas_left);
        make.right.mas_equalTo(backgroudView.mas_right).mas_offset(-10*Main_Screen_Height/667);
        make.top.mas_equalTo(self.textTitleLabel.mas_bottom).mas_offset(0*Main_Screen_Height/667);
        make.height.mas_equalTo(size.height);
    }];
    //文本图片
    NSString * urlStr  = @"";
    if ([[self.dicData[@"JsonData"]allKeys]containsObject:@"IndexImg"] ) {//多张
        if (![self.dicData[@"JsonData"][@"IndexImg"]isEqualToString:@""]) {
            NSArray *urlArray = [newsDetail.IndexImg componentsSeparatedByString:@","];
            if (urlArray.count==1) {
                urlStr =[NSString stringWithFormat:@"%@",urlArray[0]];
                //图片
                self.textImageView  = [UIImageView new];
                self.textImageView.contentMode = UIViewContentModeScaleAspectFill;
                self.textImageView.clipsToBounds = YES;
                [self.textImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,urlStr]]];
                [backgroudView addSubview:self.textImageView ];
                [self.textImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.textContentLabel.mas_left);
                    make.right.mas_equalTo(self.textContentLabel.mas_right);
                    make.top.mas_equalTo(self.textContentLabel.mas_bottom).mas_offset(10*Main_Screen_Height/667);
                    make.height.mas_equalTo(imageHeight);
                }];
                //赞button
                self.goodButton  = [UIButton new];
                if (newsDetail.IsGive ==1) {//点过赞
                    [self.goodButton  setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
                    self.goodButton.selected = YES;
                }else{//未点赞
                    [self.goodButton  setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
                    self.goodButton.selected = NO;
                }
                self.goodButton .backgroundColor  = [UIColor whiteColor];
                [self.goodButton  addTarget:self action:@selector(goodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                self.goodButton.layer.cornerRadius = 25*Main_Screen_Height/667;
                self.goodButton.layer.masksToBounds = YES;
                [backgroudView addSubview:self.goodButton ];
                [self.goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(self.textImageView.mas_centerX);
                make.top.mas_equalTo(self.textImageView .mas_bottom).mas_offset(10*Main_Screen_Height/667);
                    make.size.mas_equalTo(CGSizeMake(50*Main_Screen_Height/667, 50*Main_Screen_Height/667));
                }];
                //多少人点赞
                self.goodNumberLabel                = [UILabel new];
                self.goodNumberLabel.textColor                = [UIColor colorFromHex:@"#999999"];
                self.goodNumberLabel.font                     = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
                self.goodNumberLabel.textAlignment            = NSTextAlignmentCenter;
                self.goodNumberLabel.text=[NSString stringWithFormat:@"共有%ld人点过赞",newsDetail.GiveCount];
                [backgroudView addSubview:self.goodNumberLabel];
                [self.goodNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(self.textImageView.mas_centerX);
                make.top.mas_equalTo(self.goodButton .mas_bottom).mas_offset(10*Main_Screen_Height/667);
                    make.size.mas_equalTo(CGSizeMake(150*Main_Screen_Height/667, 20*Main_Screen_Height/667));
                }];
            }else if (urlArray.count>1&&urlArray.count<3){//2张图
                
                NSMutableArray * containArr = [NSMutableArray array];
                for (int i=0; i<urlArray.count; i++) {
                    NSString * str=[NSString stringWithFormat:@"%@%@",kHTTPImg,urlArray[i]];             [containArr addObject:str];
                }
                _picContainerView = [SDWeiXinPhotoContainerView new];
                 _picContainerView.picPathStringsArray = containArr;
                [backgroudView addSubview:_picContainerView];
                [_picContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.textContentLabel .mas_bottom).mas_offset(10*Main_Screen_Height/667);
                    make.left.mas_equalTo(self.textContentLabel.mas_left);
                    make.right.mas_equalTo(self.textContentLabel.mas_right);
                  make.height.mas_equalTo(imageHeight);
                }];
                
                //赞button
                self.goodButton  = [UIButton new];
                if (newsDetail.IsGive ==1) {//点过赞
                    [self.goodButton  setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
                    self.goodButton.selected = YES;
                }else{//未点赞
                    [self.goodButton  setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
                    self.goodButton.selected = NO;
                }
                self.goodButton .backgroundColor  = [UIColor whiteColor];
                [self.goodButton  addTarget:self action:@selector(goodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                self.goodButton.layer.cornerRadius = 25*Main_Screen_Height/667;
                self.goodButton.layer.masksToBounds = YES;
                [backgroudView addSubview:self.goodButton ];
                [self.goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(_picContainerView.mas_centerX);
                make.top.mas_equalTo(_picContainerView .mas_bottom);
                    make.size.mas_equalTo(CGSizeMake(50*Main_Screen_Height/667, 50*Main_Screen_Height/667));
                }];
                //多少人点赞
                self.goodNumberLabel                = [UILabel new];
                self.goodNumberLabel.textColor                = [UIColor colorFromHex:@"#999999"];
                self.goodNumberLabel.font                     = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
                self.goodNumberLabel.textAlignment            = NSTextAlignmentCenter;
                self.goodNumberLabel.text=[NSString stringWithFormat:@"共有%ld人点过赞",newsDetail.GiveCount];
                [backgroudView addSubview:self.goodNumberLabel];
                [self.goodNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(_picContainerView.mas_centerX);
                    make.top.mas_equalTo(self.goodButton .mas_bottom).mas_offset(10*Main_Screen_Height/667);
                    make.size.mas_equalTo(CGSizeMake(150*Main_Screen_Height/667, 20*Main_Screen_Height/667));
                }];
            }else if(urlArray.count>=3&&urlArray.count<=6){//多张图
                
                NSMutableArray * containArr = [NSMutableArray array];
                for (int i=0; i<urlArray.count; i++) {
                    NSString * str=[NSString stringWithFormat:@"%@%@",kHTTPImg,urlArray[i]];             [containArr addObject:str];
                }
                _picContainerView = [SDWeiXinPhotoContainerView new];
                _picContainerView.picPathStringsArray = containArr;
                [backgroudView addSubview:_picContainerView];
                [_picContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.textContentLabel .mas_bottom).mas_offset(10*Main_Screen_Height/667);
                    make.left.mas_equalTo(self.textContentLabel.mas_left);
                    make.right.mas_equalTo(self.textContentLabel.mas_right);
                    make.height.mas_equalTo(imageHeight);
                }];
                
                //赞button
                self.goodButton  = [UIButton new];
                if (newsDetail.IsGive ==1) {//点过赞
                    [self.goodButton  setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
                    self.goodButton.selected = YES;
                }else{//未点赞
                    [self.goodButton  setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
                    self.goodButton.selected = NO;
                }
                self.goodButton .backgroundColor  = [UIColor whiteColor];
                [self.goodButton  addTarget:self action:@selector(goodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                self.goodButton.layer.cornerRadius = 25*Main_Screen_Height/667;
                self.goodButton.layer.masksToBounds = YES;
                [backgroudView addSubview:self.goodButton ];
                [self.goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(_picContainerView.mas_centerX);
                    make.top.mas_equalTo(_picContainerView .mas_bottom);
                    make.size.mas_equalTo(CGSizeMake(50*Main_Screen_Height/667, 50*Main_Screen_Height/667));
                }];
                //多少人点赞
                self.goodNumberLabel                = [UILabel new];
                self.goodNumberLabel.textColor                = [UIColor colorFromHex:@"#999999"];
                self.goodNumberLabel.font                     = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
                self.goodNumberLabel.textAlignment            = NSTextAlignmentCenter;
                self.goodNumberLabel.text=[NSString stringWithFormat:@"共有%ld人点过赞",newsDetail.GiveCount];
                [backgroudView addSubview:self.goodNumberLabel];
                [self.goodNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(_picContainerView.mas_centerX);
                    make.top.mas_equalTo(self.goodButton .mas_bottom).mas_offset(10*Main_Screen_Height/667);
                    make.size.mas_equalTo(CGSizeMake(150*Main_Screen_Height/667, 20*Main_Screen_Height/667));
                }];
            }else {//大于6张多张图
                
                NSMutableArray * containArr = [NSMutableArray array];
                for (int i=0; i<urlArray.count; i++) {
                    NSString * str=[NSString stringWithFormat:@"%@%@",kHTTPImg,urlArray[i]];             [containArr addObject:str];
                }
                _picContainerView = [SDWeiXinPhotoContainerView new];
                _picContainerView.picPathStringsArray = containArr;
                [backgroudView addSubview:_picContainerView];
                [_picContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.textContentLabel .mas_bottom).mas_offset(10*Main_Screen_Height/667);
                    make.left.mas_equalTo(self.textContentLabel.mas_left);
                    make.right.mas_equalTo(self.textContentLabel.mas_right);
                    make.height.mas_equalTo(imageHeight);
                }];
                
                //赞button
                self.goodButton  = [UIButton new];
                if (newsDetail.IsGive ==1) {//点过赞
                    [self.goodButton  setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
                    self.goodButton.selected = YES;
                }else{//未点赞
                    [self.goodButton  setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
                    self.goodButton.selected = NO;
                }
                self.goodButton .backgroundColor  = [UIColor whiteColor];
                [self.goodButton  addTarget:self action:@selector(goodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                self.goodButton.layer.cornerRadius = 25*Main_Screen_Height/667;
                self.goodButton.layer.masksToBounds = YES;
                [backgroudView addSubview:self.goodButton ];
                [self.goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(_picContainerView.mas_centerX);
                    make.top.mas_equalTo(_picContainerView .mas_bottom).mas_offset(10*Main_Screen_Height/667);
                    make.size.mas_equalTo(CGSizeMake(50*Main_Screen_Height/667, 50*Main_Screen_Height/667));
                }];
                //多少人点赞
                self.goodNumberLabel                = [UILabel new];
                self.goodNumberLabel.textColor                = [UIColor colorFromHex:@"#999999"];
                self.goodNumberLabel.font                     = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
                self.goodNumberLabel.textAlignment            = NSTextAlignmentCenter;
                self.goodNumberLabel.text=[NSString stringWithFormat:@"共有%ld人点过赞",newsDetail.GiveCount];
                [backgroudView addSubview:self.goodNumberLabel];
                [self.goodNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(_picContainerView.mas_centerX);
                    make.top.mas_equalTo(self.goodButton .mas_bottom).mas_offset(10*Main_Screen_Height/667);
                    make.size.mas_equalTo(CGSizeMake(150*Main_Screen_Height/667, 20*Main_Screen_Height/667));
                }];
            }
           
        }else{//没有图
            //赞button
            self.goodButton  = [UIButton new];
            if (newsDetail.IsGive ==1) {//点过赞
                [self.goodButton  setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
                self.goodButton.selected = YES;
            }else{//未点赞
                [self.goodButton  setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
                self.goodButton.selected = NO;
            }
            self.goodButton .backgroundColor  = [UIColor whiteColor];
            [self.goodButton  addTarget:self action:@selector(goodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            self.goodButton.layer.cornerRadius = 25*Main_Screen_Height/667;
            self.goodButton.layer.masksToBounds = YES;
            [backgroudView addSubview:self.goodButton ];
            [self.goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.textContentLabel.mas_centerX);
                make.top.mas_equalTo(self.textContentLabel .mas_bottom).mas_offset(10*Main_Screen_Height/667);
                make.size.mas_equalTo(CGSizeMake(50*Main_Screen_Height/667, 50*Main_Screen_Height/667));
            }];
            //多少人点赞
            self.goodNumberLabel                = [UILabel new];
            self.goodNumberLabel.textColor                = [UIColor colorFromHex:@"#999999"];
            self.goodNumberLabel.font                     = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
            self.goodNumberLabel.textAlignment            = NSTextAlignmentCenter;
            self.goodNumberLabel.text=[NSString stringWithFormat:@"共有%ld人点过赞",newsDetail.GiveCount];
            [backgroudView addSubview:self.goodNumberLabel];
            [self.goodNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.textContentLabel.mas_centerX);
            make.top.mas_equalTo(self.goodButton .mas_bottom).mas_offset(10*Main_Screen_Height/667);
            make.size.mas_equalTo(CGSizeMake(150*Main_Screen_Height/667, 20*Main_Screen_Height/667));
            }];
        }
    }else{
        
        if (![self.dicData[@"JsonData"][@"Img"]isEqualToString:@""]) {
            //图片
            self.textImageView  = [UIImageView new];
            self.textImageView.contentMode = UIViewContentModeScaleAspectFill;
            self.textImageView.clipsToBounds = YES;
            [self.textImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHTTPImg,newsDetail.Img]]];
            [backgroudView addSubview:self.textImageView ];
            [self.textImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.textContentLabel.mas_left);
                make.right.mas_equalTo(self.textContentLabel.mas_right);
                make.top.mas_equalTo(self.textContentLabel.mas_bottom).mas_offset(10*Main_Screen_Height/667);
                make.height.mas_equalTo(imageHeight);
            }];
            //赞button
            self.goodButton  = [UIButton new];
            if (newsDetail.IsGive ==1) {//点过赞
                [self.goodButton  setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
                self.goodButton.selected = YES;
            }else{//未点赞
                [self.goodButton  setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
                self.goodButton.selected = NO;
            }
            self.goodButton .backgroundColor  = [UIColor whiteColor];
            [self.goodButton  addTarget:self action:@selector(goodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            self.goodButton.layer.cornerRadius = 25*Main_Screen_Height/667;
            self.goodButton.layer.masksToBounds = YES;
            [backgroudView addSubview:self.goodButton ];
            [self.goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.textImageView.mas_centerX);
                make.top.mas_equalTo(self.textImageView .mas_bottom).mas_offset(10*Main_Screen_Height/667);
                make.size.mas_equalTo(CGSizeMake(50*Main_Screen_Height/667, 50*Main_Screen_Height/667));
            }];
            //多少人点赞
            self.goodNumberLabel                = [UILabel new];
            self.goodNumberLabel.textColor                = [UIColor colorFromHex:@"#999999"];
            self.goodNumberLabel.font                     = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
            self.goodNumberLabel.textAlignment            = NSTextAlignmentCenter;
            self.goodNumberLabel.text=[NSString stringWithFormat:@"共有%ld人点过赞",newsDetail.GiveCount];
            [backgroudView addSubview:self.goodNumberLabel];
            [self.goodNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.textImageView.mas_centerX);
                make.top.mas_equalTo(self.goodButton .mas_bottom).mas_offset(10*Main_Screen_Height/667);
                make.size.mas_equalTo(CGSizeMake(150*Main_Screen_Height/667, 20*Main_Screen_Height/667));
            }];
        }else{
            //赞button
            self.goodButton  = [UIButton new];
            if (newsDetail.IsGive ==1) {//点过赞
                [self.goodButton  setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
                self.goodButton.selected = YES;
            }else{//未点赞
                [self.goodButton  setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
                self.goodButton.selected = NO;
            }
            self.goodButton .backgroundColor  = [UIColor whiteColor];
            [self.goodButton  addTarget:self action:@selector(goodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            self.goodButton.layer.cornerRadius = 25*Main_Screen_Height/667;
            self.goodButton.layer.masksToBounds = YES;
            [backgroudView addSubview:self.goodButton ];
            [self.goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.textContentLabel.mas_centerX);
                make.top.mas_equalTo(self.textContentLabel .mas_bottom).mas_offset(10*Main_Screen_Height/667);
                make.size.mas_equalTo(CGSizeMake(50*Main_Screen_Height/667, 50*Main_Screen_Height/667));
            }];
            //多少人点赞
            self.goodNumberLabel                = [UILabel new];
            self.goodNumberLabel.textColor                = [UIColor colorFromHex:@"#999999"];
            self.goodNumberLabel.font                     = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
            self.goodNumberLabel.textAlignment            = NSTextAlignmentCenter;
            self.goodNumberLabel.text=[NSString stringWithFormat:@"共有%ld人点过赞",newsDetail.GiveCount];
            [backgroudView addSubview:self.goodNumberLabel];
            [self.goodNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.textContentLabel.mas_centerX);
                make.top.mas_equalTo(self.goodButton .mas_bottom).mas_offset(10*Main_Screen_Height/667);
                make.size.mas_equalTo(CGSizeMake(150*Main_Screen_Height/667, 20*Main_Screen_Height/667));
            }];
           
        }
        
    }
    
    
   
    
    
    
    
    
    self.sayNumberLab                   = [UILabel new];
    self.sayNumberLab .textColor                  = [UIColor blackColor];
    //    sayNumberLab.backgroundColor       = [UIColor greenColor];
    self.sayNumberLab .font                       = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
    self.sayNumberLab .text                       = [NSString stringWithFormat:@"评论（%ld）",newsDetail.CommentCount];
    [header addSubview:self.sayNumberLab ];
    [self.sayNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backgroudView.mas_left).mas_offset(10*Main_Screen_Height/667);
        make.top.mas_equalTo(backgroudView .mas_bottom);
        make.size.mas_equalTo(CGSizeMake(150*Main_Screen_Height/667, 30*Main_Screen_Height/667));
    }];
    


    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [header addSubview:bottomLine];

    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backgroudView.mas_left);
        make.right.mas_equalTo(backgroudView.mas_right);
        make.top.mas_equalTo(self.sayNumberLab .mas_bottom).mas_offset(-1);
        make.height.mas_equalTo(1);
    }];


    if(self.CommentCount == 0)
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
        self.tableView.tableFooterView.hidden=NO;
    }else{
        self.tableView.tableFooterView.hidden=YES;
    }

//
    self.downView = [UIView new];
    self.downView .frame = CGRectMake(0, Main_Screen_Height -
                                      Main_Screen_Height*60/667-64, Main_Screen_Width, Main_Screen_Height*60/667);
    self.downView .backgroundColor  = [UIColor whiteColor];

    self.downView.layer.borderWidth=0.6;
    self.downView.layer.borderColor=[UIColor grayColor].CGColor;
    self.userSayTextField                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-150*Main_Screen_Width/375, Main_Screen_Height*40/667)];
    self.userSayTextField.placeholder    = @"我来说两句...";
    self.userSayTextField.delegate       = self;
    self.userSayTextField.returnKeyType  = UIReturnKeyDone;
    self.userSayTextField.textAlignment  = NSTextAlignmentLeft;
    self.userSayTextField.font           = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    self.userSayTextField.backgroundColor= [UIColor whiteColor];
    self.userSayTextField.layer.cornerRadius    = Main_Screen_Height*20/667;
    self.userSayTextField.layer.borderWidth     = 1;
    self.userSayTextField.layer.borderColor     = [UIColor colorFromHex:@"#b4b4b4"].CGColor;
    self.userSayTextField.left           = Main_Screen_Width*10/375 ;
    self.userSayTextField.top            = Main_Screen_Height*10/667;
//    [self.userSayTextField addTarget:self action:@selector(userSayTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.downView  addSubview:self.userSayTextField];

    UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(self.userSayTextField.frame.origin.x,self.userSayTextField.frame.origin.y,15.0, self.userSayTextField.frame.size.height)];
    self.userSayTextField.leftView = blankView;
    self.userSayTextField.leftViewMode =UITextFieldViewModeAlways;



    UIButton    *sayButton = [UIButton new];
    [sayButton setImage:[UIImage imageNamed:@"huodongxiangqingxiaoxi"] forState:UIControlStateNormal];
    //    sayButton.backgroundColor  = [UIColor whiteColor];
//    [sayButton addTarget:self action:@selector(sayButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    self.sayButton         = sayButton;
    [self.downView  addSubview:sayButton];

    sayButton.sd_layout
    .leftSpaceToView(self.userSayTextField, 15*Main_Screen_Height/667)
    .centerYEqualToView(self.userSayTextField)
    .heightIs(20*Main_Screen_Height/667)
    .widthIs(20*Main_Screen_Height/667);


    UILabel *sayShowLabel                   = [UILabel new];
    sayShowLabel.textColor                  = [UIColor colorFromHex:@"#999999"];
    sayShowLabel.font                       = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    sayShowLabel.text                       = @"369";
    //    sayShowLabel.backgroundColor=[UIColor whiteColor];
    self.sayShowLabel                       = sayShowLabel;
    [self.downView  addSubview:sayShowLabel];

    sayShowLabel.sd_layout
    .leftSpaceToView(sayButton, 5*Main_Screen_Height/667)
    .centerYEqualToView(self.userSayTextField)
    .widthIs(25*Main_Screen_Height/667)
    .heightIs(20*Main_Screen_Height/667);

    UIButton    *downGoodButton = [UIButton new];
    [downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
    [downGoodButton addTarget:self action:@selector(downGoodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.downGoodButton         = downGoodButton;
    [self.downView  addSubview:downGoodButton];

    downGoodButton.sd_layout
    .leftSpaceToView(self.sayShowLabel, 10*Main_Screen_Height/667)
    .centerYEqualToView(self.userSayTextField)
    .heightIs(20*Main_Screen_Height/667)
    .widthIs(20*Main_Screen_Height/667);


    UILabel *goodShowLabel                   = [UILabel new];
    goodShowLabel.textColor                  = [UIColor colorFromHex:@"#999999"];
    goodShowLabel.font                       = [UIFont systemFontOfSize:12*Main_Screen_Height/667];
    //    goodShowLabel.text                       = @"369";
    //    goodShowLabel.backgroundColor=[UIColor whiteColor];
    self.goodShowLabel                       = goodShowLabel;
    [self.downView  addSubview:goodShowLabel];

    goodShowLabel.sd_layout
    .leftSpaceToView(downGoodButton, 5*Main_Screen_Height/667)
    .topSpaceToView(self.downView , 20*Main_Screen_Height/667)
    .widthIs(25*Main_Screen_Height/667)
    .heightIs(20*Main_Screen_Height/667);

    NSLog(@"测试点赞数量---------%ld",self.GiveCount);
    self.goodNumberLabel.text = [NSString stringWithFormat:@"共有%ld人点赞过",self.GiveCount];

    self.sayNumberLab.text = [NSString stringWithFormat:@"评论(%ld)",self.CommentCount];
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

    if(self.CommentCount > 99)
    {
        self.sayShowLabel.text = @"99+";
    }
    else
    {
        self.sayShowLabel.text = [NSString stringWithFormat:@"%ld",self.CommentCount];
    }

    if(self.GiveCount>99)
    {
        self.goodShowLabel.text = @"99+";
    }
    else
    {
        //        self.goodShowLabel.text = [NSString stringWithFormat:@"%ld",self.GiveCount<0?0:self.GiveCount];
        self.goodShowLabel.text = [NSString stringWithFormat:@"%ld",self.GiveCount];
    }



    [self.downView  layoutSubviews];

    [self.contentView addSubview:self.downView ];

    //    [self.scrollView addSubview:self.contentView];
    //    [self.view addSubview:self.scrollView];
    
}
#pragma mark---数据请求
-(void)requestActivityDetail
{
    NSDictionary *mulDic ;
    NSString * urlStr =@"";
    if ([self.showType isEqualToString:@"二手车"])
    {
        mulDic = @{
                   @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                   @"CarCode":[NSString stringWithFormat:@"%ld",self.CarCode]
                   };
        urlStr = @"Activity/SecondHandCarDetails";
    }else if([self.showType isEqualToString:@"高兴"]){
        if ([self.comeTypeString isEqualToString:@"1"]) {
            //车友提问
            mulDic = @{
                       @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                       @"ActivityCode":[NSString stringWithFormat:@"%ld",self.ActivityCode],
                       @"ActivityType":@(2)
                       };
        }else if ([self.comeTypeString isEqualToString:@"2"]){
            mulDic = @{
                       @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                       @"ActivityCode":[NSString stringWithFormat:@"%ld",self.ActivityCode],
                       @"ActivityType":@(3)
                       };
        }
        urlStr = @"Activity/GetActivityInfo";
    }else{
        //资讯
        mulDic = @{
                   @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                   @"ActivityCode":[NSString stringWithFormat:@"%ld",self.ActivityCode],
                   @"ActivityType":@(1)
                   };
        urlStr = @"Activity/GetActivityInfo";
    }
    
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@%@",Khttp,urlStr] success:^(NSDictionary *dict, BOOL success) {
        self.dicData = dict;
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            //            NSLog(@"查看详情数据　%@",dict);
            NSLog(@"详情数据%@",dict[@"JsonData"]);
            //是什么车
            titleLabel.text=[NSString stringWithFormat:@"%@%@",dict[@"JsonData"][@"CarBrand"],dict[@"JsonData"][@"CarType"]];
            
            NSDictionary *dic = [dict objectForKey:@"JsonData"];
            [newsDetail setValuesForKeysWithDictionary:dic];
            self.GiveCount = newsDetail.GiveCount;
            NSArray *arr = [NSArray array];
            arr = [dic objectForKey:@"actModelList"];
            
            //下面是薛注释的
            //            for(NSDictionary *dic in arr)
            
            if (arr.count!=0) {
                _modelsArray = (NSMutableArray*)[DSUserModel mj_objectArrayWithKeyValuesArray:dic[@"actModelList"]];
                self.CommentCount=_modelsArray.count;
                
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
            //                NSLog(@"---------------%@",dic);
            //                DSUserModel *model = [DSUserModel new];
            //                [model setValuesForKeysWithDictionary:dic];
            //                [_modelsArray addObject:model];
            //            }
            //            self.CommentCount=_modelsArray.count;
            
            [self createHeaderView];
            self.userImageView.backgroundColor=[UIColor clearColor];
            [_tableView reloadData];
//            [self.tableView.mj_header endRefreshing];
        }
        else
        {
            [self.view showInfo:@"获取数据失败" autoHidden:YES interval:2];
            [self.tableView.mj_header endRefreshing];
        }
        
    } fail:^(NSError *error) {
        NSLog(@"AF失败%@",error);
        [self.view showInfo:@"获取数据失败" autoHidden:YES interval:2];
        [self.tableView.mj_header endRefreshing];
    }];
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.CommentCount;
    
    
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
    if(_modelsArray.count == 0)
    {
        
    }
    else
    {
        cell.model  = _modelsArray[indexPath.row];
    }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    
    if(_modelsArray.count == 0)
    {
        return 0;
    }
    else
    {
        return [self.tableView cellHeightForIndexPath:indexPath model:_modelsArray[indexPath.row] keyPath:@"model" cellClass:[DSActivityDetailCell class] contentViewWidth:[self cellContentViewWith]]+23*Main_Screen_Height/667;
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

#pragma mark-我要点赞&取消点赞
- (void) goodButtonClick:(UIButton *)sender {
    
    if (sender.selected == NO) {
        
        NSDictionary *mulDic;
        if ([self.showType isEqualToString:@"二手车"]) {
            mulDic = @{
                       @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                       @"SupTypeCode":@(self.CarCode),
                       @"SupType":@(3)
                       };
        }else{
            mulDic = @{
                       @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                       @"SupTypeCode":@(self.ActivityCode),
                       @"SupType":@(1)
                       };
        }
        
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        NSLog(@"点赞参数%@",mulDic);
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/AddActivitySupporInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
            NSLog(@"点赞-%@",dict);
            NSLog(@"点赞-%@",dict[@"ResultMessage"]);
            
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                
                NSNotification * notice = [NSNotification notificationWithName:@"update" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                
                [self.view showInfo:@"点赞成功" autoHidden:YES interval:1];
                
                [self.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
                self.goodNumberLabel.text                     = [NSString stringWithFormat:@"共有%ld人点赞过",self.GiveCount + 1];
                self.GiveCount++;
                
                if(self.GiveCount>99)
                {
                    self.goodShowLabel.text = @"99+";
                }else
                {
                    self.goodShowLabel.text = [NSString stringWithFormat:@"%ld",self.GiveCount];
                }
                
                
                [self.downGoodButton setImage:[UIImage imageNamed:@"xiaohongshou"] forState:UIControlStateNormal];
                self.downGoodButton.selected = YES;
                
                
                
                
            }
            else
            {
                //参数失败
                [self.view showInfo:@"点赞失败" autoHidden:YES interval:1];
                [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
                self.downGoodButton.selected = NO;
            }
            
        } fail:^(NSError *error) {
            [self.view showInfo:@"点赞失败" autoHidden:YES interval:1];
            [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
            self.downGoodButton.selected = NO;
        }];
        
        
        
    }else {
        //取消点赞
        
        //        NSDictionary *mulDic = @{
        //                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
        //                                 @"SupTypeCode":[NSString stringWithFormat:@"%ld",self.ActivityCode],
        //                                 @"SupType": @1
        //                                 };
        NSDictionary *mulDic;
        if ([self.showType isEqualToString:@"二手车"]) {
            mulDic = @{
                       @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                       @"SupTypeCode":@(self.CarCode),
                       @"SupType":@(3)
                       };
        }else{
            mulDic = @{
                       @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                       @"SupTypeCode":@(self.ActivityCode),
                       @"SupType":@(1)
                       };
        }
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/AddActivitySupporInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
            
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                
                NSNotification * notice = [NSNotification notificationWithName:@"update" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                
                [self.view showInfo:@"取消点赞成功" autoHidden:YES interval:1];
                
                [self.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
                self.goodNumberLabel.text                     = [NSString stringWithFormat:@"共有%ld人点赞过",self.GiveCount-1<0?0:self.GiveCount-1];
                self.GiveCount--;
                
                if(self.GiveCount>99)
                {
                    self.goodShowLabel.text = @"99+";
                }else
                {
                    self.goodShowLabel.text = [NSString stringWithFormat:@"%ld",self.GiveCount];
                }
                
                
                [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
                self.downGoodButton.selected = NO;
            }
            else
                //参数问题
            {
                [self.view showInfo:@"取消点赞失败" autoHidden:YES interval:1];
                [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
                self.downGoodButton.selected = YES;
            }
            
        } fail:^(NSError *error) {
            //网络问题
            [self.view showInfo:@"取消点赞失败" autoHidden:YES interval:1];
            [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
            self.downGoodButton.selected = YES;
        }];
        
        
        
        
        
    }
    
    sender.selected = !sender.selected;
}
#pragma mark-底部点赞
- (void) downGoodButtonClick:(UIButton *)sender {
    
    if (sender.selected == NO) {
        
        
        //        NSDictionary *mulDic = @{
        //                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
        //                                 @"SupTypeCode":[NSString stringWithFormat:@"%ld",self.ActivityCode],
        //                                 @"SupType": @1
        //                                 };
        NSDictionary *mulDic;
        if ([self.showType isEqualToString:@"二手车"]) {
            mulDic = @{
                       @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                       @"SupTypeCode":@(self.CarCode),
                       @"SupType":@(3)
                       };
        }else{
            mulDic = @{
                       @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                       @"SupTypeCode":@(self.ActivityCode),
                       @"SupType":@(1)
                       };
        }
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/AddActivitySupporInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
            
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                
                NSNotification * notice = [NSNotification notificationWithName:@"update" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                
                [self.view showInfo:@"点赞成功" autoHidden:YES interval:1];
                
                [self.downGoodButton setImage:[UIImage imageNamed:@"xiaohongshou"] forState:UIControlStateNormal];
                //                self.goodShowLabel.text                     = [NSString stringWithFormat:@"%ld",newsDetail.GiveCount+1];
                
                if(self.GiveCount>99)
                {
                    self.goodShowLabel.text = @"99+";
                }else
                {
                    self.goodShowLabel.text = [NSString stringWithFormat:@"%ld",self.GiveCount+1];
                }
                
                self.GiveCount++;
                self.goodNumberLabel.text = [NSString stringWithFormat:@"共有%ld人点赞过",self.GiveCount];
                [self.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
                self.goodButton.selected = YES;
            }
            else
            {
                [self.view showInfo:@"点赞失败" autoHidden:YES interval:1];
                [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
                self.downGoodButton.selected = NO;
            }
            
        } fail:^(NSError *error) {
            [self.view showInfo:@"点赞失败" autoHidden:YES interval:1];
            [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
            self.downGoodButton.selected = NO;
        }];
        
        
        
    }else {
        
        
        //        NSDictionary *mulDic = @{
        //                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
        //                                 @"SupTypeCode":[NSString stringWithFormat:@"%ld",self.ActivityCode],
        //                                 @"SupType": @1
        //                                 };
        NSDictionary *mulDic;
        if ([self.showType isEqualToString:@"二手车"]) {
            mulDic = @{
                       @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                       @"SupTypeCode":@(self.CarCode),
                       @"SupType":@(3)
                       };
        }else{
            mulDic = @{
                       @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                       @"SupTypeCode":@(self.ActivityCode),
                       @"SupType":@(1)
                       };
        }
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/AddActivitySupporInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
            
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                
                NSNotification * notice = [NSNotification notificationWithName:@"update" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                
                [self.view showInfo:@"取消点赞成功" autoHidden:YES interval:2];
                
                if(self.GiveCount>99)
                {
                    self.goodShowLabel.text = @"99+";
                }else{
                    self.goodShowLabel.text = [NSString stringWithFormat:@"%ld",self.GiveCount-1<0?0:self.GiveCount-1];
                }
                
                
                [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
                
                self.GiveCount--;
                [self.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
                self.goodNumberLabel.text                     = [NSString stringWithFormat:@"共有%ld人点赞过",self.GiveCount<0?0:self.GiveCount];
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
#pragma mark-添加评论借口
-(void)addCommentariesData{
    //    "JsonData": {"ActivityCode": 1001,"Account_Id": "404832711505",
    //        "Comment": "第一条测试"}
    
    //    NSLog(@"添加评论借口参数：%ld==%@",(long)self.ActivityCode,self.userSayTextField.text);
    //    ht://192.168.3.101:8090/api/Activity/AddActivityCommentInfo
    NSDictionary *mulDic;
    if ([self.showType isEqualToString:@"二手车"]) {
        mulDic = @{
                   @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                   @"ActivityCode":[NSString stringWithFormat:@"%ld",self.CarCode],
                   @"Comment":self.userSayTextField.text,
                   @"ActivityCommentType":@(2)
                   };
    }else{
        mulDic = @{
                   @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                   @"ActivityCode":[NSString stringWithFormat:@"%ld",self.ActivityCode],
                   @"Comment":self.userSayTextField.text,
                   @"ActivityCommentType":@(1)
                   };
    }
    
    NSLog(@"添加评论借口参数：%@",mulDic);
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/AddActivityCommentInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"%@",dict);
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            NSNotification * notice = [NSNotification notificationWithName:@"update" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            [self.view showInfo:@"评论添加成功" autoHidden:YES interval:2];
            if ([self.showType isEqualToString:@"二手车"])
            {
                self.showType = @"二手车";
            }
            //            self.dic = [dict objectForKey:@"JsonData"];
            //        [self.MerchantDetailData addObjectsFromArray:arr];
            
            
            
            
            [self requestActivityDetail];
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
            
            [self requestActivityDetail];
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
#pragma mark-监听键盘的done事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%@",textField.text);
    if(textField.text.length == 0)
    {
        [self.userSayTextField resignFirstResponder];
    }else {
        [self addCommentariesData];
    }
    textField.text = @"";
}
#pragma mark----删除相关
-(void)deleteBtnClick
{
    backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    backView.backgroundColor=[UIColor  blackColor];
    backView.userInteractionEnabled = YES;
    backView.alpha = 0.5;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.view addSubview:backView];
    [backView addGestureRecognizer:tap];
    whiteView=[[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 50)];
    whiteView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:whiteView];
    UITapGestureRecognizer * delatetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(delatetapClick)];
    [whiteView addGestureRecognizer:delatetap];
    [UIView animateWithDuration:0.3 animations:^{
        whiteView.center =CGPointMake(Main_Screen_Width/2, Main_Screen_Height-25);
    }];
    UIImageView * deleteImageView =[[UIImageView alloc]init];
    deleteImageView.image=[UIImage imageNamed:@"shanchu"];
    [whiteView addSubview:deleteImageView];
    [deleteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(whiteView.mas_centerY);
        make.left.mas_equalTo(whiteView.mas_left).mas_offset(12);
        make.size.mas_equalTo(CGSizeMake(20, 18));
    }];
    UILabel * deleteLabel = [[UILabel alloc]init];
    deleteLabel.text = @"删除";
    deleteLabel.font =[UIFont systemFontOfSize:17.0];
    deleteLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    [whiteView addSubview:deleteLabel];
    [deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(whiteView.mas_centerY);
        make.left.mas_equalTo(deleteImageView.mas_right).mas_offset(15);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
}
-(void)tapClick
{
    [backView removeFromSuperview];
    [UIView animateWithDuration:0.1 animations:^{
        whiteView.center =CGPointMake(Main_Screen_Width/2, Main_Screen_Height+25);
    }];
}
#pragma mark----删除操作
-(void)delatetapClick
{
    
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"ActivityCode":@(self.ActivityCode),
                             @"DeleteType":@(self.DeleteType)
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/DeleteActiveInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"--%@",dict);
        if ([dict[@"ResultCode"]isEqualToString:@"F000000"]) {
            [self.view showInfo:@"删除成功" autoHidden:YES];
            [backView removeFromSuperview];
            [whiteView removeFromSuperview];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.view showInfo:@"删除失败，请重试" autoHidden:YES];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
@end
