//
//  MyViewController.m
//  CarWashing
//
//  Created by apple on 2017/11/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MyViewController.h"
#import "MyTableViewCell.h"
#import "DSUserInfoController.h"
#import "DSSettingController.h"
#import "DSMembershipController.h"
#import "DSOrderController.h"
#import "DSFavoritesController.h"
#import "DSExchangeController.h"
#import "DSServiceController.h"
#import "DSMyCarController.h"
#import "DSMemberRightsController.h"
#import "DSMyCardController.h"
#import "DSRecommendController.h"
#import "DSCardGroupController.h"

#import "UIImageView+WebCache.h"

#import "PopupView.h"
#import "LewPopupViewAnimationDrop.h"

#import "ShareWeChatController.h"
#import "HTTPDefine.h"
#import "AppDelegate.h"
#import "HYActivityView.h"
#import "UdStorage.h"
#import "AFNetworkingTool.h"
#import "LCMD5Tool.h"

#import "RemindViewController.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource,SetTabBarDelegate>
{
        
    NSString *title;
    UIImage *image;
    NSURL *url;
    enum WXScene scene;
    NSArray *activity;
    UIButton * signBtn;
    NSString *currentTimeString;
}
@property (nonatomic, strong) HYActivityView *activityView;
@property (nonatomic, strong) UITableView *MyListView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIImageView *headerImageView;
@end

@implementation MyViewController
- (void) drawContent {
    self.statusView.hidden      = YES;
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%ld",APPDELEGATE.currentUser.UserScore);
    NSLog(@"%ld",(long)APPDELEGATE.currentUser.Level_id);
    [self.MyListView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMdd"];
    NSDate *datenow = [NSDate date];
    currentTimeString = [formatter stringFromDate:datenow];
    
    [self setupUI];
    [self.contentView addSubview:self.MyListView];
    UIView * headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 190)];
    self.MyListView.tableHeaderView = headerView;
    UIView * footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    footView.backgroundColor=RGBAA(242, 242, 242, 1.0);
    self.MyListView.tableFooterView = footView;
    
    UIView * topVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    topVIew.backgroundColor=[UIColor whiteColor];
    [headerView addSubview:topVIew];
    UIView * leneIew=[[UIView alloc]initWithFrame:CGRectMake(0, 100, Main_Screen_Width, 10)];
    leneIew.backgroundColor=RGBAA(242, 242, 242, 1.0);
    [headerView addSubview:leneIew];
    UIView * bottpmVIew=[[UIView alloc]initWithFrame:CGRectMake(0, 110, Main_Screen_Width, 80)];
    bottpmVIew.backgroundColor=[UIColor whiteColor];
    [headerView addSubview:bottpmVIew];
    //头像
    _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 70, 70)];
    _headerImageView.backgroundColor=[UIColor redColor];
    _headerImageView.layer.cornerRadius = 70/2;
    _headerImageView.layer.masksToBounds = YES;
    NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,APPDELEGATE.currentUser.userImagePath];
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"huiyuantou"]];
    _headerImageView.userInteractionEnabled = YES;
    [topVIew addSubview:_headerImageView];
    UITapGestureRecognizer  *tapInformation = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapInformationClick)];
    [_headerImageView addGestureRecognizer:tapInformation];
    //手机号
    _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(105, 24, 200, 20)];
    _userNameLabel.text = @"13071076158";
    _userNameLabel.textColor =[UIColor colorFromHex:@"#3f3f3f"];
    _userNameLabel.font=[UIFont systemFontOfSize:18.0];
    _userNameLabel.text=[NSString stringWithFormat:@"%@",APPDELEGATE.currentUser.userName];
    [topVIew addSubview:_userNameLabel];
    //类型imageVIew
    UIImageView * typeIamegView = [[UIImageView  alloc]initWithFrame:CGRectMake(105, 55, 90, 24)];
    typeIamegView.image = [UIImage imageNamed:@"churujianghu"];
    [topVIew addSubview:typeIamegView];
    NSUInteger num = APPDELEGATE.currentUser.Level_id;
    
    if (num == 1) {
        typeIamegView.image = [UIImage imageNamed:@"churujianghu"];
    }else if (num == 2){
       typeIamegView.image = [UIImage imageNamed:@"churujianghu"];
    }else if (num == 3){
       typeIamegView.image = [UIImage imageNamed:@"churujianghu"];
    }else if (num == 4){
       typeIamegView.image = [UIImage imageNamed:@"churujianghu"];
    }else if (num == 5){
       typeIamegView.image = [UIImage imageNamed:@"churujianghu"];
    }else if (num == 6){
       typeIamegView.image = [UIImage imageNamed:@"churujianghu"];
    }else {
       typeIamegView.image = [UIImage imageNamed:@"churujianghu"];
    }
    //签到button
    signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [signBtn setImage:[UIImage imageNamed:@"qiandaoMy"] forState:UIControlStateNormal];
//    if([[UdStorage getObjectforKey:@"SignTime"] intValue]<[currentTimeString intValue]){
//       [signBtn setImage:[UIImage imageNamed:@"qiandaoMy"] forState:UIControlStateNormal];
//    }else{
//        [signBtn setImage:[UIImage imageNamed:@"yiqiandao"] forState:UIControlStateNormal];
//    }
    [signBtn addTarget:self action:@selector(signButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [topVIew addSubview:signBtn];
    [signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topVIew.mas_centerY);
        make.right.mas_equalTo(topVIew.mas_right).mas_offset(-15);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(25);
    }];
    NSArray * bottomImage =@[@"dingdanMy",@"shoucangMy",@"jihuoMy",@"wodeziliaoMy"];
    NSArray * titleArray =@[@"订单",@"收藏",@"激活",@"我的资料"];
    for (int i=0;i<4;i++){
        UIButton * FourBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        FourBtn.frame =CGRectMake(i*Main_Screen_Width/4, 17, Main_Screen_Width/4, 22);
        [FourBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",bottomImage[i]]] forState:UIControlStateNormal];
        [bottpmVIew addSubview:FourBtn];
        
        //四个
        UILabel * FourLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*Main_Screen_Width/4, 45, Main_Screen_Width/4, 30)];
        FourLabel.textAlignment = NSTextAlignmentCenter;
        FourLabel.textColor=[UIColor colorFromHex:@"#3f3f3f"];
        FourLabel.font=[UIFont systemFontOfSize:13.0];
        FourLabel.text =[NSString stringWithFormat:@"%@",titleArray[i]];
        [bottpmVIew addSubview:FourLabel];
        
        UIButton * clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clickBtn.frame =CGRectMake(i*Main_Screen_Width/4, 0, Main_Screen_Width/4, 80);
        clickBtn.tag=i+1;
        [clickBtn addTarget:self action:@selector(FourBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottpmVIew addSubview:clickBtn];
        
    }
    //通知
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(noticeupdateUserName:) name:@"updatenamesuccess" object:nil];
    
    [center addObserver:self selector:@selector(noticeupdateUserheadimg:) name:@"updateheadimgsuccess" object:nil];
    
}
- (void)setupUI {
    
    UIView *titleView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, 64) color:[UIColor colorFromHex:@"#0161a1"]];
    titleView.top                      = 0;
    
    NSString *titleName              = @"我的";
    UIFont *titleNameFont            = [UIFont boldSystemFontOfSize:18];
    UILabel *titleNameLabel          = [UIUtil drawLabelInView:titleView frame:[UIUtil textRect:titleName font:titleNameFont] font:titleNameFont text:titleName isCenter:NO];
    titleNameLabel.textColor         = [UIColor whiteColor];
    titleNameLabel.centerX           = titleView.centerX;
    titleNameLabel.centerY           = titleView.centerY +8;
    [titleView addSubview:titleNameLabel];
    
}
- (UITableView *)MyListView {
    if (nil == _MyListView) {
        _MyListView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64-49)];
        _MyListView.rowHeight = 50;
        _MyListView.delegate=self;
        _MyListView.dataSource = self;
        _MyListView.backgroundColor=RGBAA(242, 242, 242, 1.0);
        _MyListView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _MyListView.showsVerticalScrollIndicator = NO;
    }
    return _MyListView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        return 1;
    }else if (section==1){
        return 4;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellID";
    MyTableViewCell * cell = [_MyListView dequeueReusableCellWithIdentifier:cellID];
    if(cell==nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyTableViewCell" owner:self options:nil]lastObject];
    }
    NSArray * section2 =@[@"我的爱车",@"我的卡包",@"客服咨询",@"车辆提醒"];
    NSArray * section3 =@[@"推荐蔷薇APP",@"设置"];
    NSArray * sectionimage =@[@"wodeaiche",@"wodekabao",@"kefuMy",@"cheliangtixing"];
    NSArray * sectionimage3 =@[@"tuijianAPP",@"shezhiMy"];
    if(indexPath.section==0){
        cell.interLabel.text       = [NSString stringWithFormat:@"%ld积分",APPDELEGATE.currentUser.UserScore];
        cell.typeImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"qiangweihuiyuan"]];
    }else if(indexPath.section==1){
        if(indexPath.row==0){
            cell.typeiamgeWidth.constant = 19;
            cell.disTanceConstraint.constant = 15;
        }else{
            cell.typeiamgeWidth.constant = 17;
            cell.disTanceConstraint.constant = 17;
        }
        cell.interLabel.text= @"";
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",section2[indexPath.row]];
        cell.typeImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",sectionimage[indexPath.row]]];
    }else if (indexPath.section==2){
        cell.typeiamgeWidth.constant = 17;
        cell.disTanceConstraint.constant = 17;
        cell.interLabel.text= @"";
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",section3[indexPath.row]];
        cell.typeImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",sectionimage3[indexPath.row]]];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 10)];
    lineView.backgroundColor=RGBAA(242, 242, 242, 1.0);
    return lineView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0){
        DSMembershipController *membershipController        = [[DSMembershipController alloc]init];
        membershipController.hidesBottomBarWhenPushed       = YES;
        [self.navigationController pushViewController: membershipController animated: YES];
    }else if (indexPath.section==1){
        if (indexPath.row==0){//我的爱车
            DSMyCarController *myCarController                  = [[DSMyCarController alloc]init];
            myCarController.hidesBottomBarWhenPushed            = YES;
            [self.navigationController pushViewController:myCarController animated:YES];
        }else if (indexPath.row==1){//我的卡包
            DSCardGroupController *cardGroupController      = [[DSCardGroupController alloc]init];
            cardGroupController.hidesBottomBarWhenPushed    = YES;
            [self.navigationController pushViewController:cardGroupController animated:YES];
        }else if (indexPath.row==2){//我的咨询
            DSServiceController *serviceVC          = [[DSServiceController alloc]init];
            serviceVC.hidesBottomBarWhenPushed      = YES;
            [self.navigationController pushViewController:serviceVC animated:YES];
        }else if (indexPath.row==3){//车辆提醒
            RemindViewController *new = [[RemindViewController alloc]init];
            new.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:new animated:YES];
        }
    }else if(indexPath.section==2){
        if(indexPath.row==0){
            if (!self.activityView)
            {
                self.activityView = [[HYActivityView alloc]initWithTitle:@"" referView:self.view];
                self.activityView.delegate = self;
                //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
                self.activityView.numberOfButtonPerLine = 6;
                
                ButtonView *bv ;
                
                bv = [[ButtonView alloc]initWithText:@"微信" image:[UIImage imageNamed:@"btn_share_weixin"] handler:^(ButtonView *buttonView){
                    NSLog(@"点击微信");
                    NSDictionary *mulDic = @{
                                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                             @"ShareType":@3
                                             };
                    NSDictionary *params = @{
                                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                             };
                    
                    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@InviteShare/UserShare",Khttp] success:^(NSDictionary *dict, BOOL success) {
                        NSLog(@"%@",dict);
                        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
                        {
                            //创建发送对象实例
                            SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
                            sendReq.bText = NO;//不使用文本信息
                            sendReq.scene = 0;//0 = 好友列表 1 = 朋友圈 2 = 收藏
                            
                            //创建分享内容对象
                            WXMediaMessage *urlMessage = [WXMediaMessage message];
                            urlMessage.title = [[dict objectForKey:@"JsonData"] objectForKey:@"ShareTitle"];//分享标题
                            urlMessage.description = [[dict objectForKey:@"JsonData"] objectForKey:@"ShareContent"];//分享描述
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
                    
                    
                    self.tabBarController.tabBar.hidden = NO;
                    
                }];
                [self.activityView addButtonView:bv];
                
                bv = [[ButtonView alloc]initWithText:@"微信朋友圈" image:[UIImage imageNamed:@"btn_share_pengyouquan"] handler:^(ButtonView *buttonView){
                    NSLog(@"点击微信朋友圈");
                    NSDictionary *mulDic = @{
                                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                             @"ShareType":@3
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
                            urlMessage.title = [[dict objectForKey:@"JsonData"] objectForKey:@"ShareTitle"];//分享标题
                            urlMessage.description = [[dict objectForKey:@"JsonData"] objectForKey:@"ShareContent"];//分享描述
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
                    
                    self.tabBarController.tabBar.hidden = NO;
                    
                }];
                [self.activityView addButtonView:bv];
                
            }
            self.tabBarController.tabBar.hidden = YES;
            
            [self.activityView show];
            
        }else if (indexPath.row==1){//设置
            DSSettingController *settingVC              = [[DSSettingController alloc]init];
            settingVC.hidesBottomBarWhenPushed          = YES;
            [self.navigationController pushViewController:settingVC animated:YES];
        }
    }
}
#pragma mark--签到
- (void) signButtonClick:(id)sender {
    
    if([UdStorage getObjectforKey:@"SignTime"])
    {
        if([[UdStorage getObjectforKey:@"SignTime"] intValue]<[currentTimeString intValue])
        {
            NSDictionary *mulDic = @{
                                     @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"]
                                     };
            NSDictionary *params = @{
                                     @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                     @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                     };
            [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@User/AddUserSign",Khttp] success:^(NSDictionary *dict, BOOL success) {
                if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
                {
                    [signBtn setImage:[UIImage imageNamed:@"yiqiandao"] forState:UIControlStateNormal];
                    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
                    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
                    [inputFormatter setDateFormat:@"yyyy/MM/dd"];
                    NSDate* inputDate = [inputFormatter dateFromString:[[dict objectForKey:@"JsonData"] objectForKey:@"SignTime"]];
                    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                    [outputFormatter setLocale:[NSLocale currentLocale]];
                    [outputFormatter setDateFormat:@"yyyyMMdd"];
                    NSString *targetTime = [outputFormatter stringFromDate:inputDate];
                    [UdStorage storageObject:targetTime forKey:@"SignTime"];
                    APPDELEGATE.currentUser.UserScore = APPDELEGATE.currentUser.UserScore + 10;
                    [UdStorage storageObject:[NSString stringWithFormat:@"%ld",APPDELEGATE.currentUser.UserScore] forKey:@"UserScore"];
                    PopupView *view = [PopupView defaultPopupView];
                    view.parentVC = self;
                        
                    [self.MyListView reloadData];
                        
                    [self lew_presentPopupView:view animation:[LewPopupViewAnimationDrop new] dismissed:^{
                            
                    }];
                }
                    
                else
                {
                    [self.view showInfo:@"签到失败" autoHidden:YES interval:2];
                }
                    
                    
                    
               } fail:^(NSError *error) {
                [self.view showInfo:@"签到失败" autoHidden:YES interval:2];
            }];
                
        }
        else
        {
            [signBtn setImage:[UIImage imageNamed:@"yiqiandao"] forState:UIControlStateNormal];
            [self.view showInfo:@"今天已经签过到了" autoHidden:YES interval:2];
        }
    }
    else
    {
        NSDictionary *mulDic = @{
                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"]
                                 };
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@User/AddUserSign",Khttp] success:^(NSDictionary *dict, BOOL success) {
                
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                    
                NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
                [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
                    [inputFormatter setDateFormat:@"yyyy/MM/dd"];
                NSDate* inputDate = [inputFormatter dateFromString:[[dict objectForKey:@"JsonData"] objectForKey:@"SignTime"]];
                NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                [outputFormatter setLocale:[NSLocale currentLocale]];
                [outputFormatter setDateFormat:@"yyyyMMdd"];
                NSString *targetTime = [outputFormatter stringFromDate:inputDate];
                    
                [UdStorage storageObject:targetTime forKey:@"SignTime"];
                
                APPDELEGATE.currentUser.UserScore = APPDELEGATE.currentUser.UserScore + 10;
                    
                [UdStorage storageObject:[NSString stringWithFormat:@"%ld",APPDELEGATE.currentUser.UserScore] forKey:@"UserScore"];
                    
                [self.MyListView reloadData];
                PopupView *view = [PopupView defaultPopupView];
                view.parentVC = self;
                [self lew_presentPopupView:view animation:[LewPopupViewAnimationDrop new] dismissed:^{
                }];
            }
            else
            {
                [self.view showInfo:@"签到失败" autoHidden:YES interval:2];
            }
        } fail:^(NSError *error) {
            [self.view showInfo:@"签到失败" autoHidden:YES interval:2];
        }];
    }
}
#pragma mark-----的哥按钮点击时间
-(void)FourBtnClick:(UIButton*)btn
{
    if (btn.tag==1){//我的订单
        DSOrderController *orderVC              = [[DSOrderController alloc]init];
        orderVC.hidesBottomBarWhenPushed        = YES;
        [self.navigationController pushViewController:orderVC animated:YES];
        //统计广告fang
        [MobClick event:@"advertiVisit"];
    }else if (btn.tag==2){//我的收藏
        DSFavoritesController *favoritesVC      = [[DSFavoritesController alloc]init];
        favoritesVC.hidesBottomBarWhenPushed    = YES;
        [self.navigationController pushViewController:favoritesVC animated:YES];
    }else if (btn.tag==3){//激活
        DSExchangeController *exchangeVC        = [[DSExchangeController alloc]init];
        exchangeVC.hidesBottomBarWhenPushed     = YES;
        [self.navigationController pushViewController:exchangeVC animated:YES];
    }else if (btn.tag==4){//我的资料
        DSUserInfoController *userInfoController    = [[DSUserInfoController alloc]init];
        userInfoController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userInfoController animated:YES];
    }
}
-(void)tapInformationClick
{
    DSUserInfoController *userInfoController    = [[DSUserInfoController alloc]init];
    userInfoController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoController animated:YES];
}
#pragma mark---通知
-(void)noticeupdateUserName:(NSNotification *)sender{
    self.userNameLabel.text = APPDELEGATE.currentUser.userName;
}
-(void)noticeupdateUserheadimg:(NSNotification *)sender{
        //    UIImageView *imageV = [[UIImageView alloc]init];
        //    NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,APPDELEGATE.currentUser.userImagePath];
        //    NSURL *url=[NSURL URLWithString:ImageURL];
        //    [imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"touxiang"]];
        
    NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,APPDELEGATE.currentUser.userImagePath];
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"huiyuantou"]];
}
#pragma mark - modal代理
- (void)setTabBarIsHide:(UIViewController *)VC {
    
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - 变白
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
